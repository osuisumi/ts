package com.haoyu.resource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.result.ResourceUserInfo;
import com.haoyu.zone.entity.ZoneInfo;

public interface IResourceBizDao {

	List<Resources> select(Map<String, Object> paramMap, PageBounds pageBounds);

	int insertResourceExtend(ResourceExtend resourceExtend);

	Resources selectById(String id);
	
	int countMember(Resources resources);
	
	int getCount(Map<String,Object> paramMap);

	List<ResourceUserInfo> selectResourceUserInfo(Map<String,Object> paramMap);

	int updateResourceExtend(ResourceExtend resourceExtend);
	
	int updateResourceExtendByIds(Map<String,Object> param);

	List<Resources> selectRankResource(Map<String, Object> paramMap, PageBounds pageBounds);
	
	ZoneInfo zoneInfo(Map<String,Object> paramMap);

}
