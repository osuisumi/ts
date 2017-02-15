package com.haoyu.discussion.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.data.redis.core.ZSetOperations.TypedTuple;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.dao.IDiscussionDao;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.board.dao.IBoardDao;
import com.haoyu.board.entity.Board;
import com.haoyu.board.service.IBoardService;
import com.haoyu.discussion.service.IDiscussionBizService;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;
@Service
public class DiscussionBizService implements IDiscussionBizService{
	
	@Resource
	private RedisTemplate redisTemplate;
	
	@Resource
	private IDiscussionDao discussionDao;
	
	@Resource
	private IBoardDao boardDao;

	@Override
	public List<Discussion> listWeekRankDiscussion() {
		String key = PropertiesLoader.get("redis.app.key")+":weekRank_discussion_replyNum";
		Calendar c= Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int week = c.get(Calendar.WEEK_OF_YEAR);
		String thisWeekKey = key+"_"+year+week;
		if (redisTemplate.hasKey(thisWeekKey)) {
			ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
			Set<TypedTuple<String>> set = zSetOperations.reverseRangeByScoreWithScores(thisWeekKey, 0, Double.MAX_VALUE, 0 ,8);
			List<String> ids = Lists.newArrayList();
			Map<String, Integer> scoreMap = Maps.newHashMap();
			for (TypedTuple<String> typedTuple : set) {
				ids.add(typedTuple.getValue());
				scoreMap.put(typedTuple.getValue(), (BigDecimal.valueOf(typedTuple.getScore())).intValue());
			}
			Map<String, Object> param = Maps.newHashMap();
			param.put("ids", ids);
			List<Discussion> discussions = discussionDao.select(param, null);
			for (Discussion d : discussions) {
				d.getDiscussionRelations().get(0).setReplyNum(scoreMap.get(d.getId()));
			}
			Collections.sort(discussions, new Comparator<Discussion>() {
				@Override
				public int compare(Discussion o1, Discussion o2) {
					return o2.getDiscussionRelations().get(0).getReplyNum() - o1.getDiscussionRelations().get(0).getReplyNum();
				}
			});
			return discussions;
		}else{
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
			return listWeekRankDiscussion();
		}
	}

	@Override
	public List<Discussion> listBoardDiscussion(SearchParam searchParam, PageBounds pageBounds) {
		List<Discussion> discussions = discussionDao.select(searchParam.getParamMap(), pageBounds);
		if(CollectionUtils.isNotEmpty(discussions)){
			List<String> boardIds = new ArrayList<String>();
			for(Discussion d:discussions){
				if(d.getDiscussionRelations().size()>0){
					boardIds.add(d.getDiscussionRelations().get(0).getRelation().getId());
				}
			}
			SearchParam searchParamBoard = new SearchParam();
			searchParamBoard.getParamMap().put("ids", boardIds);
			List<Board> boards = boardDao.listByParameter(searchParamBoard.getParamMap(), null);
			Map<String,Board> boardsMap = Collections3.extractToMap(boards, "id", null);
			
			for(Discussion d:discussions){
				if(d.getDiscussionRelations().size()>0){
					String key = d.getDiscussionRelations().get(0).getRelation().getId();
					if(boardsMap.get(key)!=null){
						String value= boardsMap.get(key).getName();
						d.getDiscussionRelations().get(0).getRelation().setType(value);
					}
				}
			}
		}
		return discussions;
	}

}
