package com.haoyu.advert.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.advert.entity.Advert;
import com.haoyu.board.entity.Board;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

/**
 * 广告图片服务接口
 * 
 * @author hqy
 */
public interface IAdvertService {
	/** 查 */
	List<Advert> list(SearchParam searchParam, PageBounds pageBounds);

	/** 增 */
	Response create(Advert advert);

	/** 改 */
	Response update(Advert advert);

	/** 查 */
	Advert get(Advert advert);

	/** 删 advert.id 可为多个版块id，中间用',"连接的字符串 */
	Response delete(Advert advert);

}
