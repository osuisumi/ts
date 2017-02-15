package com.haoyu.resource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.zone.entity.ZoneInfo;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.result.ResourceUserInfo;

@Repository
public class ResourceBizDao extends MybatisDao implements IResourceBizDao{

	@Override
	public List<Resources> select(Map<String, Object> paramMap, PageBounds pageBounds) {
		String type = (String) paramMap.get("type");
		if (StringUtils.isEmpty(type)) {
			paramMap.put("typeNotEquils", "discovery");
		}
		String isHidden = (String) paramMap.get("isHidden");
		if (StringUtils.isEmpty(isHidden)) {
			paramMap.put("isHidden", "N");
		}
		return selectList("select", paramMap, pageBounds);
	}

	@Override
	public int insertResourceExtend(ResourceExtend resourceExtend) {
		return insert("insertResourceExtend", resourceExtend);
	}

	@Override
	public Resources selectById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int countMember(Resources resources) {
		return selectOne("countMember",resources);
	}

	@Override
	public int getCount(Map<String,Object> param) {
		return selectOne("getCount",param);
	}

	@Override
	public List<ResourceUserInfo> selectResourceUserInfo(Map<String,Object> paramMap) {
		return selectList("selectResourceUserInfo",paramMap);
	}

	@Override
	public int updateResourceExtend(ResourceExtend resourceExtend) {
		return update("updateResourceExtend", resourceExtend);
	}

	@Override
	public List<Resources> selectRankResource(Map<String, Object> paramMap, PageBounds pageBounds) {
		String type = (String) paramMap.get("type");
		if (StringUtils.isEmpty(type)) {
			paramMap.put("typeNotEquils", "discovery");
		}
		String isHidden = (String) paramMap.get("isHidden");
		if (StringUtils.isEmpty(isHidden)) {
			paramMap.put("isHidden", "N");
		}
		return selectList("selectRankResource", paramMap, pageBounds);
	}

	@Override
	public ZoneInfo zoneInfo(Map<String, Object> paramMap) {
		return super.selectOne("zoneInfo", paramMap);
	}

	@Override
	public int updateResourceExtendByIds(Map<String, Object> param) {
		return super.update("updateResourceExtendByIds", param);
	}

}
