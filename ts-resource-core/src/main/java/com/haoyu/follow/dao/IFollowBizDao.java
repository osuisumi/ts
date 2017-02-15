package com.haoyu.follow.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.user.entity.User;



public interface IFollowBizDao {
	
	int createFollows(Map<String,Object> param);
	
	List<User> findFollowUser(Map<String,Object> param,PageBounds pageBounds);

}
