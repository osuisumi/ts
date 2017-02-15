package com.haoyu.auth;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;

import com.haoyu.auth.dao.IAuthUserBizDao;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.board.service.IBoardAuthorizeService;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.realm.AuthenticationRealm;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.workshop.entity.WorkshopAuthorize;
import com.haoyu.tip.workshop.service.IWorkshopAuthorizeService;
import com.haoyu.user.utils.AuthRoleEnum;

public class AuthRealm extends AuthenticationRealm {
	
	@Resource
	private IAuthUserBizDao authUserBizDao;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IBoardAuthorizeService boardAuthorizeService; 
	@Resource
	private IWorkshopAuthorizeService workshopAuthorizeService;

	@Override
	public List<AuthUser> findAuthUserByIds(List<String> ids) {
		return authUserBizDao.selectAuthUserByIds(ids);
	}

	@Override
	protected void addAuthorize(SimpleAuthorizationInfo info, PrincipalCollection principals) {
		List<Object> listPrincipals = principals.asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String userId = attributes.get(getUserIdAttributeKey());
		List<AuthRole> roles = authRoleService.findRoleByAuthUser(new AuthUser(userId));
		for (AuthRole authRole : roles) {
			if (!authRole.getId().equals(AuthRoleEnum.TEACHER.getId())) {
				info.addRole("bms_manager");
				break;
			}
		}
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("userId", userId);
		List<BoardAuthorize> boardAuthorizes = boardAuthorizeService.list(searchParam, null);
		for(BoardAuthorize ba:boardAuthorizes){
			info.addRole(ba.getBoardId() + "_" + ba.getRole());
		}
		
		List<WorkshopAuthorize> workshopAuthorizes = workshopAuthorizeService.list(searchParam, null);
		for (Iterator<WorkshopAuthorize> iterator = workshopAuthorizes.iterator(); iterator.hasNext();) {
			WorkshopAuthorize workshopAuthorize = iterator.next();
			if(workshopAuthorize.getRole().equals("master")){
				info.addRole(workshopAuthorize.getWorkshop().getId() + "_" + workshopAuthorize.getRole());
			}else{
				if(("pass".equals(workshopAuthorize.getState()))){
					info.addRole(workshopAuthorize.getWorkshop().getId() + "_" + workshopAuthorize.getRole());
				}
			}
//			if (workshopAuthorize.getRole().equals(WorkshopAuthorizeRole.MASTER.toString()) && !info.getRoles().contains("*_workshop_master")) {
//				info.addRole("*_workshop_master");
//			}else if(workshopAuthorize.getRole().equals(WorkshopAuthorizeRole.ASSIST.toString()) && !info.getRoles().contains("*_workshop_master")){
//				info.addRole("*_workshop_assist");
//			}
		}
	}

	@Override
	protected AuthUser findAuthUserByUsername(String username) {
		return authUserBizDao.selectAuthUserByUsername(username);
	}

	@Override
	protected AuthUser findAuthUserById(String id) {
		return authUserBizDao.selectAuthUserById(id);
	}

}
