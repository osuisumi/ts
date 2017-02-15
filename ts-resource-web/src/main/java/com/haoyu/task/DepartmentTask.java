package com.haoyu.task;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.dept.dao.IDepartmentDao;
import com.haoyu.dept.modal.DeptStatistic;
import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.user.dao.IUserDao;

@Component
public class DepartmentTask {
	
	@Resource
	private IResourceBizDao resourceBizDao;
	@Resource 
	private IUserDao UserDao;
	@Resource
	private IDepartmentDao departmentDao;
	@Resource
	private RedisTemplate redisTemplate;

	@Scheduled(cron = "0 0 0/1 * * ? ")
	public void initDeptStatistic() {
		Map<String, Object> param = Maps.newHashMap();
		DeptStatistic deptStatistic = new DeptStatistic();
		param.put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
		param.put("typeNotEquils", ResourceType.DISCOVERY);
		int resourceNum = resourceBizDao.getCount(param);
		param.put("minCreateTime", TimeUtils.getMonthBeginDate().getTime());
		int newResourceNum = resourceBizDao.getCount(param);
		param.remove("typeNotEquils");
		param.put("type", ResourceType.DISCOVERY);
		int discoveryNum = resourceBizDao.getCount(param);
		int teacherNum = UserDao.getCount(Maps.newHashMap());
		
		PageBounds pageBounds = new PageBounds(10);
		List<Map<String, Object>> departmentInfos = departmentDao.selectRankDepartment(pageBounds);
//		for (Map<String, Object> map : rankDepartments) {
//			String deptId = (String) map.get("deptId");
//			String deptName = (String) map.get("deptName");
//			int uploadNum = ((BigDecimal) map.get("uploadNum")).intValue();
//			int downloadNum = ((BigDecimal) map.get("downloadNum")).intValue();
//			deptStatistic.getDepartmentInfos().add(deptStatistic.DepartmentInfo(deptId, deptName, downloadNum, uploadNum));
//		}
		
		deptStatistic.setDepartmentInfos(departmentInfos);
		deptStatistic.setDiscoveryNum(discoveryNum);
		deptStatistic.setNewResourceNum(newResourceNum);
		deptStatistic.setResourceNum(resourceNum);
		deptStatistic.setTeacherNum(teacherNum);
		
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(DeptStatistic.class));
		ValueOperations<String,DeptStatistic> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":deptStatistic";
		valueOper.set(key, deptStatistic);
	}
	
	/** 所有学校排名数据   hqy  */
	@Scheduled(cron = "0 0 0/1 * * ? ")
	public void initDeptRank() {		
		List<Map<String, Object>> departmentInfos = departmentDao.selectRankDepartment(null);		
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(ArrayList.class));
		ValueOperations<String,List<Map<String, Object>>> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":deptRank";
		valueOper.set(key, departmentInfos);
	}
	

}
