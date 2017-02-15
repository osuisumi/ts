package com.haoyu.board.dao.impl.mybatis;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.dao.IBoardDao;
import com.haoyu.board.entity.ActiveUser;
import com.haoyu.board.entity.Board;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Identities;

@Repository
public class BoardDao extends MybatisDao implements IBoardDao{

	@Override
	public int create(Board board) {
		if(StringUtils.isEmpty(board.getId())){
			board.setId(Identities.uuid2());
		}
		board.setDefaultValue();
		return super.insert(board);
	}

	@Override
	public int delete(Board board) {
		board.setUpdateValue();
		return super.deleteByLogic(board);
	}

	@Override
	public int update(Board board) {
		board.setUpdateValue();
		return super.update(board);
	}

	@Override
	public List<Board> list(Board board,PageBounds pageBounds) {
		return super.selectList("select", board, pageBounds);
	}
	
	@Override
	public List<Board> listByParameter(Map<String,Object> parameter,PageBounds pageBounds) {
		return super.selectList("selectByparameter", parameter, pageBounds);
	}

	@Override
	public Board get(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public List<ActiveUser> listActiveUser(SearchParam searchParam,PageBounds pageBounds) {
		return super.selectList("listActiveUser",searchParam.getParamMap(),pageBounds);
	}

	@Override
	public int deleteByIds(Map<String, Object> param) {
		return update("deleteByIds", param);
	}

}
