package com.haoyu.plan.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.haoyu.tip.plan.entity.Plan;
import com.haoyu.tip.plan.event.CreatePlanEvent;
import com.haoyu.tip.workshop.entity.Workshop;
import com.haoyu.tip.workshop.service.IWorkshopRelationService;
import com.haoyu.tip.workshop.service.IWorkshopService;
@Component
public class CreatePlanListener implements ApplicationListener<CreatePlanEvent>{
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IWorkshopRelationService workshopRelationService;

	@Override
	public void onApplicationEvent(CreatePlanEvent event) {
		Plan plan = (Plan) event.getSource();
		if(plan!=null && plan.getPlanRelations()!=null){
			if(!StringUtils.isEmpty(plan.getPlanRelations().get(0))){
				String workshopId = plan.getPlanRelations().get(0).getRelation().getId();
				Workshop workshop = workshopService.get(workshopId);
				if(workshop!=null && workshop.getWorkshopRelations()!=null){
					workshopRelationService.updatePlanNum(workshop.getWorkshopRelations().get(0));
				}
			}
		}
		
	}

}
