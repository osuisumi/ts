package com.haoyu.dynamic.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.dynamic.service.impl.DynamicBizService;
import com.haoyu.sip.dynamic.entity.Dynamic;
import com.haoyu.sip.dynamic.event.CreateDynamicEvent;

/**
 * 创建动态的监听器 
 * @author hqy
 */
@Component
public class CreateDynamicListener implements ApplicationListener<CreateDynamicEvent>{
	
	@Resource
	private DynamicBizService dynamicBizService;
	
	@Override
	public void onApplicationEvent(CreateDynamicEvent event) {
		dynamicBizService.updateDynamics((Dynamic)event.getSource());
	}

}

