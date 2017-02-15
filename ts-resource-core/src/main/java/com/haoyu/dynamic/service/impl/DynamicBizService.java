package com.haoyu.dynamic.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.dynamic.service.IDynamicBizService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.service.IDynamicService;
import com.haoyu.user.dao.IUserDao;
/**
 * “动态”缓存
 * @author hqy
 */
@Service
public class DynamicBizService implements IDynamicBizService{
	

	@Resource
	private RedisTemplate redisTemplate;
    @Resource
    private IDynamicService dynamicService;
    @Resource
    private IUserDao userDao;
	
	//@Scheduled(cron = "0 0 0/1 * * ? ")
    @Override
	public void initDynamics(String deptId) {		
		PageBounds pageBounds = new PageBounds(5);
		pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("deptId", deptId);
		List<Dynamic> dynamics = dynamicService.selectDynamic(map,pageBounds);		
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(ArrayList.class));
		ValueOperations<String,List<Dynamic>> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":dynamics_"+deptId;
		valueOper.set(key, dynamics);
	}
		
    @Override
	public void updateDynamics(Dynamic dynamic){
		User creator =  dynamic.getCreator();
		if(null == creator){
			return ;
		}
		com.haoyu.user.entity.User user= userDao.selectById(creator.getId());
		String deptId = user.getDepartment().getId();
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(ArrayList.class));
		ValueOperations<String,List<Dynamic>> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":dynamics_" + deptId;
		List<Dynamic>  dynamics = null;
		/* 查看缓存中是否有对应的key */
		if(redisTemplate.hasKey(key)){
			dynamics = valueOper.get(key);
			/* 把最新的动态放至最前，如果放至后的动态数大于5条，则把后面的动态去掉，由于是一条一条增加，只需要判断是否等于6即可 */
			dynamics.add(0, dynamic);
			if(dynamics.size() == 6){
				dynamics.remove(5);
			}
			/*把最新的动态加至缓存中*/
			valueOper.set(key, dynamics);
		}else{
			/*没有就初始化*/
			initDynamics(deptId);
			updateDynamics(dynamic);
		}
	}

}
