package com.haoyu.competition.event;

import org.springframework.context.ApplicationEvent;

public class CreateCompetitionEvent extends ApplicationEvent{
	private static final long serialVersionUID = -1751582828562432184L;
	public CreateCompetitionEvent(Object source) {
		super(source);
	}

}
