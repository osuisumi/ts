package com.haoyu.competition.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.entity.Competition;

public interface ICompetitionDao {
	int save(Competition competition);
	
	int delete(Competition competition);
	
	int update(Competition competition);
	
	List<Competition> select(Map<String,Object> paramMap,PageBounds pageBounds);
	
	int deleteByIds(Map<String,Object> paramMap);
	
	Competition get(String id);

}
