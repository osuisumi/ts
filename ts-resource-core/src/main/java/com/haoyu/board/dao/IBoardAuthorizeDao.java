package com.haoyu.board.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.entity.BoardAuthorize;
/**
 * 版块授权Dao
 */
public interface IBoardAuthorizeDao {
	/** 增 */
	int create(BoardAuthorize board);
	/** 删  逻辑上*/
	int delete(BoardAuthorize board);
	
	/** 删 物理上  */
	int delete(String id);
	
	/** 改  */
	int update(BoardAuthorize board);
	/** 查 */
	List<BoardAuthorize> list(Map<String,Object> param,PageBounds pageBounds);
	/** 查 */
	BoardAuthorize get(String id);
	
	Map<String, List<BoardAuthorize>> selectForMap(Map<String, Object> paramMap, PageBounds pageBounds);

}
