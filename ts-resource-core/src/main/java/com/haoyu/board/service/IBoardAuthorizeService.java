package com.haoyu.board.service;


import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

/**
 * 版块授权服务接口
 */
public interface IBoardAuthorizeService {
	/** 增 */
	Response create(BoardAuthorize boardMaster);
	/** 删  逻辑上  */
	Response delete(BoardAuthorize boardMaster);
	
	/** 删  物理上 */
	Response delete(String id);
	
	/** 改 */
	Response update(BoardAuthorize boardMaster);
	/** 查 */
	List<BoardAuthorize> list(SearchParam searchParam,PageBounds pageBounds);
	/** 查 */
	BoardAuthorize get(BoardAuthorize boardMaster);
	
	Map<String, List<BoardAuthorize>> listForMap(SearchParam searchParam, PageBounds pageBounds);

}