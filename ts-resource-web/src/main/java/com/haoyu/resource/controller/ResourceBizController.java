package com.haoyu.resource.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceState;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.utils.ErrorMsg;

@Controller
@RequestMapping("resource")
public class ResourceBizController extends AbstractBaseController{
	
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IDepartmentService departmentService;
	
	@RequestMapping("resourceIndex")
	public String resourceIndex(Model model){
		if (request.getParameter("relationId") != null) {
			String relationId = request.getParameter("relationId");
			Department dept = departmentService.get(relationId);
			if (dept != null) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
				param.put("typeNotEquils", ResourceType.DISCOVERY);
				param.put("relationId", dept.getId());
				model.addAttribute("resourceNum", resourceBizService.getCount(param));
				param.put("minCreateTime", TimeUtils.getMonthBeginDate().getTime());
				model.addAttribute("newResourceNum", resourceBizService.getCount(param));
			}
			model.addAttribute("dept", dept);
		}else{
			SearchParam searchParam = new SearchParam();
			searchParam.getParamMap().put("typeNotEquils", "discovery");
			searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
			Map<String, Object> numMap = resourceBizService.getResourceInfo(searchParam);
			model.addAttribute("numMap", numMap);
		}
		model.addAllAttributes(request.getParameterMap());
		return "resource/resource_index";
	}
	
	@RequestMapping("moreResource")
	public String moreResource(SearchParam searchParam, Model model){
		if (searchParam.getParamMap().get("type").equals("sync")) {
			return "resource/more_sync_resource";
		}else{
			return "resource/more_classify_resource";
		}
	}
	
	@RequestMapping("syncResource")
	public String moreResource(Model model){
		return "resource/sync_resource";
	}
	
	@RequestMapping("classifyResource")
	public String classifyResource(Model model){
		return "resource/classify_resource";
	}
	
	@RequestMapping("listResource")
	public String listResource(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("stateNotEquils", ResourceState.NOPASS);
		String relationType = (String) searchParam.getParamMap().get("relationType");
		if ("workshop".equals(relationType)) {
			String workshopId = (String) searchParam.getParamMap().get("relationId");
			Subject currentUser = SecurityUtils.getSubject();
			if (currentUser.hasRole(workshopId+"_master") || currentUser.hasRole(workshopId+"_member")) {
				searchParam.getParamMap().put("isHidden", "Y");
			}
			model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
			return "resource/list_workshop_resource";
		}else{
			model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
			return "resource/list_resource";
		}
	}
	
	@RequestMapping("listMoreResource")
	public String listMoreResource(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("stateNotEquils", ResourceState.NOPASS);
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "resource/list_more_resource";
	}
	
	@RequestMapping("addResource")
	public String createResource(Resources resource, Model model){
		model.addAttribute("resource", resource);
		model.addAllAttributes(request.getParameterMap());
		return "resource/edit_resource";
	}
	
	@RequestMapping("editResource")
	public String editResource(Resources resource, Model model){
		model.addAttribute("resource", resourceBizService.getResource(resource.getId()));
		return "resource/edit_resource";
	}
	
	@RequestMapping("saveResource")
	@ResponseBody
	public Response saveResource(Resources resource){
		return resourceBizService.saveResource(resource);
	}
	
	@RequestMapping("viewResource")
	public String viewResource(Resources resource, Model model){
		resource = resourceBizService.viewResource(resource);
		if (resource != null ) {
			SearchParam searchParam = new SearchParam();
			searchParam.getParamMap().put("typeNotEquils", "discovery");
			searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
			Map<String, Object> numMap = resourceBizService.getResourceInfo(searchParam);
			model.addAttribute("numMap", numMap);
			model.addAttribute("resource", resource);
			model.addAllAttributes(request.getParameterMap());
			return "resource/view_resource";
		}else {
			model.addAttribute("errorMsg", ErrorMsg.RESOURCE_UNDEFINDE);
			return "404";
		}
	}
	
	@RequestMapping("deleteResource")
	@ResponseBody
	public Response deleteResource(Resources resource){
		return resourceBizService.deleteResource(resource);
	}
	
	@RequestMapping("listSame")
	public String listSame(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("stateNotEquils", ResourceState.NOPASS);
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "resource/list_same_resource";
	}
	
	@RequestMapping("listNewResource")
	public String listNewResource(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("stateNotEquils", ResourceState.NOPASS);
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "resource/list_new_resource";
	}
	
	@RequestMapping("listRankResource")
	public String listRankResource(Model model){
		model.addAttribute("resources", resourceBizService.listRankResource());
		return "resource/list_rank_resource";
	}
	
	@RequestMapping("listHotResource")
	public String listHotResource(SearchParam searchParam, Model model){
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "resource/list_hot_resource";
	}
	
	@RequestMapping("listMoreHotResource")
	public String listMoreHotResource(SearchParam searchParam, Model model){
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "resource/list_more_hot_resource"; 
	}

}
