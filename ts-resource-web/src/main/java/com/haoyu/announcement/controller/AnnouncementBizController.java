package com.haoyu.announcement.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.announcement.entity.Announcement;
import com.haoyu.tip.announcement.service.IAnnouncementService;

@Controller
@RequestMapping("announcement")
public class AnnouncementBizController extends AbstractBaseController{
	@Resource
	private IAnnouncementService announcementService;
	
	@RequestMapping(value="announcementIndex")
	public String announcementIndex(Model model){
		return "announcement/announcement_index";
	}
	
	/*
	 * 带图片的通知公告预览
	 */
	@RequestMapping(value="list/image")
	public String listJYKX(SearchParam searchParam, Model model){
		List<Announcement> announcements = announcementService.list(searchParam, getPageBounds(10, true));
		model.addAttribute("announcements", announcements);
		Pattern pattern = Pattern.compile("(<img){1}.+?(/>){1}");
		List<AnnouncementImage> announcementImages = new ArrayList<AnnouncementImage>();
		for(Announcement announcement:announcements){
			String content = announcement.getContent();
			Matcher matcher = pattern.matcher(content);
			while(matcher.find()){
				announcementImages.add(new AnnouncementImage(matcher.group(),announcement));
			}
		}
		model.addAttribute("announcementImages", announcementImages);
		return "announcement/list_announcement_image";
	}
	/*
	 * 首页的预览
	 */
	@RequestMapping(value="list/index")
	public String listIndex(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_announcement_index";
	}
	/*
	 *	页面内部的预览
	 */
	@RequestMapping(value="list")
	public String list(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_announcement";
	}
	@RequestMapping(value="more")
	public String listMore(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_more_announcement";
	}
	/*
	 * index的tab页
	 */
	@RequestMapping(value="more/indexTab")
	public String listMoreIndexTab(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_more_announcement_indexTab";
	}
	/*
	 * 工作坊的通知预览(样式特殊)
	 */
	@RequestMapping(value="workshop/list")
	public String listWorkshopAnnouncement(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_workshop_announcement";
	}
	
	@RequestMapping(value="workshop/more")
	public String listMoreWorkshopAnnouncement(SearchParam searchParam,Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return "announcement/list_more_workshop_announcement";
	}
	/**
	 * 学校资讯  hqy
	 */
	@RequestMapping(value="list/xxzx")
	public String listXXZZ(SearchParam searchParam, Model model){
		//取出十条教育快讯
		searchParam.getParamMap().put("state", "1");
		List<Announcement> announcements = announcementService.list(searchParam, getPageBounds(5, true));
		model.addAttribute("announcements", announcements);
		//取出图片
		Pattern pattern = Pattern.compile("(<img){1}.+?(/>){1}");
		List<AnnouncementImage> announcementImages = new ArrayList<AnnouncementImage>();
		for(Announcement announcement:announcements){
			String content = announcement.getContent();
			Matcher matcher = pattern.matcher(content);
			while(matcher.find()){
				announcementImages.add(new AnnouncementImage(matcher.group(),announcement));
			}
		}
		model.addAttribute("announcementImages", announcementImages);
		
		return "announcement/list_announcement_xxzx"; 
	}
	
	public class AnnouncementImage{
		private String imageUrl;
		private Announcement announcement;
		public AnnouncementImage(String imageUrl, Announcement announcement) {
			super();
			this.imageUrl = imageUrl;
			this.announcement = announcement;
		}
		public String getImageUrl() {
			return imageUrl;
		}
		public void setImageUrl(String imageUrl) {
			this.imageUrl = imageUrl;
		}
		public Announcement getAnnouncement() {
			return announcement;
		}
		public void setAnnouncement(Announcement announcement) {
			this.announcement = announcement;
		}
	}

}
