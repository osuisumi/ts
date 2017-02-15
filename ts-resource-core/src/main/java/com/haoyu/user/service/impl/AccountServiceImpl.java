package com.haoyu.user.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.user.dao.IAccountDao;
import com.haoyu.user.entity.Account;
import com.haoyu.user.service.IAccountService;

@Service
public class AccountServiceImpl implements IAccountService{
	
	@Resource
	private IAccountDao accountDao;

	@Override
	public Response update(Account account) {
		String[] idArray = account.getId().split(",");
		List<String> ids = Arrays.asList(idArray);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		account.setUpdatedby(ThreadContext.getUser());
		account.setUpdateTime(System.currentTimeMillis());
		param.put("entity", account);
		int count = accountDao.updateByIds(param);
		return count>0?Response.successInstance():Response.failInstance();
	}

}
