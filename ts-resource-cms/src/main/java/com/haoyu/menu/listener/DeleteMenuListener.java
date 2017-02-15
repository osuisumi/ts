package com.haoyu.menu.listener;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.menu.event.DeleteMenuEvent;
import com.haoyu.sip.auth.dao.IAuthPermissionDao;
import com.haoyu.sip.auth.dao.IAuthRoleMenuDao;
import com.haoyu.sip.auth.entity.AuthMenu;
@Component
public class DeleteMenuListener implements ApplicationListener<DeleteMenuEvent>{
	@Resource
	private IAuthPermissionDao authPermissionDao;
	@Resource
	private IAuthRoleMenuDao authRoleMenuDao;
	@Override
	public void onApplicationEvent(DeleteMenuEvent event) {
		List<String> menuIds = (List<String>) event.getSource();
		for(String menuId:menuIds){
			//删除菜单关联的permission
			authPermissionDao.deletePermissionByPhysics(DigestUtils.md5Hex(menuId));
			//删除菜单关联的rolemenu
			authRoleMenuDao.deleteRoleMenu(new AuthMenu(menuId));
		}
	}

}
