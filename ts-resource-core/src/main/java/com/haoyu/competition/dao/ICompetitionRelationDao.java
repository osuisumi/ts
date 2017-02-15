package com.haoyu.competition.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.entity.CompetitionRelation;

public interface ICompetitionRelationDao {
	int save(CompetitionRelation competitionRelation);

	int delete(CompetitionRelation competitionRelation);

	int update(CompetitionRelation competitionRelation);

	List<CompetitionRelation> select(Map<String, Object> paramMap, PageBounds pageBounds);
}
