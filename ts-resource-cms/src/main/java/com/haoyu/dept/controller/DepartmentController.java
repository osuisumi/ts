package com.haoyu.dept.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.user.utils.AuthRoleEnum;

@Controller
@RequestMapping("dept")
public class DepartmentController extends AbstractBaseController{
	
	@Resource
	private IDepartmentService departmentService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole(AuthRoleEnum.SCHOOL_ADMIN.getCode())) {
			Department department = departmentService.get(((Loginer)Loginer.getLoginer(request)).getDeptId());
			model.addAttribute("departments", Lists.newArrayList(department));
		}else{
			model.addAttribute("departments", departmentService.list(searchParam, getPageBounds(10, true)));
		}
		return "dept/list_department";
	}
	
	@RequestMapping(value="listData", method=RequestMethod.GET)
	@ResponseBody
	public String listData(SearchParam searchParam, Model model){
		List<Department> departments = departmentService.list(searchParam, null);
		return new JsonMapper().toJson(departments);
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Department department, Model model){
		model.addAttribute("department", department);
		return "dept/edit_department";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Department department, Model model){
		model.addAttribute("department", departmentService.get(department.getId()));
		return "dept/edit_department";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(Department department){
		return departmentService.create(department);
		
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Department department){
		return departmentService.update(department);
		
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Department department){
		return departmentService.delete(department);
	}

	@RequestMapping(value="count", method=RequestMethod.GET)
	@ResponseBody
	public int count(SearchParam searchParam){
		int count = departmentService.getCount(searchParam.getParamMap());
		return count;
	}
}
