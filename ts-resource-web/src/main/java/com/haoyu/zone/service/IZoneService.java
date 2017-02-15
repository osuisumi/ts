package com.haoyu.zone.service;

import java.util.List;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.textbook.entity.TextBookEntry;
import com.haoyu.user.entity.User;
import com.haoyu.zone.entity.ZoneInfo;

public interface IZoneService {

	//获取已经订阅(关注的textbook)
	List<TextBookEntry> listSubscribed(User user);

	//尚未订阅的
	List<TextBookEntry> listUnsubscribe(User user);

	//所有相关的
	List<TextBookEntry> listAllRelativeTextBook(User user);
	
	Response updateSubscribe(User user,String textBookEntryIds);
	
	ZoneInfo zoneInfo(SearchParam searchParam);

}