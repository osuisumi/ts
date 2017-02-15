package com.haoyu.resource.excel;

import com.haoyu.ipanther.common.excel.DataType;
import com.haoyu.ipanther.common.excel.annotations.ExcelEntity;
import com.haoyu.ipanther.common.excel.annotations.ImportField;
import com.haoyu.ipanther.common.excel.model.ImportModel;

@ExcelEntity
public class ResourceModel extends ImportModel {
	@ImportField(colName = "文件名", validate = { DataType.REQURIED })
	private String fileName;
	@ImportField(colName = "资源名", validate = { DataType.REQURIED })
	private String resourceName;
	@ImportField(colName = "目录", validate = { DataType.REQURIED })
	private String url;
	@ImportField(colName = "类型", validate = { DataType.REQURIED })
	private String type;
	@ImportField(colName = "学段", validate = { })
	private String stage;
	@ImportField(colName = "学科", validate = {  })
	private String subject;
	@ImportField(colName = "年级", validate = {  })
	private String grade;
	@ImportField(colName = "教材版本", validate = {  })
	private String tbVersion;
	@ImportField(colName = "章", validate = {  })
	private String section;
	@ImportField(colName = "节", validate = {  })
	private String chapter;
	@ImportField(colName = "分类", validate = {  })
	private String extendType;
	@ImportField(colName = "岗位", validate = {  })
	private String post;
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public String getChapter() {
		return chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public String getExtendType() {
		return extendType;
	}
	public void setExtendType(String extendType) {
		this.extendType = extendType;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}

}