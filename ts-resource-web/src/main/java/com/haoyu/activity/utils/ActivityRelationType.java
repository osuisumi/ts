package com.haoyu.activity.utils;


public enum ActivityRelationType {

	SUBJECTGROUP("subjectGroup"),SCHOOL("school"),WORKSHOP("workshop"),PLAN("plan");
	
	private String type;
	
	private ActivityRelationType(String type){
		this.type = type;
	}
	
	public String toString(){
		return type;
	}
}
