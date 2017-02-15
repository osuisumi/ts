package com.haoyu.competition.entity;

import java.util.List;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.TimePeriod;

/**
 * @author Administrator
 *
 */
public class Competition extends BaseEntity {
	private static final long serialVersionUID = 3753677265872473774L;
	private String id;
	private List<CompetitionRelation> competitionRelations;
	// 赛事标题
	private String title;
	// 说明
	private String summary;
	// 面向群体
	private String faceGroup;
	// 活动时间
	private TimePeriod competitionTimePeriod;
	// 投票时间
	private TimePeriod attitudeTimePeriod;
	// 主办机构
	private String mainOrganization;
	// 协办单位
	private String assistOrganization;
	// 承办单位
	private String undertakeOrganization;
	// 咨询电话
	private String phone;
	// 宣传图片
	private String imageUrl;
	// 类型
	private String type;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getFaceGroup() {
		return faceGroup;
	}

	public void setFaceGroup(String faceGroup) {
		this.faceGroup = faceGroup;
	}

	public TimePeriod getCompetitionTimePeriod() {
		return competitionTimePeriod;
	}

	public void setCompetitionTimePeriod(TimePeriod competitionTimePeriod) {
		this.competitionTimePeriod = competitionTimePeriod;
	}

	public TimePeriod getAttitudeTimePeriod() {
		return attitudeTimePeriod;
	}

	public void setAttitudeTimePeriod(TimePeriod attitudeTimePeriod) {
		this.attitudeTimePeriod = attitudeTimePeriod;
	}

	public String getMainOrganization() {
		return mainOrganization;
	}

	public void setMainOrganization(String mainOrganization) {
		this.mainOrganization = mainOrganization;
	}

	public String getAssistOrganization() {
		return assistOrganization;
	}

	public void setAssistOrganization(String assistOrganization) {
		this.assistOrganization = assistOrganization;
	}

	public String getUndertakeOrganization() {
		return undertakeOrganization;
	}

	public void setUndertakeOrganization(String undertakeOrganization) {
		this.undertakeOrganization = undertakeOrganization;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public List<CompetitionRelation> getCompetitionRelations() {
		return competitionRelations;
	}

	public void setCompetitionRelations(List<CompetitionRelation> competitionRelations) {
		this.competitionRelations = competitionRelations;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
}
