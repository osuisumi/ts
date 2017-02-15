package com.haoyu.auth.dao.impl.mybatis;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.haoyu.auth.dao.IAuthUserBizDao;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.user.entity.User;

@Repository
public class AuthUserBizDao extends MybatisDao implements IAuthUserBizDao{

	@Override
	public AuthUser selectAuthUserByUsername(String username) {
		return selectOne("selectAuthUserByUsername", username);
	}
	
	@Override
	public int updateAuthUserRole(User user) {
		return super.update("updateAuthUserRole", user);
	}

	@Override
	public List<AuthUser> selectAuthUserByIds(List<String> ids) {
		return selectList("selectAuthUserByIds", ids);
	}

	@Override
	public AuthUser selectAuthUserById(String id) {
		return selectOne("selectAuthUserById", id);
	}

	@Override
	public int createAuthUserRole(User user) {
		return super.insert("createUserRole",user);
	}
	
}
