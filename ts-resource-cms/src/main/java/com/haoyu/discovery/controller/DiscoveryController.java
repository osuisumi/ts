package com.haoyu.discovery.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.index.entity.Loginer;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.user.entity.User;
import com.haoyu.user.service.IUserService;

@Controller
@RequestMapping("discovery")
public class DiscoveryController extends AbstractBaseController {
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IResourceService resourceService;
	@Resource
	private IFileService fileService;
	@Resource
	private IUserService userService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam,Model model,String minCreateTime,String maxCreateTime,HttpSession session){
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(StringUtils.isNotEmpty(minCreateTime)){
				searchParam.getParamMap().put("minCreateTime", sdf.parse(minCreateTime).getTime());
				model.addAttribute("minCreateTime", minCreateTime);
			}
			if(StringUtils.isNotEmpty(maxCreateTime)){
				searchParam.getParamMap().put("maxCreateTime", sdf.parse(maxCreateTime).getTime());
				model.addAttribute("maxCreateTime",maxCreateTime);
			}
		}catch(Exception e){
			
		}
		Loginer loginer = (Loginer) session.getAttribute("loginer");
		if(loginer != null){
			searchParam.getParamMap().put("relationId", loginer.getDeptId());
		}else{
			User user = userService.get(ThreadContext.getUser().getId()) ;
			searchParam.getParamMap().put("relationId",user.getUserDept().getDeptId());
		}
		model.addAttribute("discoverys", resourceBizService.listResource(searchParam, getPageBounds(10, true),true));
		return "discovery/list_discovery";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Resources resource, Model model){
		model.addAttribute("discovery", resource);
		model.addAllAttributes(request.getParameterMap());
		return "discovery/edit_discovery";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Resources resource, Model model){
		model.addAttribute("discovery", resourceBizService.viewResource(resource));
		model.addAllAttributes(request.getParameterMap());
		return "discovery/edit_discovery";
	}
	
	@RequestMapping(value="save", method=RequestMethod.POST)
	@ResponseBody
	public Response save(Resources resource, Model model){
		return resourceBizService.saveDiscovery(resource);
	}
	
	
	@RequestMapping(value="{id}/delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resources){
		return resourceBizService.deleteResource(resources);
	}
	@RequestMapping(value="/delete/deleteByIds")
	@ResponseBody
	public Response deleteByIds(String ids){
		return resourceService.delete(ids);
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Resources resource, Model model){
		Resources resourceResult = resourceBizService.viewResource(resource);
		model.addAttribute("discovery",resourceResult );
		return "discovery/view_discovery";
	}
	
	
}
