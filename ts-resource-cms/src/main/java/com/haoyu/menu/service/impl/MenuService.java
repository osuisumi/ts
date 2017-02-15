package com.haoyu.menu.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.menu.dao.IMenuDao;
import com.haoyu.menu.event.DeleteMenuEvent;
import com.haoyu.menu.service.IMenuService;
import com.haoyu.menu.util.Node;
import com.haoyu.sip.auth.dao.IAuthRoleMenuDao;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.entity.AuthPermission;
import com.haoyu.sip.auth.entity.AuthResource;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.auth.service.IAuthPermissionService;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;

@Service
public class MenuService implements IMenuService {
	@Resource
	private IAuthMenuService authMenuService;
	@Resource
	private IAuthPermissionService authPermissionService;
	@Resource
	private IAuthRoleMenuDao authRoleMenuDao;
	@Resource
	private IMenuDao menuDao;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private ApplicationContext applicationContext;

	@Override
	public Response create(AuthMenu authMenu) {
		if (authMenuService.findMenuById(authMenu.getId()) != null) {
			return Response.failInstance().responseMsg("duplicate primary key");
		}
		// 菜单有链接时 先创建AuthPermission,在创建menu
		boolean createAuthMenuFlg = true;
		Response response = new Response();
		if (authMenu.getPermission() != null && StringUtils.isNotEmpty(authMenu.getPermission().getActionURI())) {
			AuthPermission authPermission = new AuthPermission();
			String authPermissionId = DigestUtils.md5Hex(authMenu.getId());
			authPermission.setId(authPermissionId);
			authPermission.setActionURI(authMenu.getPermission().getActionURI());
			authPermission.setName(authMenu.getName());
			authPermission.setResource(new AuthResource(authPermissionId));
			authPermission.setAction(authPermissionId);
			authPermission.setDefaultValue();
			response = authPermissionService.createPermission(authPermission);
			if (response.isSuccess()) {
				authMenu.setPermission(authPermission);
			} else {
				createAuthMenuFlg = false;
			}
		}
		if (createAuthMenuFlg) {
			try {
				response = menuDao.save(authMenu) > 0 ? Response.successInstance() : Response.failInstance();
			} catch (DuplicateKeyException exception) {
				throw exception;
			}
		}
		return response;
	}

	@Override
	public List<AuthMenu> list(SearchParam searchParam, PageBounds pageBounds) {
		return menuDao.list(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Response update(AuthMenu authMenu) {
		Response response = new Response();
		if (authMenu.getPermission() != null) {
			String updatePermissionUrl = authMenu.getPermission().getActionURI();
			AuthMenu oldAuthMenu = authMenuService.findMenuById(authMenu.getId());
			if (oldAuthMenu.getPermission() != null && StringUtils.isNotEmpty(oldAuthMenu.getPermission().getId())) {
				// 原来有菜单url,先更新permission,再更新menu
				AuthPermission prepareUpdatePermission = new AuthPermission();
				prepareUpdatePermission.setId(oldAuthMenu.getPermission().getId());
				prepareUpdatePermission.setActionURI(updatePermissionUrl);
				response = authPermissionService.updatePermission(prepareUpdatePermission);
				if (response.isSuccess()) {
					authMenu.setPermission(prepareUpdatePermission);
					response = authMenuService.updateMenu(authMenu);
				}
			} else {
				// 原来没有url,先创建permission,再更新menu
				AuthPermission prepareAddPermission = new AuthPermission();
				String authPermissionId = DigestUtils.md5Hex(authMenu.getId());
				prepareAddPermission.setActionURI(updatePermissionUrl);
				prepareAddPermission.setId(authPermissionId);
				prepareAddPermission.setName(authMenu.getName());
				prepareAddPermission.setResource(new AuthResource(authPermissionId));
				prepareAddPermission.setAction(authPermissionId);
				prepareAddPermission.setDefaultValue();
				response = authPermissionService.createPermission(prepareAddPermission);
				if (response.isSuccess()) {
					authMenu.setPermission(prepareAddPermission);
					response = authMenuService.updateMenu(authMenu);
				}
			}
		} else {
			response = authMenuService.updateMenu(authMenu);
		}
		return response;
	}

	@Override
	public List<AuthMenu> selectForMap(SearchParam searchParam, PageBounds pageBounds) {
		return menuDao.list(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Response delete(AuthMenu authMenu) {
		//保存所有将要删除的菜单id，用作发布事件，删除菜单的permission
		List<String> deleteIds = new ArrayList<String>();
		String[] ids = authMenu.getId().split(",");
		//获取所有将要删除的菜单id
		deleteIds.addAll(Arrays.asList(ids));
		for (int i = 0; i < ids.length; i++) {
			SearchParam param = new SearchParam();
			param.getParamMap().put("parent", ids[i]);
			List<AuthMenu> childAuthMenu = list(param, null);
			if (childAuthMenu != null && childAuthMenu.size() > 0) {
				deleteIds.addAll(Collections3.extractToList(childAuthMenu, "id"));
			}
		}
		//执行删除，发布事件
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("entity", authMenu);
		paramMap.put("ids", Arrays.asList(ids));
		int count = menuDao.delete(paramMap);
		if(count > 0){
			applicationContext.publishEvent(new DeleteMenuEvent(deleteIds));
			return Response.successInstance();
		}
		return Response.failInstance();
	}
	//创建树的节点，延迟加载子节点
	public  List<Node> buildTree(List<AuthMenu> authMenus){
		List<Node> nodeList = new ArrayList<Node>();
		for (AuthMenu authMenu:authMenus) {
			Node node = new Node();
			node.setId(authMenu.getId());
			node.setPid(authMenu.getParent()!=null?authMenu.getParent().getId():"");
			node.setText(authMenu.getName());
			node.setIconCls(authMenu.getRelationId());
			node.setState("closed");
			node.setUrl(authMenu.getPermission().getActionURI());
			//node.setChildren(buildTree(authMenuService.findMenuByParent(authMenu.getId(), false)));
			nodeList.add(node);
		}
		return nodeList;
	}
}
