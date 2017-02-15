package com.haoyu.discussion.listener;

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
import com.haoyu.aip.discussion.dao.IDiscussionDao;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.event.CreateDiscussionPostEvent;
import com.haoyu.sip.core.utils.PropertiesLoader;
@Component
public class CreateDiscussionPostListener implements ApplicationListener<CreateDiscussionPostEvent>{
	@Resource
	private RedisTemplate redisTemplate;
	@Resource 
	private IDiscussionDao discussionDao;
	
	@Override
	public void onApplicationEvent(CreateDiscussionPostEvent event) {
		DiscussionPost discussionPost = (DiscussionPost) event.getSource();
		DiscussionRelation discussionRelation = discussionPost.getDiscussionUser().getDiscussionRelation();
		String type = discussionRelation.getRelation().getType();
		if ("board".equals(type)) {
			String id = discussionRelation.getDiscussion().getId();
			if (StringUtils.isNotEmpty(id)) {
				String key = PropertiesLoader.get("redis.app.key")+":weekRank_discussion_replyNum";
				Calendar c= Calendar.getInstance();
				int year = c.get(Calendar.YEAR);
				int week = c.get(Calendar.WEEK_OF_YEAR);
				String thisWeekKey = key+"_"+year+week;
				if (!redisTemplate.hasKey(thisWeekKey)) {
					redisTemplate.delete(key+"*");
					Map<String, Object> param = Maps.newHashMap();
					param.put("relationType","board");
					PageBounds pageBounds = new PageBounds(8);
					pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
					List<Discussion> discussions = discussionDao.select(param, pageBounds);
					for (Discussion d : discussions) {
						ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
						zSetOperations.incrementScore(thisWeekKey, d.getId(), 0);
					}
				}
				ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
				zSetOperations.incrementScore(thisWeekKey, id, 1);
			}
		}
		
	}

}
