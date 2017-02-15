package com.haoyu.discussion.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.activity.utils.ActivityType;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityRelation;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.event.CreateDiscussionEvent;
import com.haoyu.sip.utils.Collections3;

@Component
public class CreateDiscussionListener implements ApplicationListener<CreateDiscussionEvent>{
	
	@Resource
	private IActivityService activityService;

	@Override
	public void onApplicationEvent(CreateDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		if(discussion.getDiscussionRelations().size()>0 && discussion.getDiscussionRelations().get(0).getRelation().getType().equals("workshop")){
			Activity activity = new Activity();
			activity.setTitle(discussion.getTitle());
			activity.setEntityId(discussion.getId());
			activity.setActivityType(ActivityType.DISCUSSION.toString());
			activity.setState(discussion.getState());
			if (Collections3.isNotEmpty(discussion.getDiscussionRelations())) {
				for (DiscussionRelation discussionRelation : discussion.getDiscussionRelations()) {
					ActivityRelation ar = new ActivityRelation();
					ar.setRelation(discussionRelation.getRelation());
					ar.setTimePeriod(discussionRelation.getTimePeriod());
					activity.getActivityRelations().add(ar);
				}
			}
			activityService.createActivity(activity);
		}
	}

}
