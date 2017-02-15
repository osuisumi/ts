package com.haoyu.discussion.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityRelation;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityRelationService;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.entity.DiscussionUser;
import com.haoyu.aip.discussion.event.DeleteDiscussionUserEvent;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.sip.core.utils.ThreadContext;

@Component
public class DeleteDiscussionUserListener implements ApplicationListener<DeleteDiscussionUserEvent>{
	
	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityRelationService activityRelationService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IDiscussionPostService discussionPostService;

	@Override
	public void onApplicationEvent(DeleteDiscussionUserEvent event) {
		DiscussionUser discussionUser = (DiscussionUser) event.getSource();
		DiscussionRelation discussionRelation = discussionUser.getDiscussionRelation();
		Discussion discussion = discussionRelation.getDiscussion();
		Activity activity = activityService.getByEntityId(discussion.getId());
		String activityRelationId = ActivityRelation.getId(activity.getId(), discussionRelation.getRelation().getId());
		ActivityRelation activityRelation = new ActivityRelation();
		activityRelation.setId(activityRelationId);
		String activityResultId = ActivityResult.getId(activityRelation.getId(), ThreadContext.getUser().getId());
		activityResultService.deleteActivityResult(activityResultId);
		activityRelationService.updateParticipateNum(activityRelation);
	}

}
