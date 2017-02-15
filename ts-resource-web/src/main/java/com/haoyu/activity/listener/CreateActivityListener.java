package com.haoyu.activity.listener;


import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.activity.utils.ActivityRelationType;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.event.CreateActivityEvent;
import com.haoyu.aip.discussion.service.IDiscussionRelationService;
//import com.haoyu.aip.lessonplan.service.ILessonPlanRelationService;
import com.haoyu.tip.workshop.entity.Workshop;
import com.haoyu.tip.workshop.entity.WorkshopRelation;
import com.haoyu.tip.workshop.service.IWorkshopRelationService;
import com.haoyu.tip.workshop.service.IWorkshopService;

@Component
public class CreateActivityListener implements ApplicationListener<CreateActivityEvent>{
	
	@Resource
	private IWorkshopService workshopService; 
	@Resource
	private IWorkshopRelationService workshopRelationService;
//	@Resource
//	private ILessonPlanRelationService lessonPlanRelationService;
	@Resource
	private IDiscussionRelationService discussionRelationService;

	@Override
	public void onApplicationEvent(CreateActivityEvent event) {
		Activity activity = (Activity)event.getSource();
		String rid = activity.getActivityRelations().get(0).getRelation().getId();
		String rtype = activity.getActivityRelations().get(0).getRelation().getType();
		if(ActivityRelationType.WORKSHOP.toString().equals(rtype)){
			Workshop workshop = workshopService.get(rid);
			WorkshopRelation workshopRelation = workshop.getWorkshopRelations().get(0);
			workshopRelation.setActivityNum(1);
			workshopRelationService.update(workshopRelation);
		}
	}

}
