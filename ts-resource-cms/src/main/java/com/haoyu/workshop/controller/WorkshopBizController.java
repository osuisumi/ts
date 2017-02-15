package com.haoyu.workshop.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.workshop.entity.Workshop;
import com.haoyu.tip.workshop.entity.WorkshopAuthorize;
import com.haoyu.tip.workshop.service.IWorkshopAuthorizeService;
import com.haoyu.tip.workshop.service.IWorkshopService;

@RequestMapping("bizWorkshop")
@Controller
public class WorkshopBizController extends AbstractBaseController{
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IWorkshopAuthorizeService workshopAuthorizeService;
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(Workshop workshop,Model model){
		Workshop result = workshopService.viewWorkshop(workshop);
		model.addAttribute("workshop",result);
		return "workshop/edit_workshop";
	}
	
	@RequestMapping(value="{id}/update",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Workshop workshop){
		Response response = workshopService.update(workshop);
		if(response.isSuccess()){
			SearchParam searchParam = new SearchParam();
			searchParam.getParamMap().put("workshopId", workshop.getId());
			searchParam.getParamMap().put("role", "master");
			List<WorkshopAuthorize> oldMasters =  workshopAuthorizeService.list(searchParam, getPageBounds(10, false));
			WorkshopAuthorize prepareDelete = new WorkshopAuthorize();
			prepareDelete.setWorkshopRelation(workshop.getWorkshopRelations().get(0));
			prepareDelete.setId("");
			prepareDelete.setUser(new User());
			if(CollectionUtils.isNotEmpty(oldMasters)){
				for(WorkshopAuthorize w:oldMasters){
					prepareDelete.setId(prepareDelete.getId()+"," + w.getId());
					prepareDelete.getUser().setId(prepareDelete.getUser().getId() + "," + w.getUser().getId());
				}
			}
			workshopAuthorizeService.deleteWorkshopAuthorizeBatch(prepareDelete);
			response = workshopAuthorizeService.createWorkshopAuthorize(workshop);
		}
		return response;
	}

}
