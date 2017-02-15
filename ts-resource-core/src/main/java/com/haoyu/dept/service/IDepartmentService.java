package com.haoyu.dept.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.dept.entity.Department;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface IDepartmentService {

	List<Department> list(SearchParam searchParam, PageBounds pageBounds);

	Department get(String id);

	Response create(Department department);

	Response update(Department department);

	Response delete(Department department);

	int getCount(Map<String, Object> map);

	/** 获取分享达人数据	 */
	List<User> getShareMasters(SearchParam searchParam, PageBounds pageBounds);

}
