package com.haoyu.index.controller;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.user.service.IUserService;

@Controller
@RequestMapping()
public class IndexController extends AbstractBaseController{
	
	@Resource
	private IUserService userService;
	@Resource
	private CacheCleaner authRealm;

	@RequestMapping("goLogin")
	public String goLogin(){
		return "login";
	}
	
	@RequestMapping("logout")
	public String logout(){
		request.getSession().removeAttribute("loginer");
		Subject currentUser = SecurityUtils.getSubject();
		currentUser.logout();
		return "redirect:home";
	}
	
	@RequestMapping("index")
	public String index(Model model){
		model.addAllAttributes(request.getParameterMap());
		return "index";
	}
	
	@RequestMapping("home")
	public String home(){
		return "home";
	}
	
	@RequestMapping("login")
	@ResponseBody
	public Response login(Loginer loginer){
		try {
			String password = loginer.getPassword();
			Subject currentUser = SecurityUtils.getSubject();
			if (!currentUser.isAuthenticated()) {
				currentUser.logout();
			}
			UsernamePasswordToken upt = new UsernamePasswordToken(loginer.getUserName(), loginer.getPassword());
			upt.setRememberMe(false);
			currentUser.login(upt);
			loginer = userService.getLoginer(loginer);
			if (loginer != null) {
				String userName  = (String) currentUser.getPrincipal();
				loginer.setUserName(userName);
				loginer.setPassword(password);
				request.getSession().setAttribute("loginer", loginer);
				authRealm.clearUserCacheByIds(Lists.newArrayList(loginer.getId()));
				return Response.successInstance();
			}else{
				return Response.failInstance().responseMsg("用户名或密码错误");
			}
		} catch (Exception e) {
			return Response.failInstance().responseMsg("用户名或密码错误");
		}
	}
	
	@RequestMapping("top")
	public String top(int index, Model model){
		model.addAttribute("index", index);
		return "include/top";
	}
	
}
