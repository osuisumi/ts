package com.haoyu.competition.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.dao.ICompetitionRelationDao;
import com.haoyu.competition.entity.CompetitionRelation;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.utils.Identities;

@Repository
public class CompetitionRelationDao extends MybatisDao implements ICompetitionRelationDao{

	@Override
	public int save(CompetitionRelation competitionRelation) {
		if(StringUtils.isEmpty(competitionRelation.getId())){
			competitionRelation.setId(Identities.uuid2());
		}
		competitionRelation.setDefaultValue();
		return super.insert(competitionRelation);
	}

	@Override
	public int delete(CompetitionRelation competitionRelation) {
		competitionRelation.setUpdateValue();
		return super.deleteByLogic(competitionRelation);
	}

	@Override
	public int update(CompetitionRelation competitionRelation) {
		competitionRelation.setUpdateValue();
		return super.update("update", competitionRelation);
	}

	@Override
	public List<CompetitionRelation> select(Map<String, Object> paramMap, PageBounds pageBounds) {
		// TODO Auto-generated method stub
		return null;
	}

}
