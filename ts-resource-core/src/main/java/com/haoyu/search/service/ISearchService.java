package com.haoyu.search.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.search.entity.PageAndResults;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface ISearchService {

	PageAndResults list(SearchParam searchParam, PageBounds pageBounds);

	Response initSearchIndex();

}
