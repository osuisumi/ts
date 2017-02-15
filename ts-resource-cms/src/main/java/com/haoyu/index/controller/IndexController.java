package com.haoyu.index.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.dept.service.IDepartmentService;
import com.haoyu.index.entity.Loginer;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceState;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.user.service.IUserService;

@Controller
@RequestMapping()
public class IndexController extends AbstractBaseController{
	
	@Resource
	private IUserService userService;
	@Resource
	private IAuthUserService authUserService;
	@Resource
	private CacheCleaner authRealm;
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IDepartmentService departmentService;

	@RequestMapping("goLogin")
	public String goLogin(){
		return "login";
	}
	
	@RequestMapping("logout")
	public String logout(){
		Subject currentUser = SecurityUtils.getSubject();
		currentUser.logout();
		request.getSession().removeAttribute("loginer");
		return "redirect:"+PropertiesLoader.get("cms.http.domain")+"/logout";
	}
	
	@RequestMapping("login")
	public String login(Loginer loginer){
		try {
			Subject currentUser = SecurityUtils.getSubject();
			if (!currentUser.isAuthenticated()) {
				currentUser.logout();
			}
			UsernamePasswordToken upt = new UsernamePasswordToken(loginer.getUserName(), loginer.getPassword());
			upt.setRememberMe(false);
			currentUser.login(upt);
		} catch (Exception e) {
			request.setAttribute("errorMsg", "用户名或密码错误");
			return "login";
		}
		loginer = userService.getLoginer(loginer);
		if (loginer != null) {
			authRealm.clearUserCacheByIds(Lists.newArrayList(loginer.getId()));
			request.getSession().setAttribute("loginer", loginer);
			return "index";
		}else{
			request.setAttribute("errorMsg", "用户名或密码错误");
			return "login";
		}
	}
	
	@RequestMapping("loginSSO")
	public String loginSSO(Loginer loginer){
		try {
			Subject currentUser = SecurityUtils.getSubject();
			if (!currentUser.isAuthenticated()) {
				currentUser.logout();
			}
			UsernamePasswordToken upt = new UsernamePasswordToken(loginer.getUserName(), loginer.getPassword());
			upt.setRememberMe(false);
			currentUser.login(upt);
			String userName  = (String) currentUser.getPrincipal();
			loginer.setUserName(userName);
		} catch (Exception e) {
			request.setAttribute("errorMsg", "用户名或密码错误");
			return "login";
		}
		loginer = userService.getLoginer(loginer);
		if (loginer != null) {
			authRealm.clearUserCacheByIds(Lists.newArrayList(loginer.getId()));
			request.getSession().setAttribute("loginer", loginer);
			return "index";
		}else{
			request.setAttribute("errorMsg", "用户名或密码错误");
			return "login";
		}
	}
	
	@RequestMapping("home")
	public String home(){
		return "home";
	}
	
	@RequestMapping("loadStatistic")
	public String loadStatistic(Model model){
		Map<String, Object> param = Maps.newHashMap();
		param.put("typeNotEquils", "discovery");
		param.put("stateNotEquils", ResourceState.NOPASS);
		int resourceNum = resourceBizService.getCount(param);
		model.addAttribute("resourceNum", resourceNum);
		param.put("minCreateTime", TimeUtils.getMonthBeginDate().getTime());
		model.addAttribute("newResourceNum", resourceBizService.getCount(param));
		param.remove("minCreateTime");
		param.put("relationId", 1);
		int editorResourceNum = resourceBizService.getCount(param);
		model.addAttribute("editorResourceNum", editorResourceNum);
		model.addAttribute("teacherResourceNum", resourceNum -  editorResourceNum);
		model.addAttribute("deptNum", departmentService.getCount(param));
		model.addAttribute("teacherNum", userService.getCount(param));
		return "statistic";
	}
	
}
