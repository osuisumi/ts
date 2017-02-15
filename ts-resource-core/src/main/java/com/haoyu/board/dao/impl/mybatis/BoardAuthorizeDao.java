package com.haoyu.board.dao.impl.mybatis;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.dao.IBoardAuthorizeDao;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class BoardAuthorizeDao extends MybatisDao implements IBoardAuthorizeDao{

	@Override
	public int create(BoardAuthorize board) {
		board.setDefaultValue();
		return super.insert(board);
	}

	@Override
	public int delete(BoardAuthorize board) {
		return super.deleteByLogic(board);
	}
	
	public int delete(String id){
		return super.deleteByPhysics(id);
	}

	@Override
	public int update(BoardAuthorize board) {
		return super.update(board);
	}

	@Override
	public List<BoardAuthorize> list(Map<String, Object> param,PageBounds pageBounds) {
		return super.selectList("select", param, pageBounds);
	}

	@Override
	public BoardAuthorize get(String id) {
		return super.selectOne(id);
	}

	@Override
	public Map<String, List<BoardAuthorize>> selectForMap(Map<String, Object> paramMap, PageBounds pageBounds) {
		return selectMap("select", paramMap, "boradId", pageBounds);
	}

}
