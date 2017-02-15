package com.haoyu.dept.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.dept.entity.Department;
import com.haoyu.dept.modal.DeptStatistic;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.task.DepartmentTask;

@Controller
@RequestMapping("dept")
public class DepartmentController extends AbstractBaseController{
	
	@Resource
	private IDepartmentService departmentService;
	@Resource
	private RedisTemplate redisTemplate;
	@Resource
	private DepartmentTask departmentTask;
	@Resource
	private IResourceBizService resourceBizService;
	
	/** 显示学校，按不同的条件	hqy */
	@RequestMapping("more")
	public String moreDept(SearchParam searchParam, Model model){
		String selected = (String)searchParam.getParamMap().get("selected");		
		if(null != selected && "4".equals(selected)){
			//按排名
			redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(ArrayList.class));
			ValueOperations<String,List<Map<String, Object>>> valueOper = redisTemplate.opsForValue();
			String key = PropertiesLoader.get("redis.app.key")+":deptRank";
			if(redisTemplate.hasKey(key)){
				PageBounds pageBound = getPageBounds(24, true);
				List<Map<String, Object>>  deptMap= valueOper.get(key);	
				Paginator paginator= new Paginator(pageBound.getPage(),24,deptMap.size());
				int end = pageBound.getPage()*24;
				if(deptMap.size() < end ){
					end = deptMap.size();
				}
				PageList<Map<String, Object>> deptPL = new PageList<Map<String,Object>>(deptMap.subList((pageBound.getPage()-1)*24, end),paginator);
				//Paginator(int page, int limit, int totalCount)				
				model.addAttribute("depts", deptPL);
			}else{
				departmentTask.initDeptRank();
				return loadDeptStatistic(model);
			}
			
		}else{
			//其他条件
			PageBounds pb = getPageBounds(24, true);
			List<Department> depts = departmentService.list(searchParam, pb);
			model.addAttribute("depts", depts);
		}	
		return "dept/list_dept";
	}
	/**
	 * 返回  ：根据条件 展示多个学校 hqy
	 */
	@RequestMapping("index")
	public String index(Model model){		
		return "dept/depts_index";
		
	}
	/**
	 * 展示学校 hqy
	 */
	@RequestMapping("")
	public String viewDept(Department dept, Model model){
		dept = departmentService.get(dept.getId());
		if (dept != null) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("stateNotEquils", DictionaryUtils.getEntryValue("EDIT_STATE", "不通过"));
			param.put("typeNotEquils", ResourceType.DISCOVERY);
			param.put("relationId", dept.getId());
			model.addAttribute("resourceNum", resourceBizService.getCount(param));
			param.put("minCreateTime", TimeUtils.getMonthBeginDate().getTime());
			model.addAttribute("newResourceNum", resourceBizService.getCount(param));
		}
		model.addAttribute("dept", dept);
		return "dept/dept_index";
	}
	/**
	 * 分享达人页面 hqy
	 */
	@RequestMapping("/shareMaster")
	public String getShareMaster(SearchParam searchParam, Model model){
		List<User> users = departmentService.getShareMasters(searchParam, getPageBounds(10, true));
		model.addAttribute("users", users);
		return "dept/shareMaster";	
	}
	
	@RequestMapping("loadDeptStatistic")
	public String loadDeptStatistic(Model model){
		DeptStatistic deptStatistic = new DeptStatistic();
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(DeptStatistic.class));
		ValueOperations<String,DeptStatistic> valueOper = redisTemplate.opsForValue();
		String key = PropertiesLoader.get("redis.app.key")+":deptStatistic";
		if(redisTemplate.hasKey(key)){
			deptStatistic = valueOper.get(key);
		}else{
			departmentTask.initDeptStatistic();
			return loadDeptStatistic(model);
		}
		model.addAttribute("deptStatistic", deptStatistic);
		return "dept/dept_statistic";
	}
	
}
