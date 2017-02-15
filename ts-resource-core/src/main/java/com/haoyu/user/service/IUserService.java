package com.haoyu.user.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.index.entity.Loginer;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.user.entity.User;
import com.haoyu.user.entity.UserDept;

public interface IUserService {

	Loginer getLoginer(Loginer loginer);

	List<User> list(SearchParam searchParam, PageBounds pageBounds);

	Response create(User user);
	
	Response update(User user);

	User get(String id);

	int getCount(Map<String, Object> map);

	Response delete(User user);

	Map<String, Object> importUser(User user, String url, String deptId);

	void exportUser(SearchParam searchParam, HttpServletResponse response);

	void exportTeacher(SearchParam searchParam, HttpServletResponse response);

	Response updateUserDept(UserDept userDept);

	Response resetPassword(User user);
	
//	Map<String, Object> importUser(String url);

//	Response deleteInfoUser(InfoUser infoUser);

}
