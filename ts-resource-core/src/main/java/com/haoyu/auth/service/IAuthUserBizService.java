package com.haoyu.auth.service;

import com.haoyu.sip.core.service.Response;
import com.haoyu.user.entity.User;

public interface IAuthUserBizService {

	Response updateUserRole(User user);
	
	Response createUserRole(User user);

}
