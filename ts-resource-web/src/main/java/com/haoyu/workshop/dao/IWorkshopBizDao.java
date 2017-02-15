package com.haoyu.workshop.dao;


import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.workshop.entity.WorkshopResult;

public interface IWorkshopBizDao {

	List<Map<String, Object>> selectWorkshopAuthorize(Map<String, Object> paramMap, PageBounds pageBounds);

	List<WorkshopResult> selectWorkshopResult(Map<String, Object> param);

}
