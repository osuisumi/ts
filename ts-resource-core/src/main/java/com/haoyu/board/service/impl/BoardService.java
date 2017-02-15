package com.haoyu.board.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.board.dao.IBoardDao;
import com.haoyu.board.entity.ActiveUser;
import com.haoyu.board.entity.Board;
import com.haoyu.board.entity.BoardAuthorize;
import com.haoyu.board.service.IBoardAuthorizeService;
import com.haoyu.board.service.IBoardService;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;

@Service
public class BoardService implements IBoardService{
	
	@Resource
	private IBoardDao boardDao;
	@Resource
	private IFileService fileService;
	@Resource
	private IBoardAuthorizeService boardAuthorizeService;
	@Resource
	private CacheCleaner authRealm;

	@Override
	public Response create(Board board) {
		String id = Identities.uuid2();
		board.setId(id);
		int count = boardDao.create(board);
		if(count>0){
			/** 给版块添加版主 */
			List<BoardAuthorize> boardAuthorizes = board.getBoardAuthorizes();
			List<String> uids = Lists.newArrayList();
			if(Collections3.isNotEmpty(boardAuthorizes)){
				for(BoardAuthorize boardAuthorize : boardAuthorizes){
					boardAuthorize.setBoardId(id);
					boardAuthorize.setId(BoardAuthorize.getId(id, boardAuthorize.getUser().getId()));
					boardAuthorize.setRole("master");
					boardAuthorizeService.create(boardAuthorize);
					if (!uids.contains(boardAuthorize.getUser().getId())) {
						uids.add(boardAuthorize.getUser().getId());
					}
				}
			}
			if (Collections3.isNotEmpty(uids)) {
				//清除权限缓存
				authRealm.clearUserCacheByIds(uids);
			}
			if(Collections3.isNotEmpty(boardAuthorizes)){
				fileService.createFileList(board.getFileInfos(), id, "board");
			}
		}
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response delete(Board board) {
		String[] array = board.getId().split(",");
		List<String> ids = Arrays.asList(array);
		Map<String, Object> param = Maps.newHashMap();
		param.put("ids", ids);
		board.setUpdatedby(ThreadContext.getUser());
		board.setUpdateTime(System.currentTimeMillis());
		param.put("entity", board);
		int count = boardDao.deleteByIds(param);
		return count>0?Response.successInstance():Response.successInstance();
	}

	@Override
	public Response update(Board board) {
		int  count = boardDao.update(board);
		if(count > 0 ){
			SearchParam searchParam =  new SearchParam();
			searchParam.getParamMap().put("boardId", board.getId());
			searchParam.getParamMap().put("role","master");
			List<BoardAuthorize> olds = boardAuthorizeService.list(searchParam,null);
			List<Relation> oldUsers = Collections3.extractToList(olds, "user");
			List<String> oldMasterIds = Collections3.extractToList(oldUsers,"id");
			
			List<BoardAuthorize> news = board.getBoardAuthorizes();
			List<Relation> newUsers = Collections3.extractToList(news, "user");
			List<String> newMasterIds = Collections3.extractToList(newUsers,"id");
			
			List<String> addids = Collections3.subtract(newMasterIds, oldMasterIds);
			List<String> deleteids = Collections3.subtract(oldMasterIds, newMasterIds);
			BoardAuthorize ba = null;
			User user = null;
			if (Collections3.isNotEmpty(deleteids)) {
				for (String userId : deleteids) {
					String id = BoardAuthorize.getId(board.getId(), userId);
					boardAuthorizeService.delete(id);
				}
			}
			if (Collections3.isNotEmpty(addids)) {
				for (String userId : addids) {
					String id = BoardAuthorize.getId(board.getId(), userId);
					ba = new BoardAuthorize();
					ba.setId(id);
					ba.setBoardId(board.getId());
					user = new User();
					user.setId(userId);
					ba.setUser(user);
					ba.setRole("master");
					boardAuthorizeService.create(ba);
				}
			}
			List<FileInfo> oldFileInfos = fileService.listFileInfoByRelationId(board.getId());
			return fileService.updateFileList(board.getFileInfos(), oldFileInfos, board.getId(), "board");
		}	
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public List<Board> list(Board board,PageBounds pageBounds) {
		return boardDao.list(board, pageBounds);
	}

	@Override
	public Board get(Board board) {
		Board result = boardDao.get(board.getId());
		result.setFileInfos(fileService.listFileInfoByRelationId(board.getId()));
		return result;
	}

	@Override
	public List<ActiveUser> listActiveUser(SearchParam searchParam,PageBounds pageBounds) {
		return boardDao.listActiveUser(searchParam, pageBounds);
	}

	@Override
	public List<Board> list(SearchParam searchParam, PageBounds pageBounds) {
		List<Board> boards = ((MybatisDao)boardDao).selectList("select", searchParam.getParamMap(), pageBounds);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("role", "master");
		SearchParam searchParam1 = new SearchParam();
		searchParam1.setParamMap(map);
		List<String> ids = Collections3.extractToList(boards, "id");
		map.put("ids",ids);
		List<BoardAuthorize> bas = boardAuthorizeService.list(searchParam1, null);
		Map<String, Board> boardMap = Collections3.extractToMap(boards, "id", null);
		for (BoardAuthorize boardAuthorize : bas) {
			boardMap.get(boardAuthorize.getBoardId()).getBoardAuthorizes().add(boardAuthorize);
		}
		return boards;
	}

}
