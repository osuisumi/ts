package com.haoyu.search.listener;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.announcement.event.DeleteAnnouncementEvent;

@Component
public class DeleteAnnouncementIndexListener implements ApplicationListener<DeleteAnnouncementEvent>{

	@Override
	public void onApplicationEvent(DeleteAnnouncementEvent event) {
		List<String> ids = (List<String>) event.getSource();
		IndexUtils.deleteDocuments(ids);
	}

}
