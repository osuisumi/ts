package com.haoyu.auth;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;

import com.haoyu.auth.dao.IAuthUserBizDao;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.realm.AuthenticationRealm;

public class AuthRealm extends AuthenticationRealm {
	
	@Resource
	private IAuthUserBizDao authUserBizDao;

	@Override
	public List<AuthUser> findAuthUserByIds(List<String> ids) {
		return authUserBizDao.selectAuthUserByIds(ids);
	}

	@Override
	protected void addAuthorize(SimpleAuthorizationInfo info, PrincipalCollection principals) {
		
	}

	@Override
	protected AuthUser findAuthUserByUsername(String username) {
		return authUserBizDao.selectAuthUserByUsername(username);
	}

	@Override
	protected AuthUser findAuthUserById(String id) {
		return authUserBizDao.selectAuthUserById(id);
	}

}
