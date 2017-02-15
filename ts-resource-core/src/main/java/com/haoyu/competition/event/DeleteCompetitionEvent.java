package com.haoyu.competition.event;

import org.springframework.context.ApplicationEvent;

public class DeleteCompetitionEvent extends ApplicationEvent{
	private static final long serialVersionUID = 3521524763209701132L;

	public DeleteCompetitionEvent(Object source) {
		super(source);
	}

}
