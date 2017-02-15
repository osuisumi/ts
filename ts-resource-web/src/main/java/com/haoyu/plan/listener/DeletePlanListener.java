package com.haoyu.plan.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.tip.plan.entity.Plan;
import com.haoyu.tip.plan.event.DeletePlanEvent;
import com.haoyu.tip.workshop.entity.Workshop;
import com.haoyu.tip.workshop.service.IWorkshopRelationService;
import com.haoyu.tip.workshop.service.IWorkshopService;
@Component
public class DeletePlanListener implements ApplicationListener<DeletePlanEvent>{
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IWorkshopRelationService workShopRelationService;

	@Override
	public void onApplicationEvent(DeletePlanEvent event) {
		Plan plan = (Plan) event.getSource();
		if(plan!=null && plan.getPlanRelations()!=null){
			String workshopId = plan.getPlanRelations().get(0).getRelation().getId();
			Workshop workshop = workshopService.get(workshopId);
			if(workshop!=null && workshop.getWorkshopRelations()!=null){
				workShopRelationService.updatePlanNum(workshop.getWorkshopRelations().get(0));
			}
		}
		
	}

}
