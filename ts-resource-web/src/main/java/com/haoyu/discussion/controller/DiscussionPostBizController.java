package com.haoyu.discussion.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("board/discussion/post")
public class DiscussionPostBizController extends AbstractBaseController{
	@Resource
	private IDiscussionPostService discussionPostService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		model.addAttribute("discussionPosts", discussionPostService.list(searchParam, getPageBounds(10,true)));
		model.addAllAttributes(request.getParameterMap());
		return "board/discussion/list_discussion_post";
	}
	
	@RequestMapping(value="save", method = RequestMethod.POST)
	@ResponseBody
	public Response save(DiscussionPost discussionPost){
		if (StringUtils.isEmpty(discussionPost.getId())) {
			return discussionPostService.createDiscussionPost(discussionPost);
		}else{
			return discussionPostService.updateDiscussionPost(discussionPost);
		}
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(DiscussionPost discussionPost){
		return discussionPostService.deleteDiscussionPost(discussionPost);
	}
	
	@RequestMapping(value="child", method = RequestMethod.GET)
	public String listChild(SearchParam searchParam, Model model){
		model.addAttribute("childPosts", discussionPostService.list(searchParam, getPageBounds(10, false)));
		model.addAllAttributes(request.getParameterMap());
		return "board/discussion/list_child_discussion_post";
	}

}
