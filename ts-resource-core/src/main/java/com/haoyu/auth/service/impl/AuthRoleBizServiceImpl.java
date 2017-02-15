package com.haoyu.auth.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.auth.dao.IAuthRoleBizDao;
import com.haoyu.auth.service.IAuthRoleBizService;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;

@Service
public class AuthRoleBizServiceImpl implements IAuthRoleBizService{

	@Resource
	private IAuthRoleBizDao authRoleBizDao;
	@Resource
	private IAuthRoleService authRoleService;
	
	@Override
	public List<AuthRole> list(SearchParam searchParam, PageBounds pageBounds) {
		return authRoleBizDao.select(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public AuthRole get(String id) {
		return authRoleBizDao.selectById(id);
	}

	@Override
	public Response create(AuthRole authRole) {
		if (StringUtils.isEmpty(authRole.getId())) {
			authRole.setId(Identities.uuid2());
		}
		authRole.setDefaultValue();
		int count = authRoleBizDao.insert(authRole);
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response update(AuthRole authRole) {
		authRole.setUpdatedby(ThreadContext.getUser());
		authRole.setUpdateTime(System.currentTimeMillis());
		int count = authRoleBizDao.update(authRole);
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response delete(AuthRole authRole) {
		String[] idArray = authRole.getId().split(",");
		List<String> ids = Arrays.asList(idArray);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		authRole.setUpdatedby(ThreadContext.getUser());
		authRole.setUpdateTime(System.currentTimeMillis());
		param.put("entity", authRole);
		int count = authRoleBizDao.deleteByIds(param);
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateRoleMenu(AuthRole authRole) {
		authRoleBizDao.deleteRoleMenuByRoleId(authRole.getId());
		List<String> menuIds = Collections3.extractToList(authRole.getMenus(), "id");
		return authRoleService.addMenusToRole(authRole, menuIds);
	}

}
