package com.haoyu.auth.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.auth.dao.IAuthRoleBizDao;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class AuthRoleBizDao extends MybatisDao implements IAuthRoleBizDao{

	@Override
	public List<AuthRole> select(Map<String, Object> paramMap, PageBounds pageBounds) {
		return selectList("select", paramMap, pageBounds);
	}

	@Override
	public AuthRole selectById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insert(AuthRole authRole) {
		return super.insert(authRole);
	}

	@Override
	public int update(AuthRole authRole) {
		return super.update(authRole);
	}

	@Override
	public int deleteByIds(Map<String, Object> param) {
		return update("deleteByIds", param);
	}

	@Override
	public int deleteRoleMenuByRoleId(String authRoleId) {
		return delete("deleteRoleMenuByRoleId", authRoleId);
	}

}
