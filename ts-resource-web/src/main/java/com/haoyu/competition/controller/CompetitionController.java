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

import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.dept.dao.IDepartmentDao;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.sip.attitude.entity.AttitudeUser;
import com.haoyu.sip.attitude.service.IAttitudeService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
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
	@Resource
	private IDepartmentDao departmentDao;
	@Resource
	private IAttitudeService attitudeService;
	@RequestMapping(value="index")
	public String index(){
		return "competition/competition_index";
	}
	
	@RequestMapping(value="create",method =RequestMethod.GET)
	public String create(){
		return "competition/edit_competition";
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	//true:允许输入空值，false:不能为空值
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(Competition competition){
		return competitionService.create(competition);
	}
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Competition competition){
		return competitionService.delete(competition);
	}
	@RequestMapping(value="{id}/update",method = RequestMethod.POST)
	@ResponseBody
	public Response update(Competition competition){
		return competitionService.update(competition);
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
	@RequestMapping(value="list/hot")
	public String listHot(SearchParam searchParam,Model model){
		model.addAttribute("competitions",competitionService.list(searchParam, getPageBounds(10, true)));
		return "competition/list_hot_competition";
	}
	@RequestMapping(value="{id}/view")
	public String view(Competition competition,Model model){
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		searchParam.getParamMap().put("relationId",competition.getId());
		model.addAttribute("numMap",resourceBizService.getResourceInfo(searchParam));
		model.addAttribute("competition", competitionService.get(competition.getId()));
		return "competition/view_competition";
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
		if(ThreadContext.getUser()!= null){
			for(Resources resource:resources){
				AttitudeUser au = attitudeService.findAttitudeUserById(AttitudeUser.getId("vote",resource.getId(),ThreadContext.getUser().getId()));
				if(au != null){
					resource.setIsVote("Y");
				}
			}
		}
		model.addAttribute("resources",resources);
		return "competition/list_competition_resource";
	}
	@RequestMapping(value="resource/rankDepartment")
	public String rankDepartment(SearchParam searchParam,Model model){
		model.addAttribute("departments", departmentDao.selectRankCompetitionDepartment(searchParam.getParamMap(), getPageBounds(10, true))) ;
		return "competition/list_rank_department";
	}
	@RequestMapping(value="resource/rankResource")
	public String rankResource(SearchParam searchParam,Model model){
		model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "competition/list_rank_resource";
	}
	//根据资源(resource)获取活动信息
	@RequestMapping(value="getDataByResource")
	@ResponseBody
	public Competition getCompetitionByResource(Resources resource){
		return competitionService.get(resource.getResourceRelations().get(0).getRelation().getId());
	}

}
