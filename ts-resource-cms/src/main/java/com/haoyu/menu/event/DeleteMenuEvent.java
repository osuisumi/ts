package com.haoyu.menu.event;

import org.springframework.context.ApplicationEvent;

public class DeleteMenuEvent extends ApplicationEvent{
	private static final long serialVersionUID = -6314049735664006182L;
	public DeleteMenuEvent(Object source) {
		super(source);
	}
}
