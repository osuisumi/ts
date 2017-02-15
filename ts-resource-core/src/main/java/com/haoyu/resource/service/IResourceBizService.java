package com.haoyu.resource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;

public interface IResourceBizService {
	
	List<Resources> listResource(SearchParam searchParam, PageBounds pageBounds, boolean getFile);

	List<Resources> listResource(SearchParam searchParam, PageBounds pageBounds);

	Response saveResource(Resources resource);

	Resources viewResource(Resources resource);
	
	Response saveDiscovery(Resources resource);
	
	Map<String, Object> getResourceInfo(SearchParam searchParam);

	Response updateResourceExtend(ResourceExtend resourceExtend);
	
	Response updateResponseExtendByIds(ResourceExtend resourceExtend);

	Resources getResource(String id);

	Response deleteResource(Resources resource);

	Map<String, Object> importResource(String url, String deptId);
	
	Response deleteResourceByIds(String ids);
	
	int getCount(Map<String, Object> paramMap);

	List<Resources> listRankResource();
	
}
