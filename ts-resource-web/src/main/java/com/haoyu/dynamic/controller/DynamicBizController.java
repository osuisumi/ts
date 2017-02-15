package com.haoyu.dynamic.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.dynamic.service.impl.DynamicBizService;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.service.impl.DynamicService;

/**
 * 动态   hqy
 */
@Controller
@RequestMapping("dynamic")
public class DynamicBizController extends AbstractBaseController{
	
	@Resource
	private RedisTemplate redisTemplate;
	
	@Resource
	private DynamicBizService dynamicBizService;
	
	/**
	 *  学校动态展示 
	 */
	@RequestMapping("list")
	public String getDynamics(String deptId,Model model){
		/*从缓存中找查找这个deptId对应的动态 */
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(ArrayList.class));
		ValueOperations<String,List<Dynamic>> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":dynamics_"+deptId;
		List<Dynamic>  dynamics = null;
		/*判断缓存中有没有对应的key*/
		if(redisTemplate.hasKey(key)){
			dynamics = valueOper.get(key);
		}else{
			/* 没有 ，初始化*/
			dynamicBizService.initDynamics(deptId);
			return getDynamics(deptId,model);
		}
		model.addAttribute("dynamics", dynamics);
		return "dynamic/list_dynamic";
	}

}
