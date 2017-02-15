package com.haoyi.ipanther.common.dict.vo;

import java.math.BigDecimal;

import com.haoyu.sip.core.entity.BaseEntity;
/*
 * 字典项 和索引多对一
 */
public class DictEntry extends BaseEntity implements Comparable<DictEntry>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5260302474565270270L;
	
	private String id;
	//字典索引
	private String dictTypeCode;
	//编号
	private String dictValue;
	//表示名
	private String dictName;
	//父项的编号
	private String parentValue;
	//父项表示名
	private String parentName;

	private BigDecimal rank;
	//序号
	private BigDecimal sortNo;
	//表里没有这个字段，应该是多余的
	private String parentCode;
	//是否隐藏
	private String isHidden;

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIsHidden() {
		return isHidden;
	}

	public void setIsHidden(String isHidden) {
		this.isHidden = isHidden;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getDictTypeCode() {
		return dictTypeCode;
	}

	public void setDictTypeCode(String dictTypeCode) {
		this.dictTypeCode = dictTypeCode == null ? null : dictTypeCode.trim();
	}

	public String getDictValue() {
		return dictValue;
	}

	public void setDictValue(String dictValue) {
		this.dictValue = dictValue == null ? null : dictValue.trim();
	}

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName == null ? null : dictName.trim();
	}

	public String getParentValue() {
		return parentValue;
	}

	public void setParentValue(String parentValue) {
		this.parentValue = parentValue == null ? null : parentValue.trim();
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName == null ? null : parentName.trim();
	}

	public BigDecimal getRank() {
		return rank;
	}

	public void setRank(BigDecimal rank) {
		this.rank = rank;
	}

	public BigDecimal getSortNo() {
		return sortNo;
	}

	public void setSortNo(BigDecimal sortNo) {
		this.sortNo = sortNo;
	}

	public int compareTo(DictEntry dictEntry) {
		return Integer.parseInt(this.getDictValue())-(Integer.parseInt(dictEntry.getDictValue()));
	}

}