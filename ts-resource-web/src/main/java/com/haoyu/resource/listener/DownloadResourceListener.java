package com.haoyu.resource.listener;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.utils.ResourceState;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.file.entity.FileRelation;
import com.haoyu.sip.file.event.DownloadFileEvent;

@Component
public class DownloadResourceListener implements ApplicationListener<DownloadFileEvent>{
	
	@Resource
	private RedisTemplate redisTemplate;
	@Resource
	private IResourceBizDao resourceBizDao;

	@Override
	public void onApplicationEvent(DownloadFileEvent event) {
		FileRelation fileRelation = (FileRelation) event.getSource();
		String type = fileRelation.getType();
		if ("resources".equals(type)) {
			String id = fileRelation.getRelation().getId();
			if (StringUtils.isNotEmpty(id)) {
				String key = PropertiesLoader.get("redis.app.key")+":weekRank_resource_downloadNum";
				Calendar c= Calendar.getInstance();
				int year = c.get(Calendar.YEAR);
				int week = c.get(Calendar.WEEK_OF_YEAR);
				String thisWeekKey = key+"_"+year+week;
				if (!redisTemplate.hasKey(thisWeekKey)) {
					redisTemplate.delete(key+"*");
					Map<String, Object> param = Maps.newHashMap();
					param.put("stateNotEquils", ResourceState.NOPASS);
					PageBounds pageBounds = new PageBounds(5);
					pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
					List<Resources> resources = resourceBizDao.select(param, pageBounds);
					for (Resources r : resources) {
						ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
						zSetOperations.incrementScore(thisWeekKey, r.getId(), 0);
					}
				}
				ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
				zSetOperations.incrementScore(thisWeekKey, id, 1);
			}
		}
	}

}
