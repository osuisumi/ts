package com.haoyu.resource.controller;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.index.entity.Loginer;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.user.utils.AuthRoleEnum;

@Controller
@RequestMapping("resource")
public class ResourceBizController extends AbstractBaseController{
	
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IResourceService resourceService;
	
	@RequestMapping("listResource")
	public String listResource(SearchParam searchParam, Model model){
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole(AuthRoleEnum.SCHOOL_ADMIN.getCode())) {
			searchParam.getParamMap().put("relationId", ((Loginer)Loginer.getLoginer(request)).getDeptId());
		}
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
		if (ResourceType.SYNC.equals(searchParam.getParamMap().get("type"))) {
			return "resource/list_sync_resource";
		}else{
			return "resource/list_classify_resource";
		}
	}
	
	@RequestMapping("goImport")
	public String goImport(Model model){
		return "resource/import_resource";
	}
	
	@RequestMapping("importResource")
	public String importResource(String url, Model model){
		model.addAttribute("resultMap", resourceBizService.importResource(url, ((Loginer)Loginer.getLoginer(request)).getDeptId()));
		return "resource/import_result";
	}
	
	@RequestMapping("updateResource")
	@ResponseBody
	public Response updateResource(Resources resource){
		return resourceService.updateByIds(resource);
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
		model.addAttribute("resource", resourceBizService.getResource(resource.getId()));
		return "resource/view_resource";
	}
	
	@RequestMapping("deleteResource")
	@ResponseBody
	public Response deleteResource(Resources resource){
		return resourceBizService.deleteResource(resource);
	}

}
