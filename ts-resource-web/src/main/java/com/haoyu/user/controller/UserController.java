package com.haoyu.user.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.user.entity.Account;
import com.haoyu.user.entity.User;
import com.haoyu.user.service.IAccountService;
import com.haoyu.user.service.IUserService;
import com.haoyu.user.utils.AccountState;

@Controller
@RequestMapping("user")
public class UserController extends AbstractBaseController{
	
	@Resource
	private IUserService userService;
	@Resource
	private IDepartmentService departmentService;
	@Resource
	private IAccountService accountService;
	
	@RequestMapping("goEditUserDept")
	public String goEditUserDept(Model model){
		User user = userService.get(ThreadContext.getUser().getId());
		List<Department> departments = departmentService.list(new SearchParam(), null);
		model.addAttribute("user", user);
		model.addAttribute("departments", departments);
		return "user/edit_user_dept";
	}
	
	@RequestMapping("updateUserDept")
	@ResponseBody
	public Response updateUserDept(User user){
		Response response = userService.updateUserDept(user.getUserDept());
		if (response.isSuccess()) {
			Account account = user.getAccount();
			account.setState(AccountState.NORMAL);
			response  = accountService.update(account);
			if (response.isSuccess()) {
				Loginer loginer = (Loginer) Loginer.getLoginer(request);
				loginer.setDeptId(user.getUserDept().getId());
				loginer.setDeptName(user.getDepartment().getDeptName());
				loginer.setState(AccountState.NORMAL);
			}
		}
		return response;
	}
	
	@RequestMapping("count")
	@ResponseBody
	public Integer isUserNameExist(SearchParam searchParam){
		return  userService.getCount(searchParam.getParamMap());
	}

}
