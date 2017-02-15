package com.haoyu.advert.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.advert.dao.IAdvertDao;
import com.haoyu.advert.entity.Advert;
import com.haoyu.advert.service.IAdvertService;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;

@Service
public class AdvertService implements IAdvertService {

	@Resource
	private IAdvertDao advertDao;
	@Resource
	private IFileService fileService;

	@Override
	public List<Advert> list(SearchParam searchParam, PageBounds pageBounds) {
		return advertDao.list(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public Response create(Advert advert) {
		String id = Identities.uuid2();
		advert.setId(id);
		return advertDao.create(advert) > 0 ? Response.successInstance() : Response.failInstance();
	}

	@Override
	public Response update(Advert advert) {
		String[] array = advert.getId().split(",");
		List<String> ids = Arrays.asList(array);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		advert.setUpdateValue();
		param.put("entity", advert);
		int count = advertDao.updateByIds(param);
		return count > 0 ? Response.successInstance() : Response.successInstance();
	}

	@Override
	public Advert get(Advert advert) {
		return advertDao.get(advert.getId());
	}

	@Override
	public Response delete(Advert advert) {
		String[] array = advert.getId().split(",");
		List<String> ids = Arrays.asList(array);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		advert.setUpdateValue();
		param.put("entity", advert);
		int count = advertDao.deleteByIds(param);
		/*广告图片删除 */
		for(String id : ids){
			List<FileInfo> fileInfos = fileService.listFileInfoByRelationId(id);
			for(FileInfo fileInfo : fileInfos){
				fileService.deleteFileFromServer(fileInfo);
			}
		}
		return count > 0 ? Response.successInstance() : Response.successInstance();
	}

}
