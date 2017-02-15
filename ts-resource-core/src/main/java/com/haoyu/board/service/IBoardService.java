package com.haoyu.board.service;


import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.entity.ActiveUser;
import com.haoyu.board.entity.Board;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

/** 板块服务接口*/
public interface IBoardService {
	/** 增 */
	Response create(Board board);
	/** 删  board.id 可为多个版块id，中间用',"连接的字符串 */
	Response delete(Board board);
	/** 改 */
	Response update(Board board);
	/** 查 */
	List<Board> list(Board board,PageBounds pageBounds);
	/** 查 */
	List<Board> list(SearchParam searchParam,PageBounds pageBounds);	
	/** 查  */
	Board get(Board board);
	/** 查  活跃的用户 */
	List<ActiveUser> listActiveUser(SearchParam searchParam,PageBounds pageBounds);

}

