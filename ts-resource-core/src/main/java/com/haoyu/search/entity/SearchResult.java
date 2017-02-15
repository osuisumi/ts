package com.haoyu.search.entity;

import java.io.Serializable;

public class SearchResult implements Serializable{
	
	private static final long serialVersionUID = -4912959605196889579L;

	private String id;
	
	private String title;
	
	private String type;
	
	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
