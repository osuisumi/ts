package com.haoyu.competition.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.dao.ICompetitionDao;
import com.haoyu.competition.dao.ICompetitionRelationDao;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.entity.CompetitionRelation;
import com.haoyu.competition.event.CreateCompetitionEvent;
import com.haoyu.competition.event.DeleteCompetitionEvent;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Identities;

@Service
public class CompetitionService implements ICompetitionService {
	@Resource
	private ICompetitionDao competitionDao;
	@Resource
	private ICompetitionRelationDao competitionRelationDao;
	@Resource
	private IFileService fileService;
	@Resource
	private ApplicationContext applicationContext;

	@Override
	public Response create(Competition competition) {
		return competitionDao.save(competition) > 0 ? Response.successInstance() : Response.failInstance();
	}

	@Override
	public Response delete(Competition competition) {
		return competitionDao.delete(competition) > 0 ? Response.successInstance() : Response.failInstance();
	}

	@Override
	public Response update(Competition competition) {
		return competitionDao.update(competition) > 0 ? Response.successInstance() : Response.failInstance();
	}

	@Override
	public Competition get(String id) {
		return this.competitionDao.get(id);
	}

	@Override
	public List<Competition> list(SearchParam searchParam, PageBounds pageBounds) {
		return competitionDao.select(searchParam.getParamMap(), pageBounds);
	}

	public Response deleteCompetition(Competition competition) {
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> ids = Arrays.asList(competition.getId().split(","));
		map.put("ids",ids);
		int count = this.competitionDao.deleteByIds(map);
		if(count > 0){
			applicationContext.publishEvent(new DeleteCompetitionEvent(ids));
			return Response.successInstance();
		}
		return Response.failInstance();
	}

	public Response createCompetition(Competition competition) {
		String id = Identities.uuid2();
		competition.setId(id);
		Response response = this.create(competition);
		if (response.isSuccess()) {
			if (CollectionUtils.isNotEmpty(competition.getCompetitionRelations())) {
				for (CompetitionRelation competitionRelation : competition.getCompetitionRelations()) {
					competitionRelation.setCompetitionId(id);
					competitionRelationDao.save(competitionRelation);
				}
			}
			applicationContext.publishEvent(new CreateCompetitionEvent(competition));
		}
		return response;
	}

	public Response updateCompetition(Competition competition) {
		Response response = this.update(competition);
		return response;
	}

}
