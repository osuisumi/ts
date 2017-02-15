package com.haoyu.competition.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.entity.Competition;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface ICompetitionService {
	
	Response create(Competition competition);
	
	Response delete(Competition competition);
	
	Response update(Competition competition);
	
	List<Competition> list(SearchParam searchParam,PageBounds pageBounds);
	
	Competition get(String id);
	
	Response createCompetition(Competition competition);
	
	Response updateCompetition(Competition competition);
	
	Response deleteCompetition(Competition competition);

}
