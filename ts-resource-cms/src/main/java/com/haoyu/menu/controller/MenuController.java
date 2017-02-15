package com.haoyu.menu.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.menu.service.IMenuService;
import com.haoyu.menu.util.DataGrid;
import com.haoyu.menu.util.Node;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.login.Loginer;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("menu")
public class MenuController extends AbstractBaseController{

	@Resource
	private IAuthMenuService authMenuService;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IMenuService menuService;

	@RequestMapping("getAuthMenuTree")
	@ResponseBody
	public String getAuthMenuTree() {
		List<AuthRole> roles = authRoleService.findRoleByAuthUser(new AuthUser(Loginer.getLoginer(request).getId()));
		List<AuthMenu> authMenus = authMenuService.findMenuByRoles(roles, true);
		if (Collections3.isNotEmpty(authMenus)) {
			return createTreeMenuJson(authMenus);
		}
		return "";
	}

	private static String createTreeMenuJson(List<AuthMenu> children) {
		List<Map<String, Object>> nodeMapList = Lists.newArrayList();
		if (Collections3.isNotEmpty(children)) {
			nodeMapList = createTreeMenuList(children);
			return new JsonMapper().toJson(nodeMapList);
		}
		return "";
	}

	private static List<Map<String, Object>> createTreeMenuList(List<AuthMenu> children) {
		List<Map<String, Object>> nodeMapList = Lists.newArrayList();
		if (Collections3.isNotEmpty(children)) {
			for (AuthMenu authMenu : children) {
				Map<String, Object> nodeMap = Maps.newHashMap();
				nodeMap.put("id", authMenu.getId());
				nodeMap.put("pid", authMenu.getParent() != null ? authMenu.getParent().getId() : "");
				nodeMap.put("text", authMenu.getName());
				nodeMap.put("iconCls", authMenu.getRelationId());
				nodeMap.put("state", "open");
				nodeMap.put("checked", false);
				Map<String, Object> nodeAttributeMap = Maps.newHashMap();
				nodeAttributeMap.put("target", "");
				nodeAttributeMap.put("url", authMenu.getPermission().getActionURI());
				nodeMap.put("attributes", nodeAttributeMap);
				nodeMap.put("children", createTreeMenuList(authMenu.getChildren()));
				nodeMapList.add(nodeMap);
			}
			return nodeMapList;
		}
		return null;
	}
	
	@RequestMapping("sbtAuthMng")
	public String sbtAuthMng(){
		return "menu/sbt_auth_mng";
	}
	@RequestMapping("list")
	public String listMenu(SearchParam searchParam,Model model){
		searchParam.getParamMap().put("parentIsNull", "Y");
		model.addAttribute("tree",new JsonMapper().toJson(menuService.buildTree(menuService.list(searchParam, getPageBounds(10, true)))));
		return "menu/list_menu";
	}
	@RequestMapping("create")
	public String createMenu(Model model){
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("parentIsNull","Y" );
		model.addAttribute("parentMenus",menuService.list(searchParam, null));
		return "menu/edit_menu";
	}
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(AuthMenu menu){
		try{
			return this.menuService.create(menu);
		}catch(DuplicateKeyException exception){
			return Response.failInstance().responseMsg("duplicate primary key");
		}
	}
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(AuthMenu menu,Model model){
		model.addAttribute("menu",authMenuService.findMenuById(menu.getId()));
		//一级菜单
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("parentIsNull","Y" );
		model.addAttribute("parentMenus",menuService.list(searchParam, null));
		return "menu/edit_menu";
	}
	@RequestMapping(value="update")
	@ResponseBody
	public Response update(AuthMenu menu,Model model){
		return menuService.update(menu);
	}
	@RequestMapping(value="delete")
	@ResponseBody
	public Response delete(AuthMenu authMenu){
		return menuService.delete(authMenu);
	}
	//加载菜单的一级节点，封装分页数据
	@RequestMapping(value="tree")
	@ResponseBody
	public DataGrid tree(SearchParam searchParam){
		List<AuthMenu> authMenus = menuService.list(searchParam, getPageBounds(10, true));
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(menuService.buildTree(authMenus));
		if(authMenus instanceof PageList){
			dataGrid.setTotal(((PageList) authMenus).getPaginator().getTotalCount());
		}
		
		return  dataGrid;
	}
	//加载菜单子节点
	@RequestMapping(value="node")
	@ResponseBody
	public List<Node> node(String parentId){
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("parent", parentId);
		List<AuthMenu> authMenus = menuService.list(searchParam, null);
		return menuService.buildTree(authMenus);
	}
}
