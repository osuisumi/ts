package com.haoyu.user.service.impl;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.auth.dao.IAuthUserBizDao;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.index.entity.Loginer;
import com.haoyu.ipanther.common.excel.ExcelExport;
import com.haoyu.ipanther.common.excel.ExcelImport;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.user.dao.IAccountDao;
import com.haoyu.user.dao.IUserDao;
import com.haoyu.user.entity.Account;
import com.haoyu.user.entity.User;
import com.haoyu.user.entity.UserDept;
import com.haoyu.user.excel.TeacherExport;
import com.haoyu.user.excel.UserExport;
import com.haoyu.user.excel.UserModel;
import com.haoyu.user.service.IUserService;
import com.haoyu.user.utils.AccountState;

@Service
public class UserServiceImpl implements IUserService{
	
	@Resource
	private IUserDao userDao;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IAccountDao accountDao;
	@Resource
	private IDepartmentService departmentService;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IAuthUserBizDao authUserBizDao;

	@Override
	public Loginer getLoginer(Loginer loginer) {
		loginer.setPassword(DigestUtils.md5Hex(loginer.getPassword()));
		return userDao.getLoginer(loginer);
	}
	
	@Override
	public List<User> list(SearchParam searchParam, PageBounds pageBounds) {
		return userDao.select(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Response create(User user) {
		Account account = user.getAccount();
		UserDept userDept = user.getUserDept();
		if (StringUtils.isEmpty(user.getId())) {
			user.setId(Identities.uuid2());
		}
		user.setDefaultValue();
		int count = userDao.insert(user);
		if (count > 0) {
			if (StringUtils.isEmpty(account.getId())) {
				account.setId(Identities.uuid2());
			}
			account.setUser(user);
			account.setPassword(DigestUtils.md5Hex(account.getPassword()));
			account.setState(AccountState.NORMAL);
			account.setDefaultValue();
			count = accountDao.insert(account);
			if (count > 0) {
				if (StringUtils.isEmpty(userDept.getId())) {
					userDept.setId(Identities.uuid2());
				}
				userDept.setUserId(user.getId());
				count = userDao.insertUserDept(userDept);
				if (count > 0) {
					return authRoleService.addUsersToRole(user.getAuthRole(), Lists.newArrayList(user.getId()), null);
				}
			}
		}
		return count>0?Response.successInstance():Response.failInstance();
	}
	
	@Override
	public Response update(User user) {
		Account account = user.getAccount();
		UserDept userDept = user.getUserDept();
		user.setUpdatedby(ThreadContext.getUser());
		user.setUpdateTime(System.currentTimeMillis());
		int count = userDao.update(user);
		if (count > 0 && account!=null) {
			if(StringUtils.isNotEmpty(account.getPassword())){
				account.setPassword(DigestUtils.md5Hex(account.getPassword()));
			}
			account.setUpdatedby(ThreadContext.getUser());
			account.setUpdateTime(System.currentTimeMillis());
			count = accountDao.update(account);
			if (count > 0 && userDept!=null) {
				count = userDao.updateUserDept(userDept);
				if (count > 0) {
					count = authUserBizDao.updateAuthUserRole(user);
				}
			}
		}
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public User get(String id) {
		return userDao.selectById(id);
	}

	@Override
	public int getCount(Map<String, Object> map) {
		return userDao.getCount(map);
	}

	@Override
	public Response delete(User user) {
		String[] idArray = user.getId().split(",");
		List<String> ids = Arrays.asList(idArray);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		user.setUpdatedby(ThreadContext.getUser());
		user.setUpdateTime(System.currentTimeMillis());
		param.put("entity", user);
		int count = userDao.deleteByIds(param);
		if (count > 0) {
			Map<String, Object> param1 = Maps.newHashMap();
			param1.put("userIds", ids);
			Account account = new Account();
			account.setUpdatedby(ThreadContext.getUser());
			account.setUpdateTime(System.currentTimeMillis());
			param1.put("entity", account);
			accountDao.deleteByIds(param1);
		}
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Map<String, Object> importUser(User user, String url, String deptId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<UserExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<UserModel> ei = new ExcelImport<UserModel>(UserModel.class);
		Collection<UserModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		List<UserExport> exportList = Lists.newArrayList();
		for (UserModel um : list) {
			UserExport userExport = new UserExport();
			int dataRow = um.getLineNumber();
			
			Map<String, Object> param = Maps.newHashMap();
			param.put("userName", um.getUserName());
			param.put("paperworkNo", um.getPaperworkNo());
			List<User> users = userDao.select(param, null);
			if (Collections3.isNotEmpty(users)) {
				if (users.get(0).getAccount().getUserName().equals(um.getUserName())) {
					userExport.setMsg("导入失败,第" + dataRow + "行,用户名已存在");
					failList.add("第" + dataRow + "行,用户名已存在");
				}else{
					userExport.setMsg("导入失败,第" + dataRow + "行,身份证号已存在");
					failList.add("第" + dataRow + "行,身份证号已存在");
				}
				exportList.add(userExport);
			}else {
				SearchParam searchParam = new SearchParam();
				searchParam.getParamMap().put("deptNameEquils", um.getDeptName());
				List<Department> departments = departmentService.list(searchParam, null);
				if (Collections3.isEmpty(departments)) {
					userExport.setMsg("导入失败,第" + dataRow + "行,所在单位不存在");
					failList.add("第" + dataRow + "行,所在单位不存在");
					exportList.add(userExport);
				}else{
					if(StringUtils.isNotEmpty(deptId) && !deptId.equals(departments.get(0).getId())){
						userExport.setMsg("导入失败,第" + dataRow + "行,您没有权限导入其他单位的教师");
						failList.add("第" + dataRow + "行,您没有权限导入其他单位的教师");
						exportList.add(userExport);
					}else{
						Account account = new Account();
						account.setUserName(um.getUserName());
						account.setPassword(um.getPassword());
						UserDept userDept = new UserDept();
						userDept.setDeptId(departments.get(0).getId());
						AuthRole authRole = new AuthRole();
						authRole.setId(user.getAuthRole().getId());
						User u = new User();
						u.setAuthRole(authRole);
						u.setAccount(account);
						u.setUserDept(userDept);
						u.setRealName(um.getRealName());
						u.setPaperworkNo(um.getPaperworkNo());
						u.setPhone(um.getPhone());
						u.setEmail(um.getEmail());
						u.setSex(DictionaryUtils.getEntryValue("SEX", um.getSex()));
						u.setPost(DictionaryUtils.getEntryValue("POST", um.getPost()));
						this.create(u);
						try {
							PropertyUtils.copyProperties(userExport, um);
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							e.printStackTrace();
						} catch (NoSuchMethodException e) {
							e.printStackTrace();
						}
						userExport.setMsg("导入成功");
						successList.add(userExport);
					}
				}
			}
		}
		resultMap.put("successList", successList);
		resultMap.put("failList", failList);
		return resultMap;
	}

	@Override
	public void exportUser(SearchParam searchParam, HttpServletResponse response) {
		List<User> users = this.list(searchParam, null);
		if (Collections3.isNotEmpty(users)) {
			ExcelExport<UserExport> excelExport = new ExcelExport<UserExport>(UserExport.class);
			List<UserExport> dataList = Lists.newArrayList();
			for (User user : users) {
				UserExport userExport = new UserExport();
				if (user.getDepartment() != null) {
					userExport.setDeptName(user.getDepartment().getDeptName());
				}
				userExport.setEmail(user.getEmail());
				userExport.setPaperworkNo(user.getPaperworkNo());
				userExport.setPhone(user.getPhone());
				userExport.setRealName(user.getRealName());
				userExport.setUserName(user.getAccount().getUserName());
				userExport.setRoleName(user.getAuthRole().getName());
				dataList.add(userExport);
			}
			try {
				response.setCharacterEncoding("GBK");
				String outName = "导出用户信息"+DateFormatUtils.format(new Date(), "yyyy-MM-dd");
				outName = new String(outName.getBytes("GBK"),"ISO-8859-1");
				response.setContentType("application/xls;charset=GBK");
				response.setHeader("Content-disposition", "attachment; filename="+ outName + ".xls");
				excelExport.exportExcel(dataList, response.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			try {
				response.setContentType("text/plain;charset=UTF-8");
				response.getWriter().write("没有该期次, 请检查期次名");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void exportTeacher(SearchParam searchParam, HttpServletResponse response) {
		List<User> users = this.list(searchParam, null);
		if (Collections3.isNotEmpty(users)) {
			ExcelExport<TeacherExport> excelExport = new ExcelExport<TeacherExport>(TeacherExport.class);
			List<TeacherExport> dataList = Lists.newArrayList();
			for (User user : users) {
				TeacherExport teacherExport = new TeacherExport();
				teacherExport.setDeptName(user.getDepartment().getDeptName());
				teacherExport.setEmail(user.getEmail());
				teacherExport.setPaperworkNo(user.getPaperworkNo());
				teacherExport.setPhone(user.getPhone());
				teacherExport.setPost(DictionaryUtils.getEntryName("POST", user.getPost()));
				teacherExport.setRealName(user.getRealName());
				teacherExport.setSex(DictionaryUtils.getEntryName("SEX", user.getSex()));
				teacherExport.setUserName(user.getAccount().getUserName());
				dataList.add(teacherExport);
			}
			try {
				response.setCharacterEncoding("GBK");
				String outName = "导出教室信息"+DateFormatUtils.format(new Date(), "yyyy-MM-dd");
				outName = new String(outName.getBytes("GBK"),"ISO-8859-1");
				response.setContentType("application/xls;charset=GBK");
				response.setHeader("Content-disposition", "attachment; filename="+ outName + ".xls");
				excelExport.exportExcel(dataList, response.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			try {
				response.setContentType("text/plain;charset=UTF-8");
				response.getWriter().write("没有该期次, 请检查期次名");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public Response updateUserDept(UserDept userDept) {
		return userDao.updateUserDept(userDept)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response resetPassword(User user) {
		String[] idArray = user.getId().split(",");
		List<String> ids = Arrays.asList(idArray);
		Map<String, Object> param = Maps.newHashMap();
		param.put("userIds", ids);
		Account account = new Account();
		account.setUpdatedby(ThreadContext.getUser());
		account.setUpdateTime(System.currentTimeMillis());
		account.setPassword(DigestUtils.md5Hex("888888"));
		param.put("entity", account);
		int count = accountDao.updateByIds(param);
		return count>0?Response.successInstance():Response.failInstance();
	}
	
}
