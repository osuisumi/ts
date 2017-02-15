package com.haoyu.discussion.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.sip.core.web.SearchParam;

public interface IDiscussionBizService {
	
	public List<Discussion> listWeekRankDiscussion();
	
	public List<Discussion> listBoardDiscussion(SearchParam searchParam,PageBounds pageBounds);
	

}
