package com.haoyu.dynamic.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.discussion.dao.IDiscussionDao;
import com.haoyu.aip.discussion.dao.IDiscussionPostDao;
import com.haoyu.aip.discussion.dao.IDiscussionRelationDao;
import com.haoyu.aip.discussion.dao.IDiscussionUserDao;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.entity.DiscussionUser;
import com.haoyu.aip.discussion.event.CreateDiscussionPostEvent;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.service.IDynamicService;

/**
 * 帖子回复创建（CreateDiscussionPostEvent）的监听器
 * @author hqy
 */
@Component
public class CreateDiscussionPostDynamicListener implements ApplicationListener<CreateDiscussionPostEvent>{
	
	@Resource
	private IDiscussionPostDao discussionPostDao;
	
	@Resource
	private IDynamicService dynamicService;
	
	@Resource 
	private IDiscussionUserDao discussionUserDao;
	
	@Resource
	private IDiscussionRelationDao discussionRelationDao;
	
	@Resource 
	private IDiscussionDao discussionDao;

	@Override
	public void onApplicationEvent(CreateDiscussionPostEvent event) {
		/*获取事件源*/
		DiscussionPost discussionPost = (DiscussionPost)event.getSource();
		discussionPost = discussionPostDao.selectByPrimaryKey(discussionPost.getId());
		 /* 创建对应的动态 并设好相关内容  */
		 Dynamic dynamic = new Dynamic();		 
		 DiscussionUser discussionUser = discussionUserDao.selectByPrimaryKey(discussionPost.getDiscussionUser().getId());
		 DiscussionRelation discussionRelation = discussionRelationDao.selectByPrimaryKey(discussionUser.getDiscussionRelation().getId());
		 Discussion discussion = discussionDao.selectByPrimaryKey(discussionRelation.getDiscussion().getId());
		 dynamic.setContent(discussion.getTitle());
		 dynamic.setDynamicSourceType("discussionpost");
		 dynamic.setDynamicSourceId(discussion.getId());
		 dynamic.setDynamicSourceRelation(null);
		 /* 保存动态 */
		 dynamicService.create(dynamic);
	}

}
