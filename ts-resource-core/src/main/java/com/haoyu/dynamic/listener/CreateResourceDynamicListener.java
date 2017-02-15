package com.haoyu.dynamic.listener;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.event.CreateResourceEvent;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.service.IDynamicService;

/**
 * 资源创建事件（CreateResourceEvent）的监听器 
 * @author hqy
 */
@Component
public class CreateResourceDynamicListener implements ApplicationListener<CreateResourceEvent>{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IDynamicService dynamicService;
	@Resource
	private ICompetitionService competitionService;
	
	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		/*事件源 */
		Resources resources = (Resources)event.getSource();
		/*针对这个事件源所创建的动态 */
		Dynamic dynamic = new Dynamic();		
		List<ResourceRelation> resourceRelations = resources.getResourceRelations();
		/*resourceRelations 这个东西 只有一条数据 */
		if(resourceRelations.size() == 0){
			/*如果没有数据，重新获取，获取的sql没去查看 */
			resources = resourceService.get(resources.getId());
		}
		Relation relation = resources.getResourceRelations().get(0).getRelation();
		/*判断 是否 在活动中上传的*/
		if(null != relation && null != relation.getType() && relation.getType().equals("competition") ){
			Competition competition = competitionService.get(relation.getId());
			dynamic.setId(competition.getId());
			dynamic.setDynamicSourceType("competition");
			dynamic.setContent(competition.getTitle());
		}else{
			/* 其他途径上传的 */
			dynamic.setDynamicSourceId(resources.getId());
			if(resources.getType().equals("discovery")){
				dynamic.setDynamicSourceType("discovery");
			}else{
				/** classify 和 sync*/
				dynamic.setDynamicSourceType("resource");
			}
			dynamic.setContent(resources.getTitle());
		}
		dynamic.setDynamicSourceRelation(null);		
		/*创建动态 */
		dynamicService.create(dynamic);
	}
}
