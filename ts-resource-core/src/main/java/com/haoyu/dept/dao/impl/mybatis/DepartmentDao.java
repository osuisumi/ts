package com.haoyu.dept.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.dept.dao.IDepartmentDao;
import com.haoyu.dept.entity.Department;
import com.haoyu.resource.utils.ResourceState;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class DepartmentDao extends MybatisDao implements IDepartmentDao{

	@Override
	public List<Department> select(Map<String, Object> paramMap, PageBounds pageBounds) {		
		return selectList("select", paramMap, pageBounds);
	}

	@Override
	public Department selectById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insert(Department department) {
		return super.insert(department);
	}

	@Override
	public int update(Department department) {
		return super.update(department);
	}

	@Override
	public int deleteByIds(Map<String, Object> param) {
		return update("deleteByIds", param);
	}

	@Override
	public int getCount(Map<String, Object> paramMap) {
		return selectOne("getCount", paramMap);
	}

	@Override
	public List<Map<String, Object>> selectRankDepartment(PageBounds pageBounds) {
		return selectList("selectRankDepartment", null, pageBounds);
	}
	
	@Override
	public List<User> getShareMasters(Map<String, Object> paramMap, PageBounds pageBounds) {
		return selectList("getShareMasters", paramMap, pageBounds);
	}

	@Override
	public List<Map<String, Object>> selectRankCompetitionDepartment(Map<String,Object> paramMap,PageBounds pageBounds) {
		return selectList("selectCompetitionRankDepartment",paramMap,pageBounds);
	}

}
