package com.haoyu.advert.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.advert.entity.Advert;
import com.haoyu.advert.service.IAdvertService;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

/**
 * 广告图片  hqy
 */
@Controller
@RequestMapping("advert")
public class AdvertController extends AbstractBaseController{
	@Resource
	private IAdvertService advertService;
	
	/** hqy */
	@RequestMapping(value="list")
	public String listg_bn(SearchParam searchParam, Model model){
		List<Advert> adverts = advertService.list(searchParam, null);
		model.addAttribute("adverts", adverts);		
		return "advert/list_advert";
	}
	
	@RequestMapping(value="list/zone")
	public String listZoneAdvert(SearchParam searchParam, Model model){
		List<Advert> adverts = advertService.list(searchParam, null);
		model.addAttribute("adverts", adverts);		
		return "advert/list_zone_advert";
	}

}
