package com.haoyu.advert.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.advert.entity.Advert;
import com.haoyu.advert.service.IAdvertService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

/**
 * 广告图片控制器
 * 
 * @author hqy
 */
@Controller
@RequestMapping("advert")
public class AdvertController extends AbstractBaseController {
	@Resource
	private IAdvertService advertService;

	@RequestMapping(method = RequestMethod.GET)
	public String list(SearchParam searchParam, Model model) {
		model.addAttribute("adverts", advertService.list(searchParam, getPageBounds(10, true)));
		return "advert/list_advert";
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Advert advert, Model model) {
		model.addAttribute("advert", advert);
		return "advert/edit_advert";
	}

	/**
	 * 保存广告图片信息（新建与更新）
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	public Response save(Advert advert, String image_Url, Model model) {
		if (StringUtils.isEmpty(advert.getImageUrl())) {
			advert.setImageUrl(image_Url);
		}
		if (StringUtils.isEmpty(advert.getId())) {
			return advertService.create(advert);
		} else {
			return advertService.update(advert);
		}
	}

	/**
	 * 删除广告图片，可删除多个广告图片 多个id用逗号连接成一个字符串，放入到advert.id中
	 */
	@RequestMapping(method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Advert advert, Model model) {
		return advertService.delete(advert);
	}

	/**
	 * 更新广告图片，可更新多个广告图片 （状态更新） 多个id用逗号连接成一个字符串，放入到advert.id中
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	@ResponseBody
	public Response update(Advert advert, Model model) {
		return advertService.update(advert);
	}

	/**
	 * 修改广告图片，返回修改页面
	 */
	@RequestMapping(value = "{id}/edit", method = RequestMethod.GET)
	public String edit(Advert advert, Model model) {
		model.addAttribute("advert", advertService.get(advert));
		return "advert/edit_advert";
	}

}
