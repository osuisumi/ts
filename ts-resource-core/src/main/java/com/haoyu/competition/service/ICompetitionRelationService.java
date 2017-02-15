package com.haoyu.competition.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.entity.CompetitionRelation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface ICompetitionRelationService {
	Response create(CompetitionRelation competitionRelation);
	
	Response delete(String id);
	
	Response update(Competition competition);
	
	Response list(SearchParam searchParam,PageBounds pageBounds);
}
