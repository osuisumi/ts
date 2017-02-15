package com.haoyu.advert.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.advert.dao.IAdvertDao;
import com.haoyu.advert.entity.Advert;
import com.haoyu.board.entity.Board;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class AdvertDao extends MybatisDao implements IAdvertDao {

	@Override
	public List<Advert> list(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("select", param, pageBounds);
	}

	@Override
	public int create(Advert advert) {
		advert.setDefaultValue();
		return super.insert(advert);
	}

	@Override
	public int updateByIds(Map<String, Object> param) {
		return update("updateByIds", param);
	}

	@Override
	public Advert get(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int deleteByIds(Map<String, Object> param) {
		return update("deleteByIds", param);
	}

}
