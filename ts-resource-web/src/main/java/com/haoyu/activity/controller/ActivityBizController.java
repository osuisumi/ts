package com.haoyu.activity.controller;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("activity")
public class ActivityBizController extends AbstractBaseController{
	
	@Resource
	private IActivityService activityService;
	
	@RequestMapping("listActivity")
	public String listActivity(SearchParam searchParam, Model model){
		String hasMasterRole = request.getParameter("hasMasterRole");
//		String hasAssistRole = request.getParameter("hasAssistRole");
		String hasMemberRole = request.getParameter("hasMemberRole");
		if (Boolean.valueOf(hasMasterRole)) {
			searchParam.getParamMap().put("states", "published,auditing");
//		}else if(Boolean.valueOf(hasAssistRole)){
		}else if(Boolean.valueOf(hasMemberRole)){
			searchParam.getParamMap().put("others", "publishedOrCreator");
			searchParam.getParamMap().put("creator", ThreadContext.getUser().getId());
		}else {
			searchParam.getParamMap().put("states", "published");
		}
		model.addAttribute("activities", activityService.list(searchParam, getPageBounds(10, true)));
		return "activity/list_activity";
	}
	
	@RequestMapping("listMoreActivity")
	public String listMoreActivity(SearchParam searchParam, Model model){
		String hasMasterRole = request.getParameter("hasMasterRole");
//		String hasAssistRole = request.getParameter("hasAssistRole");
		String hasMemberRole = request.getParameter("hasMemberRole");
		if (Boolean.valueOf(hasMasterRole)) {
			searchParam.getParamMap().put("states", "published,auditing");
//		}else if(Boolean.valueOf(hasAssistRole)){
		}else if(Boolean.valueOf(hasMemberRole)){
			searchParam.getParamMap().put("others", "publishedOrCreator");
			searchParam.getParamMap().put("creator", ThreadContext.getUser().getId());
		}else {
			searchParam.getParamMap().put("states", "published");
		}
		model.addAttribute("activities", activityService.list(searchParam, getPageBounds(10, true)));
		return "activity/list_more_activity";
	}
	
	@RequestMapping("listHotActivity")
	public String listHotActivity(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("states", "published");
		model.addAttribute("activities", activityService.list(searchParam, getPageBounds(10, true)));
		return "activity/list_hot_activity";
	}
	
	@RequestMapping("listMoreHotActivity")
	public String listMoreHotActivity(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("states", "published");
		model.addAttribute("activities", activityService.list(searchParam, getPageBounds(10, true)));
		return "activity/list_more_hot_activity";
	}

}
