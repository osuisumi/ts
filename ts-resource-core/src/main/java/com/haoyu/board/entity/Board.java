package com.haoyu.board.entity;


import java.util.ArrayList;
import java.util.List;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.file.entity.FileInfo;
/**
 *	板块
 */
public class Board extends BaseEntity{
	private static final long serialVersionUID = 2944008198430380479L;
	/** id */
	private String id;
	/** 板块名 */
	private String name;
	/** 简介 */
	private String summary;
	/** 展示顺序  */
	private int sortNo;
	/** 版块封面 */
	private String imageUrl;
	/** 文件（图片）*/
	private List<FileInfo> fileInfos = new ArrayList<FileInfo>();

	/** 版主  版块与用户的关系  */
	private List<BoardAuthorize> boardAuthorizes = new ArrayList<BoardAuthorize>();
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public int getSortNo() {
		return sortNo;
	}

	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}

	public List<FileInfo> getFileInfos() {
		return fileInfos;
	}

	public void setFileInfos(List<FileInfo> fileInfos) {
		this.fileInfos = fileInfos;
	}

	public List<BoardAuthorize> getBoardAuthorizes() {
		return boardAuthorizes;
	}

	public void setBoardAuthorizes(List<BoardAuthorize> boardAuthorizes) {
		this.boardAuthorizes = boardAuthorizes;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}



}
