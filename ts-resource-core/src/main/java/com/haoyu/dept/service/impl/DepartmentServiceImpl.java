package com.haoyu.dept.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.dept.dao.IDepartmentDao;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Identities;

@Service
public class DepartmentServiceImpl implements IDepartmentService{

	@Resource
	private IDepartmentDao departmentDao;
	
	@Override
	public List<Department> list(SearchParam searchParam, PageBounds pageBounds) {
		return departmentDao.select(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Department get(String id) {
		return departmentDao.selectById(id);
	}

	@Override
	public Response create(Department department) {
		if (StringUtils.isEmpty(department.getId())) {
			department.setId(Identities.uuid2());
		}
		department.setDefaultValue();
		int count = departmentDao.insert(department);
		return count>0?Response.successInstance():Response.successInstance();
	}

	@Override
	public Response update(Department department) {
		department.setUpdatedby(ThreadContext.getUser());
		department.setUpdateTime(System.currentTimeMillis());
		int count = departmentDao.update(department);
		return count>0?Response.successInstance():Response.successInstance();
	}

	@Override
	public Response delete(Department department) {
		String[] array = department.getId().split(",");
		List<String> ids = Arrays.asList(array);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		department.setUpdatedby(ThreadContext.getUser());
		department.setUpdateTime(System.currentTimeMillis());
		param.put("entity", department);
		int count = departmentDao.deleteByIds(param);
		return count>0?Response.successInstance():Response.successInstance();
	}

	@Override
	public int getCount(Map<String, Object> map) {
		return departmentDao.getCount(map);
	}

	@Override
	public List<User> getShareMasters(SearchParam searchParam, PageBounds pageBounds) {		
		return departmentDao.getShareMasters(searchParam.getParamMap(),pageBounds);
	}

}
