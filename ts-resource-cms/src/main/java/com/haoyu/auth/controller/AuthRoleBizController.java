package com.haoyu.auth.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.haoyu.auth.service.IAuthRoleBizService;
import com.haoyu.menu.controller.MenuController;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("auth/role")
public class AuthRoleBizController extends AbstractBaseController{
	
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IAuthRoleBizService authRoleBizService;
	@Resource
	private IAuthMenuService authMenuService; 
	
	@RequestMapping("listData")
	@ResponseBody
	public List<AuthRole> listRoleData(){
		return authRoleService.findRoleByNameAndRelation(null, null);
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		model.addAttribute("roles", authRoleBizService.list(searchParam, getPageBounds(10, true)));
		return "role/list_role";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(AuthRole authRole, Model model){
		model.addAttribute("role", authRole);
		return "role/edit_role";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(AuthRole authRole, Model model){
		model.addAttribute("role", authRoleBizService.get(authRole.getId()));
		return "role/edit_role";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(AuthRole authRole){
		return authRoleBizService.create(authRole);
		
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(AuthRole authRole){
		return authRoleBizService.update(authRole);
		
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(AuthRole authRole){
		return authRoleBizService.delete(authRole);
	}
	
	@RequestMapping(value="{id}/editRoleMenu", method=RequestMethod.GET)
	public String editRoleMenu(AuthRole authRole, Model model){
		List<AuthMenu> menus = authMenuService.findMenuByRoles(Lists.newArrayList(authRole), false);
		model.addAttribute("menus", Collections3.extractToList(menus, "id")); 
		model.addAttribute("menuTree",authMenuService.findMenu(new AuthMenu(), true));
		model.addAttribute("authRole", authRole);
		return "role/edit_role_menu";
	}
	
	@RequestMapping(value="updateRoleMenu", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateRoleMenu(AuthRole authRole){
		return authRoleBizService.updateRoleMenu(authRole);
		
	}
}
