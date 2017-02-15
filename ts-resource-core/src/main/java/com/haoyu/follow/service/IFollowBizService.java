package com.haoyu.follow.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.user.entity.User;

public interface IFollowBizService {
	
	Response createFollows(Follow follow);
	
	List<User> findFollowUser(Map<String,Object> parameter,PageBounds pageBounds);

}
