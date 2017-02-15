package com.haoyu.discovery.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.resource.entity.Resources;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface IDiscoveryService {
	
	List<Resources> listDiscovery(SearchParam searchParam, PageBounds pageBounds);

	Response saveDiscovery(Resources resource);

	Resources viewDiscovery(Resources resource);

}
