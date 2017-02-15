package com.haoyu.user.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.index.entity.Loginer;
import com.haoyu.user.entity.User;
import com.haoyu.user.entity.UserDept;

public interface IUserDao {

	Loginer getLoginer(Loginer loginer);
	
	List<User> select(Map<String, Object> paramMap, PageBounds pageBounds);

	int insert(User user);

	int insertUserDept(UserDept userDept);

	User selectById(String id);

	int getCount(Map<String, Object> paramMap);

	int update(User user);

	int updateUserDept(UserDept userDept);

	int deleteByIds(Map<String, Object> param);

//	int insertInfoUser(InfoUser infoUser);
//
//	int deleteInfoUserByIds(List<String> ids);

	

}
