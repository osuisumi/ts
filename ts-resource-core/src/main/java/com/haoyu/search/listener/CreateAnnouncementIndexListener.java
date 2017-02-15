package com.haoyu.search.listener;

import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.announcement.entity.Announcement;
import com.haoyu.tip.announcement.event.CreateAnnouncementEvent;

@Component
public class CreateAnnouncementIndexListener implements ApplicationListener<CreateAnnouncementEvent>{

	@Override
	public void onApplicationEvent(CreateAnnouncementEvent event) {
		Announcement announcement = (Announcement) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", announcement.getId());
		map.put("title", announcement.getTitle());
		map.put("createTime", DateFormatUtils.format(announcement.getCreateTime(), "yyyy-MM-dd"));
		map.put("type", "announcement");
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
	}

}
