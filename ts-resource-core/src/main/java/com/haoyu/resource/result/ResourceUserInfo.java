package com.haoyu.resource.result;

import java.io.Serializable;

import com.haoyu.sip.core.entity.User;

public class ResourceUserInfo implements Serializable{
	
	private static final long serialVersionUID = 971021295290366495L;

	private User user;
	
	private int resourceNum;

	public int getResourceNum() {
		return resourceNum;
	}

	public void setResourceNum(int resourceNum) {
		this.resourceNum = resourceNum;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
