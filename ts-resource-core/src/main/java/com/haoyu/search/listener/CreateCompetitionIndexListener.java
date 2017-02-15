package com.haoyu.search.listener;

import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.event.CreateCompetitionEvent;
import com.haoyu.search.utils.IndexUtils;

public class CreateCompetitionIndexListener implements ApplicationListener<CreateCompetitionEvent>{

	@Override
	public void onApplicationEvent(CreateCompetitionEvent event) {
		Competition competition = (Competition) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", competition.getId());
		map.put("title", competition.getTitle());
		map.put("createTime", DateFormatUtils.format(competition.getCreateTime(), "yyyy-MM-dd"));
		map.put("type", "competition");
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
	}

}
