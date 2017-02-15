package com.haoyu.search.listener;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.resource.event.CreateResourceEvent;

@Component
public class CreateResourceIndexListener implements ApplicationListener<CreateResourceEvent>{

	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		Resources resource = (Resources) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", resource.getId());
		map.put("title", resource.getTitle());
		map.put("createTime", DateFormatUtils.format(resource.getCreateTime(), "yyyy-MM-dd"));
		if (ResourceType.DISCOVERY.equals(resource.getType())) {
			map.put("type", "discovery");
		}else{
			map.put("type", "resource");
			if (StringUtils.isNotEmpty(resource.getResourceExtend().getStage())) {
				map.put("stage", resource.getResourceExtend().getStage());
			}
			if (StringUtils.isNotEmpty(resource.getResourceExtend().getSubject())) {
				map.put("subject", resource.getResourceExtend().getSubject());
			}
			if (StringUtils.isNotEmpty(resource.getResourceExtend().getGrade())) {
				map.put("grade", resource.getResourceExtend().getGrade());
			}
		}
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
	}

}
