package com.haoyu.auth.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;

public interface IAuthRoleBizDao {

	List<AuthRole> select(Map<String, Object> paramMap, PageBounds pageBounds);

	AuthRole selectById(String id);

	int insert(AuthRole authRole);

	int update(AuthRole authRole);

	int deleteByIds(Map<String, Object> param);

	int deleteRoleMenuByRoleId(String authRoleId);

}
