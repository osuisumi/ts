package com.haoyu.workshop.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.workshop.service.IWorkshopService;
import com.haoyu.workshop.dao.IWorkshopBizDao;
import com.haoyu.workshop.entity.WorkshopResult;
import com.haoyu.workshop.service.IWorkshopBizService;
import com.haoyu.workshop.utils.WorkshopType;

@Service
public class WorkshopBizServiceImpl implements IWorkshopBizService {

	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IWorkshopBizDao workshopBizDao;

	@Override
	public List<WorkshopResult> listWorkshopResult() {
		Map<String, Object> param = Maps.newHashMap();
		param.put("userId", ThreadContext.getUser().getId());
		param.put("type", WorkshopType.TOPIC.toString());
		return workshopBizDao.selectWorkshopResult(param);
	}

	@Override
	public List<Map<String, Object>> listWorkshopAuthorize(SearchParam searchParam, PageBounds pageBounds) {
		return workshopBizDao.selectWorkshopAuthorize(searchParam.getParamMap(), pageBounds);
	}

}
