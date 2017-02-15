package com.haoyu.menu.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthMenu;

public interface IMenuDao {
	
	List<AuthMenu> list(Map<String,Object> param,PageBounds pageBounds);
	
	int delete(Map<String,Object> paramMap);
	
	int count(Map<String,Object> param);
	
	int save(AuthMenu authMenu);
	
}
