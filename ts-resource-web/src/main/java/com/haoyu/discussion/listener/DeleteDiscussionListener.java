package com.haoyu.discussion.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.event.DeleteDiscussionEvent;

@Component
public class DeleteDiscussionListener implements ApplicationListener<DeleteDiscussionEvent>{
	
	@Resource
	private IActivityService activityService;

	@Override
	public void onApplicationEvent(DeleteDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		Activity activity = activityService.getByEntityId(discussion.getId());
		activityService.deleteActivity(activity);
	}

}
