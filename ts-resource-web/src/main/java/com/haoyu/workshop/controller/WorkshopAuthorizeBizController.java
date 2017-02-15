package com.haoyu.workshop.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.workshop.service.IWorkshopBizService;

@Controller
@RequestMapping("workshop/authorize")
public class WorkshopAuthorizeBizController extends AbstractBaseController{
	
	@Resource
	private IWorkshopBizService workshopBizService;
	
	@RequestMapping("listWorkshopAuthorize")
	public String listWorkshopAuthorize(SearchParam searchParam, Model model){
		model.addAttribute("resultList", workshopBizService.listWorkshopAuthorize(searchParam, getPageBounds(10, true)));
		return "workshop/list_workshop_authorize";
	}
	@RequestMapping("index")
	public String index(SearchParam searchParam,Model model){
		return "workshop/workshop_authorize_index";
	}
}
