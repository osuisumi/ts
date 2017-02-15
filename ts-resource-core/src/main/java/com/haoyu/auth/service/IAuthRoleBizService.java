package com.haoyu.auth.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface IAuthRoleBizService {

	List<AuthRole> list(SearchParam searchParam, PageBounds pageBounds);

	AuthRole get(String id);

	Response create(AuthRole authRole);

	Response update(AuthRole authRole);

	Response delete(AuthRole authRole);

	Response updateRoleMenu(AuthRole authRole);

}
