package com.haoyu.user.utils;

public enum AuthRoleEnum {

	TEACHER("teacher", "4"), SCHOOL_ADMIN("schoolAdmin", "3"), EDITOR("editor", "2");
	
	private String code;
	
	private String id;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	private AuthRoleEnum (String code, String id){
		this.code = code;
		this.id = id;
	}
	
}
