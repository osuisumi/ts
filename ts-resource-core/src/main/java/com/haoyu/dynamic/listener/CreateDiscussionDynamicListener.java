package com.haoyu.dynamic.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.discussion.dao.IDiscussionDao;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.event.CreateDiscussionEvent;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.service.IDynamicService;

/**
 * 帖子创建（CreateDiscussionEvent）的监听器 
 * @author hqy
 */
@Component
public class CreateDiscussionDynamicListener implements ApplicationListener<CreateDiscussionEvent>{
	
	@Resource
	private IDiscussionDao discussionDao;
	
	@Resource
	private IDynamicService dynamicService;
	
	@Override
	public void onApplicationEvent(CreateDiscussionEvent event) {
		/*获取事件源*/
		 Discussion discussion = (Discussion)event.getSource();
		 discussion = discussionDao.selectByPrimaryKey(discussion.getId());
		 /* 创建对应的动态 并设好相关内容  */
		 Dynamic dynamic = new Dynamic();
		 dynamic.setContent(discussion.getTitle());
		 /*我并不知道这个该怎么处理*/
		 dynamic.setDynamicSourceType("discussion");
		 dynamic.setDynamicSourceId(discussion.getId());
		 dynamic.setDynamicSourceRelation(null);
		 /* 保存动态 */
		 dynamicService.create(dynamic);
		 
	}

}
