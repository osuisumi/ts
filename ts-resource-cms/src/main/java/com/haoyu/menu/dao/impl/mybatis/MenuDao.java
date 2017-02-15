package com.haoyu.menu.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.menu.dao.IMenuDao;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.core.jdbc.MybatisDao;
@Repository
public class MenuDao extends MybatisDao implements IMenuDao{

	@Override
	public List<AuthMenu> list(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("select",param,pageBounds);
	}

	@Override
	public int delete(Map<String,Object> param) {
		return super.delete("deleteByPhysics", param);
	}

	@Override
	public int count(Map<String, Object> param) {
		return super.selectOne("count",param);
	}

	@Override
	public int save(AuthMenu authMenu) {
		authMenu.setDefaultValue();
		return super.insert("insert",authMenu);
	}

}
