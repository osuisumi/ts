package com.haoyu.user.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.user.entity.Account;
import com.haoyu.user.service.IAccountService;

@Controller
@RequestMapping("account")
public class AccountController extends AbstractBaseController{
	
	@Resource
	private IAccountService accountService;
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Account account){
		return accountService.update(account);
	}

}
