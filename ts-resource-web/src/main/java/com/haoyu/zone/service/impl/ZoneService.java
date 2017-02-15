package com.haoyu.zone.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.sip.follow.service.IFollowService;
import com.haoyu.sip.textbook.entity.TextBookEntry;
import com.haoyu.sip.textbook.utils.TextBookParam;
import com.haoyu.sip.textbook.utils.TextBookUtils;
import com.haoyu.user.entity.User;
import com.haoyu.user.service.IUserService;
import com.haoyu.zone.entity.ZoneInfo;
import com.haoyu.zone.service.IZoneService;

@Service
public class ZoneService implements IZoneService {
	@Resource
	private IFollowService followService;
	@Resource
	private IUserService userService;
	@Resource
	private IResourceBizDao resourceBizDao;

	// 获取已经订阅(关注的textbook)
	@Override
	public List<TextBookEntry> listSubscribed(User user) {
		return filter(user, "subscribed");
	}

	// 尚未订阅的
	@Override
	public List<TextBookEntry> listUnsubscribe(User user) {
		return filter(user, "unsubscribe");

	}

	// 所有相关的
	@Override
	public List<TextBookEntry> listAllRelativeTextBook(User user) {
		List<TextBookEntry> textBookEntrys = new ArrayList<TextBookEntry>();
		User u = userService.get(user.getId());
		if(StringUtils.isNotEmpty(u.getStage())){
			textBookEntrys.add(TextBookUtils.getEntry("STAGE", u.getStage()));
		}
		if(StringUtils.isNotEmpty(u.getSubject())){
			textBookEntrys.add(TextBookUtils.getEntry("SUBJECT", u.getSubject()));
		}
		if(StringUtils.isEmpty(u.getStage()) && StringUtils.isEmpty(u.getSubject())){
			return textBookEntrys;
		}else{
			TextBookParam textBookParam = new TextBookParam();
			textBookParam.setStage(u.getStage());
			textBookParam.setSubject(u.getSubject());
			textBookParam.setTextBookTypeCode("GRADE");
			textBookEntrys.addAll(TextBookUtils.getEntryList(textBookParam));
			return textBookEntrys;
		}
	
	}

	private List<TextBookEntry> filter(User user, String filterFlag) {
		List<TextBookEntry> textBookEntrys = listAllRelativeTextBook(user);
		List<TextBookEntry> subscribedList = new ArrayList<TextBookEntry>();
		List<TextBookEntry> unSubscribList = new ArrayList<TextBookEntry>();
		Relation relation = new Relation();
		relation.setType("subscribe");
		// 已经关注过的
		List<Follow> follows = followService.findFollowByFollowEntity(relation, null);
		String followedIds = "";
		if(follows!=null && follows.size()>0){
			for(Follow f:follows){
				followedIds =followedIds+f.getFollowEntity().getId()+",";
			}
		}
		for (TextBookEntry tb : textBookEntrys) {
			if(tb!=null){
				if(followedIds.contains(tb.getId())){
					subscribedList.add(tb);
				}else{
					unSubscribList.add(tb);
				}
			}
		}
		if (filterFlag.equals("subscribed")) {
			return subscribedList;
		} else {
			return unSubscribList;
		}
	}

	@Override
	public Response updateSubscribe(User user, String textBookEntryIds) {
		// 之前已订阅的
		List<TextBookEntry> subscribedList = listSubscribed(user);
		// 之前未订阅的
		List<TextBookEntry> unsubscribeList = listUnsubscribe(user);
		// 删除减少的
		List<TextBookEntry> deleteList = new ArrayList<TextBookEntry>();

		for (TextBookEntry tb : subscribedList) {
			if(!textBookEntryIds.contains(tb.getId())){
				deleteList.add(tb);
			}
		}
		// 插入新增的
		List<TextBookEntry> newList = new ArrayList<TextBookEntry>();
		for (TextBookEntry tb : unsubscribeList) {
			if(textBookEntryIds.contains(tb.getId())){
				newList.add(tb);
			}
		}
		int deleteCount = deleteTextBookEntryFollow(user,deleteList);
		int addCount = saveTextBookEntryFollow(user,newList);
		return Response.successInstance();

	}

	private int deleteTextBookEntryFollow(User user,List<TextBookEntry> deleteList){
		int count = 0;
		for(TextBookEntry tb:deleteList){
			Follow follow = new Follow();
			follow.setId(Follow.getId(user.getId(), tb.getId(), "subscribe"));
			Response response = followService.deleteFollow(follow);
			if(response.isSuccess()){
				count = count+1;
			}
		}
		return count;
	}

	private int saveTextBookEntryFollow(User user,List<TextBookEntry> addList){
		int count = 0;
		for(TextBookEntry tb:addList){
			Follow follow = new Follow();
			Relation followEntity = new Relation();
			follow.setDefaultValue();
			followEntity.setId(tb.getId());
			followEntity.setType("subscribe");
			follow.setFollowEntity(followEntity);
			Response response = followService.createFollow(follow);
			if(response.isSuccess()){
				count = count+1;
			}
		}
		return count;
	}
	
	@Override
	public ZoneInfo zoneInfo(SearchParam searchParam) {
		return resourceBizDao.zoneInfo(searchParam.getParamMap());
	}
}
