package com.haoyu.activity.utils;


public enum ActivityType {

	ASSIGNMENT("assignment"),TEST("test"),SURVEY("survey"),DISCUSSION("discussion"),TEXTINFO("textInfo"),LINK("link"),DEBATE("debate"),LESSON_PLAN("lesson_plan"),TKPK("tkpk"),JXGM("jxgm");
	
	private String type;
	
	private ActivityType(String type){
		this.type = type;
	}
	
	public String toString(){
		return type;
	}
}
