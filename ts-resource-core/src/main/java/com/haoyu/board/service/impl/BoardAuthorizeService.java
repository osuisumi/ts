package com.haoyu.board.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.board.dao.IBoardAuthorizeDao;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.board.service.IBoardAuthorizeService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;


@Service
public class BoardAuthorizeService implements IBoardAuthorizeService{
	@Resource
	private IBoardAuthorizeDao boardAuthorizeDao;

	@Override
	public Response create(BoardAuthorize boardMaster) {
		return boardAuthorizeDao.create(boardMaster)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response delete(BoardAuthorize boardMaster) {
		return boardAuthorizeDao.delete(boardMaster)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response update(BoardAuthorize boardMaster) {
		return boardAuthorizeDao.update(boardMaster)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public List<BoardAuthorize> list(SearchParam searchParam,PageBounds pageBounds) {
		return boardAuthorizeDao.list(searchParam.getParamMap(), pageBounds);
	}

	@Override
	public BoardAuthorize get(BoardAuthorize boardMaster) {
		return boardAuthorizeDao.get(boardMaster.getId());
	}

	@Override
	public Response delete(String id) {
		return boardAuthorizeDao.delete(id)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Map<String, List<BoardAuthorize>> listForMap(SearchParam searchParam, PageBounds pageBounds) {
		return boardAuthorizeDao.selectForMap(searchParam.getParamMap(), pageBounds);
	}

}
