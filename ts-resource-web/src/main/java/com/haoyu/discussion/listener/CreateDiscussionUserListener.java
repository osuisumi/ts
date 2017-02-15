package com.haoyu.discussion.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityRelation;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityRelationService;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.entity.DiscussionUser;
import com.haoyu.aip.discussion.event.CreateDiscussionUserEvent;
import com.haoyu.sip.core.utils.ThreadContext;

@Component
public class CreateDiscussionUserListener implements ApplicationListener<CreateDiscussionUserEvent>{
	
	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityRelationService activityRelationService;
	@Resource
	private IActivityResultService activityResultService;

	@Override
	public void onApplicationEvent(CreateDiscussionUserEvent event) {
		DiscussionUser discussionUser = (DiscussionUser) event.getSource();
		DiscussionRelation discussionRelation = discussionUser.getDiscussionRelation();
		Discussion discussion = discussionRelation.getDiscussion();
		Activity activity = activityService.getByEntityId(discussion.getId());
		String activityRelationId = ActivityRelation.getId(activity.getId(), discussionRelation.getRelation().getId());
		ActivityRelation activityRelation = new ActivityRelation();
		activityRelation.setId(activityRelationId);
		ActivityResult activityResult = new ActivityResult();
		String activityResultId = ActivityResult.getId(activityRelation.getId(), ThreadContext.getUser().getId());
		activityResult.setId(activityResultId);
		activityResult.setActivityRelation(activityRelation);
		activityResult.setState(ActivityResultState.COMPLETED.toString());
		try {
			activityResultService.create(activityResult);
		} catch (DuplicateKeyException e) {
			
		}
		activityRelationService.updateParticipateNum(activityRelation);
	}

}
