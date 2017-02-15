package com.haoyu.workshop.service;


import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.workshop.entity.WorkshopResult;

public interface IWorkshopBizService {

	List<WorkshopResult> listWorkshopResult();

	List<Map<String, Object>> listWorkshopAuthorize(SearchParam searchParam, PageBounds pageBounds);

}
