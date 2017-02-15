package com.haoyu.dynamic.service;

import com.haoyu.sip.dynamic.entity.Dynamic;

/**
 * “动态”服务 
 * @author hqy
 */
public interface IDynamicBizService {
	/** 初始化,最初请求：查询一个学校最新的5条动态  放至缓存 */
	public void initDynamics(String deptId);
	/**更新缓存 ： 每增加一条动态，更新一次缓存内容  */
	public void updateDynamics(Dynamic dynamic);
}
