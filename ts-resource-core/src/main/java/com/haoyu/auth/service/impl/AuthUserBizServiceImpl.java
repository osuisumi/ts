package com.haoyu.auth.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haoyu.auth.dao.IAuthUserBizDao;
import com.haoyu.auth.service.IAuthUserBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.user.entity.User;

@Service
public class AuthUserBizServiceImpl implements IAuthUserBizService{

	@Resource
	private IAuthUserBizDao authUserBizDao;
	
	@Override
	public Response updateUserRole(User user) {
		int count = authUserBizDao.updateAuthUserRole(user);
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response createUserRole(User user) {
		return authUserBizDao.createAuthUserRole(user)>0?Response.successInstance():Response.failInstance();
	}

}
