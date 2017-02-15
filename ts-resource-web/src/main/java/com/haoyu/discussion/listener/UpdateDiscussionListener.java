package com.haoyu.discussion.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityRelation;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.event.UpdateDiscussionEvent;
import com.haoyu.sip.utils.Collections3;

@Component
public class UpdateDiscussionListener implements ApplicationListener<UpdateDiscussionEvent>{
	
	@Resource
	private IActivityService activityService;

	@Override
	public void onApplicationEvent(UpdateDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		Activity activity = activityService.getByEntityId(discussion.getId());
		activity.setTitle(discussion.getTitle());
		activity.setState(discussion.getState());
		if (Collections3.isNotEmpty(discussion.getDiscussionRelations())) {
			for (int i = 0; i < discussion.getDiscussionRelations().size(); i++) {
				DiscussionRelation discussionRelation = discussion.getDiscussionRelations().get(i);
				ActivityRelation activityRelation = activity.getActivityRelations().get(i);
				activityRelation.setTimePeriod(discussionRelation.getTimePeriod());
			}
		}
		activityService.updateActivity(activity);
	}

}
