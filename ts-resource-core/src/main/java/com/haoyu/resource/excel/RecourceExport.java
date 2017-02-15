package com.haoyu.resource.excel;

import java.io.Serializable;

import com.haoyu.ipanther.common.excel.annotations.ExcelEntity;
import com.haoyu.ipanther.common.excel.annotations.ExportField;

@ExcelEntity(sortHead = true, sheetName = "导出结果", wrapText = true)
public class RecourceExport implements Serializable {

	private static final long serialVersionUID = 8451679649078502528L;

	@ExportField(colName = "文件名", colWidth = 6000, index = 0)
	private String fileName;
	@ExportField(colName = "资源名", colWidth = 9000, index = 1)
	private String resourceName;
	@ExportField(colName = "目录", colWidth = 12000, index = 2)
	private String url;
	@ExportField(colName = "类型", colWidth = 3000, index = 3)
	private String type;
	@ExportField(colName = "学段", colWidth = 3000, index = 4)
	private String stage;
	@ExportField(colName = "学科", colWidth = 6000, index = 5)
	private String subject;
	@ExportField(colName = "年级", colWidth = 9000, index = 6)
	private String grade;
	@ExportField(colName = "教材版本", colWidth = 6000, index = 7)
	private String tbVersion;
	@ExportField(colName = "章", colWidth = 12000, index = 8)
	private String section;
	@ExportField(colName = "节", colWidth = 12000, index = 9)
	private String chapter;
	@ExportField(colName = "分类", colWidth = 6000, index = 9)
	private String extendType;
	@ExportField(colName = "岗位", colWidth = 6000, index = 9)
	private String post;
	@ExportField(colName = "结果", colWidth = 12000, index = 9)
	private String msg;

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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
