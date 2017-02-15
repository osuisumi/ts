package com.haoyu.user.dao.impl.mybatis;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.user.dao.IAccountDao;
import com.haoyu.user.entity.Account;

@Repository
public class AccountDao extends MybatisDao implements IAccountDao{

	@Override
	public int insert(Account account) {
		return super.insert(account);
	}

	@Override
	public int update(Account account) {
		return super.update(account);
	}

	@Override
	public int updateByIds(Map<String, Object> param) {
		return update("updateByIds", param);
	}

	@Override
	public int deleteByIds(Map<String, Object> param1) {
		return update("deleteByIds", param1);
	}

}
