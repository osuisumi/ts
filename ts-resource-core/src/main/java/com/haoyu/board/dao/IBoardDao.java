package com.haoyu.board.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.entity.ActiveUser;
import com.haoyu.board.entity.Board;
import com.haoyu.sip.core.web.SearchParam;

/**
 * 版块Dao
 */
public interface IBoardDao {
	/** 增 */
	int create(Board board);
	/** 删 */
	int delete(Board board);
	/** 改 */
	int update(Board board);
	/** 查 */
	List<Board> list(Board board,PageBounds pageBounds);
	
	List<Board> listByParameter(Map<String,Object> parameter,PageBounds pageBounds);
	/** 查 */
	Board get(String id);
	/** 查 */
	List<ActiveUser> listActiveUser(SearchParam searchParam,PageBounds pageBounds);
	/** 删除  条件*/
	int deleteByIds(Map<String, Object> param);
}
