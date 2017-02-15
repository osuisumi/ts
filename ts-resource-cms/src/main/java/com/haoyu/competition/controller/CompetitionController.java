package com.haoyu.competition.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.announcement.entity.Announcement;
import com.haoyu.tip.announcement.service.IAnnouncementService;
@Controller
@RequestMapping("competition")
public class CompetitionController extends AbstractBaseController{
	@Resource
	private ICompetitionService competitionService;
	@Resource
	private IAnnouncementService announcementService;
	@Resource
	private IResourceBizService resourceBizService;
	
	@RequestMapping(value="create",method =RequestMethod.GET)
	public String create(){
		return "competition/edit_competition";
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值  
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(Competition competition){
		return competitionService.createCompetition(competition);
	}
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Competition competition){
		return competitionService.delete(competition);
	}
	@RequestMapping(value="{id}/update",method = RequestMethod.POST)
	@ResponseBody
	public Response update(Competition competition){
		return competitionService.updateCompetition(competition);
	}
	@RequestMapping(value="{id}/edit")
	public String edit(Competition competition,Model model){
		model.addAttribute("competition", this.competitionService.get(competition.getId()));
		return "competition/edit_competition";
	}
	@RequestMapping(value="list")
	public String list(SearchParam searchParam,Model model){
		model.addAttribute("competitions",competitionService.list(searchParam, getPageBounds(10, true)) );
		return "competition/list_competition";
	}
	@RequestMapping(value="list/more")
	public String listMore(SearchParam searchParam,Model model,String minCreateTime,String maxCreateTime) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isNotEmpty(minCreateTime)){
			Date date = sdf.parse(minCreateTime);
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.set(Calendar.HOUR_OF_DAY, 0);
			c.set(Calendar.MINUTE,0);
	        c.set(Calendar.SECOND,0);
	        searchParam.getParamMap().put("minCreateTime", c.getTime().getTime());
	        model.addAttribute("minCreateTime", minCreateTime);
		}
		if(StringUtils.isNotEmpty(maxCreateTime)){
			Date date = sdf.parse(maxCreateTime);
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.set(Calendar.HOUR_OF_DAY, 23);
			c.set(Calendar.MINUTE,59);
	        c.set(Calendar.SECOND,59);
	        searchParam.getParamMap().put("maxCreateTime", c.getTime().getTime());
	        model.addAttribute("maxCreateTime", maxCreateTime);
		}
		model.addAttribute("competitions",competitionService.list(searchParam, getPageBounds(10, true)) );
		return "competition/list_more_competition";
	}
	@RequestMapping(value="delete/deleteByIds")
	@ResponseBody
	public Response deleteByIds(Competition competition){
		return this.competitionService.deleteCompetition(competition);
	}
	@RequestMapping(value="announcement")
	public String listAnnouncement(SearchParam searchParam,Model model){
		model.addAttribute("announcements",announcementService.list(searchParam, getPageBounds(10, true)) );
		return "competition/list_announcement";
	}
	@RequestMapping(value="announcement/create")
	public String editAnnouncement(Announcement announcement,Model model){
		model.addAttribute("announcement", announcement);
		return "competition/edit_announcement";
	}
	@RequestMapping(value="resource")
	public String listResource(SearchParam searchParam,Model model){
		List<Resources> resources = resourceBizService.listResource(searchParam, getPageBounds(10, true));
		model.addAttribute("resources",resources);
		return "competition/list_competition_resource";
	}
	@RequestMapping(value="prize/edit")
	public String editPrize(SearchParam searchParam,Model model){
		return "competition/edit_resource_prize";
	}
	@RequestMapping(value="prize/save")
	@ResponseBody
	public Response savePrize(ResourceExtend resourceExtend,Model model){
		return resourceBizService.updateResponseExtendByIds(resourceExtend);
	}
}
