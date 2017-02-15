package com.haoyu.user.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.auth.service.IAuthUserBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.login.Loginer;
import com.haoyu.user.entity.User;
import com.haoyu.user.service.IUserService;
import com.haoyu.user.utils.AuthRoleEnum;

@Controller
@RequestMapping("user")
public class UserController extends AbstractBaseController{
	
	@Resource
	private IUserService userService;
	@Resource
	private IAuthUserBizService authUserBizService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		String roleId = (String) searchParam.getParamMap().get("roleId");
		if(AuthRoleEnum.TEACHER.getId().equals(roleId)){
			Subject currentUser = SecurityUtils.getSubject();
			if (currentUser.hasRole(AuthRoleEnum.SCHOOL_ADMIN.getCode())) {
				searchParam.getParamMap().put("deptId", ((com.haoyu.index.entity.Loginer)Loginer.getLoginer(request)).getDeptId());
			}
			model.addAttribute("users", userService.list(searchParam, getPageBounds(10, true)));
			return "user/list_teacher";
		}else{
			model.addAttribute("users", userService.list(searchParam, getPageBounds(10, true)));
			return "user/list_user";
		}
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(User user, Model model){
		model.addAttribute("user", user);
		if(user.getAuthRole() != null && AuthRoleEnum.TEACHER.getId().equals(user.getAuthRole().getId())){
			return "user/edit_teacher";
		}else{
			return "user/edit_user";
		}
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(User user, Model model){
		if(user.getAuthRole() != null && AuthRoleEnum.TEACHER.getId().equals(user.getAuthRole().getId())){
			model.addAttribute("user", userService.get(user.getId()));
			return "user/edit_teacher";
		}else{
			model.addAttribute("user", userService.get(user.getId()));
			return "user/edit_user";
		}
	}
	
	@RequestMapping(value="{id}/editUserRole", method=RequestMethod.GET)
	public String editRole(User user, Model model){
		model.addAttribute("user", userService.get(user.getId()));
		return "user/edit_user_role";
	}
	
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(User user){
		return userService.create(user);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(User user){
		return userService.update(user);
	}
	
	@RequestMapping(value="count", method=RequestMethod.GET)
	@ResponseBody
	public int count(SearchParam searchParam){
		int count = userService.getCount(searchParam.getParamMap());
		return count;
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(User user){
		return userService.delete(user);
	}
	
	@RequestMapping(value="goImport", method=RequestMethod.GET)
	public String goImport(User user, Model model){
		return "user/import_user";
	}
	
	@RequestMapping("importUser")
	public String importAuthUser(User user ,String url, Model model){
		String deptId = null;
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole(AuthRoleEnum.SCHOOL_ADMIN.getCode())) {
			deptId = ((com.haoyu.index.entity.Loginer)Loginer.getLoginer(request)).getDeptId();
		}
		model.addAttribute("resultMap", userService.importUser(user, url, deptId));
		return "user/import_result";
	}

	@RequestMapping(value="exportTeacher", method=RequestMethod.GET)
	public void exportTeacher(SearchParam searchParam, HttpServletResponse response){
		userService.exportTeacher(searchParam, response);
	}
	
	@RequestMapping(value="exportUser", method=RequestMethod.GET)
	public void exportUser(SearchParam searchParam, HttpServletResponse response){
		userService.exportUser(searchParam, response);
	}
	
	@RequestMapping(value="updateUserRole", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateUserRole(User user){
		return authUserBizService.updateUserRole(user);
	}
	
	@RequestMapping(value="createUserRole",method=RequestMethod.POST)
	@ResponseBody
	public Response createUserRole(User user){
		return  authUserBizService.createUserRole(user);
	}
	
	/**
	 * 获取用户的信息
	 */
	@RequestMapping(value="userInfos", method=RequestMethod.POST)
	@ResponseBody
	public List<User> getUserInfos(){
		  SearchParam sp = new SearchParam();
		  sp.setParamMap(new HashMap<String,Object>());
		  List<User> users = userService.list(sp, null);
		  return users;
	}
	
	@RequestMapping(value="resetPassword")
	@ResponseBody
	public Response resetPassword(User user){
		return userService.resetPassword(user);
	}
	
}
