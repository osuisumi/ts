package com.haoyu.user.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.user.dao.IUserDao;
import com.haoyu.user.entity.User;
import com.haoyu.user.entity.UserDept;

@Repository
public class UserDao extends MybatisDao implements IUserDao{

	@Override
	public Loginer getLoginer(Loginer loginer) {
		return (Loginer)selectOne("getLoginer", loginer);
	}
	
	@Override
	public List<User> select(Map<String, Object> paramMap, PageBounds pageBounds) {
		return selectList("select", paramMap, pageBounds);
	}

	@Override
	public int insert(User user) {
		return super.insert(user);
	}

	@Override
	public int insertUserDept(UserDept userDept) {
		return insert("insertUserDept", userDept);
	}

	@Override
	public User selectById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int getCount(Map<String, Object> paramMap) {
		return selectOne("getCount", paramMap);
	}

	@Override
	public int update(User user) {
		return super.update(user);
	}

	@Override
	public int updateUserDept(UserDept userDept) {
		return update("updateUserDept", userDept);
	}

	@Override
	public int deleteByIds(Map<String, Object> param) {
		return update("deleteByIds", param);
	}

//	@Override
//	public int insertInfoUser(InfoUser infoUser) {
//		return insert("insertInfoUser",infoUser);
//	}
//
//	@Override
//	public int deleteInfoUserByIds(List<String> ids) {
//		return delete("deleteInfoUserByIds", ids);
//	}

}
