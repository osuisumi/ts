package com.haoyu.resource.listener;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.event.CreateResourceEvent;
import com.haoyu.tip.workshop.entity.Workshop;
import com.haoyu.tip.workshop.service.IWorkshopRelationService;
import com.haoyu.tip.workshop.service.IWorkshopService;
import com.haoyu.utils.RelationTypeConstants;

@Component
public class CreateResourceListener implements ApplicationListener<CreateResourceEvent>{
	
	@Resource
	private IWorkshopRelationService workshopRelationService;
	@Resource
	private IWorkshopService workshopService;

	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		Resources resource = (Resources) event.getSource();
		if (resource != null && Collections3.isNotEmpty(resource.getResourceRelations())) {
			for (ResourceRelation resourceRelation : resource.getResourceRelations()) {
				if (resourceRelation.getRelation() != null && StringUtils.isNotEmpty(resourceRelation.getRelation().getId())) {
					if (RelationTypeConstants.WORKSHOP.equals(resourceRelation.getRelation().getType())) {
						Workshop workshop = workshopService.get(resourceRelation.getRelation().getId());
						workshopRelationService.updateResourceNum(workshop.getWorkshopRelations().get(0));
					}
				}
			}
		}
	}

}
