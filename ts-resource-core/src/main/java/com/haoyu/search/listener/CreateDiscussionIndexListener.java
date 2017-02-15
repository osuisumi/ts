package com.haoyu.search.listener;

import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.event.CreateDiscussionEvent;
import com.haoyu.search.utils.IndexUtils;

@Component
public class CreateDiscussionIndexListener implements ApplicationListener<CreateDiscussionEvent>{

	@Override
	public void onApplicationEvent(CreateDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", discussion.getId());
		map.put("title", discussion.getTitle());
		map.put("createTime", DateFormatUtils.format(discussion.getCreateTime(), "yyyy-MM-dd"));
		map.put("type", "discussion");
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
	}

}
