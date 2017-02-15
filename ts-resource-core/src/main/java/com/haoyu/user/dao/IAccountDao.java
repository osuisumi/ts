package com.haoyu.user.dao;

import java.util.Map;

import com.haoyu.user.entity.Account;

public interface IAccountDao {

	int insert(Account account);

	int update(Account account);

	int updateByIds(Map<String, Object> param);

	int deleteByIds(Map<String, Object> param1);

}
