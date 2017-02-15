package com.haoyu.user.entity;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;

public class UserDept implements Serializable{
	
	private static final long serialVersionUID = 3770080935006883767L;

	private String id;
	
	private String userId;
	
	private String deptId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	
	public static String getId(String userId, String deptId){
		return DigestUtils.md5Hex(userId+deptId);
	}

}
