package com.haoyu.search.listener;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.competition.event.DeleteCompetitionEvent;
import com.haoyu.search.utils.IndexUtils;
@Component
public class DeleteCompetitionIndexListener implements ApplicationListener<DeleteCompetitionEvent>{

	@Override
	public void onApplicationEvent(DeleteCompetitionEvent event) {
		List<String> ids = (List<String>) event.getSource();
		IndexUtils.deleteDocuments(ids);
	}

}
