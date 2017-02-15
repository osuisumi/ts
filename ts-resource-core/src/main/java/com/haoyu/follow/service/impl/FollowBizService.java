package com.haoyu.follow.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.follow.dao.IFollowBizDao;
import com.haoyu.follow.service.IFollowBizService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.user.entity.User;

@Service
public class FollowBizService implements IFollowBizService{
	@Resource
	private IFollowBizDao followBizDao;
	@Override
	public Response createFollows(Follow follow) {
		Map<String,Object> param = new HashMap<String,Object>();
		List<Map<String,Object>> followIdAndFollowedId = new ArrayList<Map<String,Object>>();
		Relation relation = follow.getFollowEntity();
		String followedIds = relation.getId();
		String [] followedIdsArray = followedIds.split(",");
		for(int i=0;i<followedIdsArray.length;i++){
			Map<String,Object> idMap = new HashMap<String,Object>();
			//DigestUtils.md5Hex String userId,String followedId,String followedType
			idMap.put("id",DigestUtils.md5Hex(follow.getCreator().getId()+followedIdsArray[i]+relation.getType()));
			idMap.put("followedId",followedIdsArray[i]);
			followIdAndFollowedId.add(idMap);
		}
		param.put("entity", follow);
		param.put("followIdAndFollowedId", followIdAndFollowedId);
		return followBizDao.createFollows(param)>0?Response.successInstance():Response.failInstance();
	}
	@Override
	public List<User> findFollowUser(Map<String, Object> parameter, PageBounds pageBounds) {
		return this.followBizDao.findFollowUser(parameter, pageBounds);
	}

}
