package com.haoyu.controller;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.announcement.service.IAnnouncementService;
import com.haoyu.user.utils.AuthRoleEnum;

@Controller
@RequestMapping("announcement")
public class AnnouncementBizController extends AbstractBaseController{
	
	@Resource
	private IAnnouncementService announcementService;
	
	//查询资讯类
	@RequestMapping("listAnnouncement")
	public String listAnnouncement(SearchParam searchParam, Model model){
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole(AuthRoleEnum.SCHOOL_ADMIN.getCode())) {
			searchParam.getParamMap().put("relationId", ((Loginer)Loginer.getLoginer(request)).getDeptId());
			searchParam.getParamMap().put("relationType", "school");
		}else{
			searchParam.getParamMap().put("relationId", "system");
			searchParam.getParamMap().put("relationType", "system");
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_announcement";
	}
	
	@RequestMapping("listHomeAnnouncement")
	public String listHomeAnnouncement(SearchParam searchParam, Model model){
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_home_announcement";
	}

}
