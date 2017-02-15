package com.haoyu.auth.dao;

import java.util.List;

import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.user.entity.User;

public interface IAuthUserBizDao {

	AuthUser selectAuthUserByUsername(String username);
	
	int updateAuthUserRole(User user);
	
	int createAuthUserRole(User user);

	List<AuthUser> selectAuthUserByIds(List<String> ids);

	AuthUser selectAuthUserById(String id);

}
