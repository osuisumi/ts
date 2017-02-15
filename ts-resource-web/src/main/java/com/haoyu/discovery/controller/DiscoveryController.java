package com.haoyu.discovery.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.sip.tag.entity.Tag;
import com.haoyu.sip.tag.service.ITagService;

@Controller
@RequestMapping("discovery")
public class DiscoveryController extends AbstractBaseController {
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IDepartmentService departmentService;
	
	@Resource
	private IFileService fileService;
	
	@Resource
	private ITagService tagService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam,Model model){
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
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
	
	@RequestMapping(value="more", method=RequestMethod.GET)
	public String more(SearchParam searchParam, Model model){
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		model.addAttribute("searchParam",searchParam);
		List<Resources> discoverys = resourceBizService.listResource(searchParam, getPageBounds(10, true));
		for(Resources discovery:discoverys){
			discovery.setFileInfos(fileService.listFileInfoByRelationId(discovery.getId()));
		}
//		setDiscoveryTags(discoverys);
		model.addAttribute("discoverys",discoverys);
		return "discovery/list_more_discovery";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Resources resource, Model model){
		Resources resourceResult = resourceBizService.viewResource(resource);
		model.addAttribute("discovery",resourceResult );
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("type", "discovery");
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		model.addAttribute("numMap",resourceBizService.getResourceInfo(searchParam));
		//可能感兴趣的
		String type = resourceResult.getResourceExtend().getType();
		searchParam.getParamMap().clear();
		searchParam.getParamMap().put("extendType",type);
		searchParam.getParamMap().put("type", "discovery");
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		List<Resources> relativeDiscovery = resourceBizService.listResource(searchParam, getPageBounds(5,true));
		relativeDiscovery.remove(resourceResult);
		model.addAttribute("relativeDisCoverys",relativeDiscovery);
		//作者的其他发现
		searchParam.getParamMap().clear();
		searchParam.getParamMap().put("creator",resourceResult.getCreator().getId());
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		searchParam.getParamMap().put("type", "discovery");
		List<Resources> creatorOtherDiscovery = resourceBizService.listResource(searchParam, getPageBounds(5,true));
		creatorOtherDiscovery.remove(resourceResult);
		model.addAttribute("creatorOtherDiscoverys",creatorOtherDiscovery);
		return "discovery/view_discovery";
	}
	@RequestMapping(value="{id}/delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resources){
		return resourceBizService.deleteResource(resources);
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String discoveryIndex(Model model){
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
			searchParam.getParamMap().put("type", "discovery");
			searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
			model.addAttribute("numMap",resourceBizService.getResourceInfo(searchParam));
		}
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("tags",tagService.findTasByRelationType("resources"));
		return "discovery/discovery_index";
	}
	
	@RequestMapping(value="listData")
	@ResponseBody
	public List<Resources> listData(SearchParam searchParam){
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		return resourceBizService.listResource(searchParam, getPageBounds(10, true));
	}
	
	/**
	 * 学校的发现展示  hqy
	 */
	@RequestMapping(value="listNewDiscovery",method=RequestMethod.GET)
	public String listNewDiscovery(SearchParam searchParam,Model model){
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		model.addAttribute("discoverys", resourceBizService.listResource(searchParam, getPageBounds(10, true),false));
		return "discovery/list_new_discovery";
	}
	
	private void setDiscoveryTags(List<Resources> discoverys){
		if(CollectionUtils.isNotEmpty(discoverys)){
			List<String> discoveryIds = new ArrayList<String>();
			for(Resources discovery:discoverys){
				if(StringUtils.isNotEmpty(discovery.getId())){
					discoveryIds.add(discovery.getId());
				}
			}
			Map<String,List<Tag>> result = tagService.findEntityTagsByEntityIds(discoveryIds);
			for(Resources discovery:discoverys){
				discovery.setTags(result.get(discovery.getId()));
			}
		}
	}
}
