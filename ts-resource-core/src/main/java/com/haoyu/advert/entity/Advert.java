package com.haoyu.advert.entity;

import java.math.BigDecimal;

import com.haoyu.sip.core.entity.BaseEntity;

/**
 * 广告图片
 * 
 * @author hqy
 */
public class Advert extends BaseEntity {

	private static final long serialVersionUID = -7568397261565233052L;
	/** id */
	private String id;
	/** 标题 */
	private String title;
	/** 位置 */
	private String location;
	/** 状态 */
	private String state;
	/** 序号 */
	private BigDecimal sortNo;
	/** 图片链接 */
	private String imageUrl;
	/** 图片链接地址 **/
	private String imageLink;

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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public BigDecimal getSortNo() {
		return sortNo;
	}

	public void setSortNo(BigDecimal sortNo) {
		this.sortNo = sortNo;
	}

	public String getImageLink() {
		return imageLink;
	}

	public void setImageLink(String imageLink) {
		this.imageLink = imageLink;
	}

}
