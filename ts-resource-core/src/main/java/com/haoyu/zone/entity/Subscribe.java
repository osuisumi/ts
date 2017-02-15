package com.haoyu.zone.entity;

public class Subscribe {
	private String id;

	private String text;

	private String value;

	private String type;

	public Subscribe(String text, String value, String type) {
		super();
		this.text = text;
		this.value = value;
		this.type = type;
	}

	public Subscribe() {
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
