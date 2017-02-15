package com.haoyu.search.listener;


import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.event.DeleteDiscussionEvent;
import com.haoyu.search.utils.IndexUtils;

@Component
public class DeleteDiscussionIndexListener implements ApplicationListener<DeleteDiscussionEvent>{

	@Override
	public void onApplicationEvent(DeleteDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		IndexUtils.deleteDocuments(Lists.newArrayList(discussion.getId()));
	}

}
