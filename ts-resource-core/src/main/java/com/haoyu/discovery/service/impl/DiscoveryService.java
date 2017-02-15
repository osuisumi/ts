package com.haoyu.discovery.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.discovery.service.IDiscoveryService;
import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;

public class DiscoveryService implements IDiscoveryService{
	
	@Resource
	private IResourceBizDao resourceBizDao;
	@Resource
	private IFileService fileService;
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceRelationService resourceRelationService;

	@Override
	public List<Resources> listDiscovery(SearchParam searchParam, PageBounds pageBounds) {
		return resourceBizDao.select(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Response saveDiscovery(Resources resource) {
		if (StringUtils.isEmpty(resource.getId())) {
			resource.setId(Identities.uuid2());
			if (Collections3.isNotEmpty(resource.getFileInfos())) {
				FileInfo fileInfo = resource.getFileInfos().get(0);
				ResourceExtend resourceExtend = resource.getResourceExtend();
				resourceExtend.setResourceId(resource.getId());
				int count = resourceBizDao.insertResourceExtend(resourceExtend);
				if (count > 0) {
					resource.setTitle(fileInfo.getFileName());
					return resourceService.createResource(resource);
				}
			}
			return Response.failInstance();
		}else {
			return Response.failInstance();
		}
	}

	@Override
	public Resources viewDiscovery(Resources resource) {
		// TODO Auto-generated method stub
		return null;
	}

}
