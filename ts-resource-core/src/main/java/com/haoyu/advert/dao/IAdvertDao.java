package com.haoyu.advert.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.advert.entity.Advert;

/**
 * 广告图片 dao层接口
 * @author Administrator
 *
 */
public interface IAdvertDao {
	/** 查 */
	List<Advert> list(Map<String,Object> param,PageBounds pageBounds);
	/** 增 */
	int create(Advert advert);
	/** 改 */
	//int update(Advert advert);
	int updateByIds(Map<String, Object> param);
	/** 查 */
	Advert get(String id);
	/** 删  逻辑上*/
	int deleteByIds(Map<String, Object> param);
	
}
