package com.haoyu.follow.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.follow.service.IFollowBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.follow.entity.Follow;

@Controller
@RequestMapping("follow")
public class FollowBizController extends AbstractBaseController{
	@Resource
	private IFollowBizService followBizService;
	
	@RequestMapping(value="createFollows")
	@ResponseBody
	public Response createFollows(Follow follow){
		return followBizService.createFollows(follow);
	}
	

}
