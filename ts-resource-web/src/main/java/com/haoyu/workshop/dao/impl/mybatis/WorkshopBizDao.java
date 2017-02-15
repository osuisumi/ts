package com.haoyu.workshop.dao.impl.mybatis;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.workshop.dao.IWorkshopBizDao;
import com.haoyu.workshop.entity.WorkshopResult;

@Repository
public class WorkshopBizDao extends MybatisDao implements IWorkshopBizDao{

	@Override
	public List<Map<String, Object>> selectWorkshopAuthorize(Map<String, Object> paramMap, PageBounds pageBounds) {
		return selectList("selectWorkshopAuthorize", paramMap, pageBounds);
	}

	@Override
	public List<WorkshopResult> selectWorkshopResult(Map<String, Object> param) {
		return selectList("selectWorkshopResult", param);
	}

}
