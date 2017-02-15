package com.haoyu.dept.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.dept.entity.Department;
import com.haoyu.sip.core.entity.User;

@Repository
public interface IDepartmentDao {

	List<Department> select(Map<String, Object> paramMap, PageBounds pageBounds);

	Department selectById(String id);

	int insert(Department department);

	int update(Department department);

	int deleteByIds(Map<String, Object> param);

	int getCount(Map<String, Object> paramMap);
	
	/** 获取分享达人数据	 */
	List<User> getShareMasters(Map<String, Object> paramMap, PageBounds pageBounds);

	/** 学校排名：按资源的上传数和下载量  */
	List<Map<String, Object>> selectRankDepartment(PageBounds pageBounds);

	List<Map<String,Object>> selectRankCompetitionDepartment(Map<String,Object> paramMap,PageBounds pageBounds);
}
