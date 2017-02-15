package com.haoyu.menu.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.menu.util.Node;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface IMenuService {
	//创建menu
	Response create(AuthMenu authMenu);
	//条件查询
	List<AuthMenu> list(SearchParam searchParam,PageBounds pageBounds);
	//跟新
	Response update(AuthMenu authMenu);
	
	List<AuthMenu> selectForMap(SearchParam searchParam,PageBounds pageBounds);
	
	Response delete(AuthMenu authMenu);
	
	List<Node> buildTree(List<AuthMenu> authMenus);
	
}
