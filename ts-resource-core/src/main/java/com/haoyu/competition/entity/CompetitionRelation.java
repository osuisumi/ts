package com.haoyu.competition.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.Relation;

public class CompetitionRelation extends BaseEntity {
	private static final long serialVersionUID = -7803397808856393203L;
	private String id;
	private String CompetitionId;
	private Relation relation;

	public Relation getRelation() {
		return relation;
	}

	public void setRelation(Relation relation) {
		this.relation = relation;
	}

	public String getCompetitionId() {
		return CompetitionId;
	}

	public void setCompetitionId(String competitionId) {
		CompetitionId = competitionId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
