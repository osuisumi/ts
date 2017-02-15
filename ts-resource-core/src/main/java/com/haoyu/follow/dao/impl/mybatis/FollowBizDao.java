package com.haoyu.follow.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.follow.dao.IFollowBizDao;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.user.entity.User;
@Repository
public class FollowBizDao extends MybatisDao implements IFollowBizDao{

	@Override
	public int createFollows(Map<String,Object> param) {
		return super.insert(param);
	}

	@Override
	public List<User> findFollowUser(Map<String, Object> param,PageBounds pageBounds) {
		return super.selectList("selectFollowUser", param, pageBounds);
	}

}
