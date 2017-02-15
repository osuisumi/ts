package com.haoyu.comment.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.comment.utils.CommentRelationType;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.sip.comment.entity.Comment;
import com.haoyu.sip.comment.event.CreateCommentEvent;
import com.haoyu.tip.resource.service.IResourceRelationService;

@Component
public class CreateCommentForEvaluateListener implements ApplicationListener<CreateCommentEvent>{
	
	@Resource
	private IResourceRelationService resourceRelationService;
	@Resource
	private IResourceBizService resourceBizService;

	@Override
	public void onApplicationEvent(CreateCommentEvent event) {
		Comment comment = (Comment) event.getSource();
		if (comment.getEvaluateScore() > 0 && CommentRelationType.RESOURCES.equals(comment.getRelation().getType())) {
			Resources resource = resourceBizService.getResource(comment.getRelation().getId());
			ResourceExtend re = new ResourceExtend();
			re.setResourceId(resource.getId());
			re.setEvaluateResult(1);
			resourceBizService.updateResourceExtend(re);
		}
	}
}
