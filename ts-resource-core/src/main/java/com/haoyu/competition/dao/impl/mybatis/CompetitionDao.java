package com.haoyu.competition.dao.impl.mybatis;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.competition.dao.ICompetitionDao;
import com.haoyu.competition.entity.Competition;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.utils.Identities;
@Repository
public class CompetitionDao extends MybatisDao implements ICompetitionDao{

	@Override
	public int save(Competition competition) {
		if(StringUtils.isEmpty(competition.getId())){
			competition.setId(Identities.uuid2());
		}
		competition.setDefaultValue();
		return super.insert(competition);
	}

	@Override
	public int delete(Competition competition) {
		competition.setUpdateValue();
		return super.delete("deleteByLogic", competition);
	}

	@Override
	public int update(Competition competition) {
		competition.setUpdateValue();
		return super.update("update", competition);
	}

	@Override
	public List<Competition> select(Map<String, Object> paramMap, PageBounds pageBounds) {
		paramMap.put("now", new Date());
		return super.selectList("select", paramMap, pageBounds);
	}

	@Override
	public int deleteByIds(Map<String,Object> paramMap) {
		return super.update("deleteByIds",paramMap);
	}

	@Override
	public Competition get(String id) {
		return super.selectByPrimaryKey(id);
	}

}
