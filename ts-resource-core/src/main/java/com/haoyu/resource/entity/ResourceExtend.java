package com.haoyu.resource.entity;

import java.io.Serializable;

public class ResourceExtend implements Serializable{
	
	private static final long serialVersionUID = -6653315550807365164L;

	private String resourceId;
	
	private float evaluateResult;
	
	private String isOriginal;
	
	private String subject;
	
	private String stage;
	
	private String grade;
	
	private String tbVersion;
	
	private String post;
	
	private String type;
	
	private String chapter;
	
	private String section;
	
	private String previewUrl;
	
	private int version;
	
	private String prize;
	
	private String isHidden;

	public String getIsHidden() {
		return isHidden;
	}

	public void setIsHidden(String isHidden) {
		this.isHidden = isHidden;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getPreviewUrl() {
		return previewUrl;
	}

	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
	}

	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public float getEvaluateResult() {
		return evaluateResult;
	}

	public void setEvaluateResult(float evaluateResult) {
		this.evaluateResult = evaluateResult;
	}

	public String getIsOriginal() {
		return isOriginal;
	}

	public void setIsOriginal(String isOriginal) {
		this.isOriginal = isOriginal;
	}

	public String getResourceId() {
		return resourceId;
	}

	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getTbVersion() {
		return tbVersion;
	}

	public void setTbVersion(String tbVersion) {
		this.tbVersion = tbVersion;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPrize() {
		return prize;
	}

	public void setPrize(String prize) {
		this.prize = prize;
	}
	

}
