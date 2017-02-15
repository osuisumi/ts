package com.haoyu.board.controller;


import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.board.entity.Board;
import com.haoyu.board.service.IBoardService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
@Controller
@RequestMapping("board")
public class BoardController extends AbstractBaseController{
	@Resource
	private IBoardService boardService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String List(SearchParam searchParam,Model model){
		model.addAttribute("boards",boardService.list(searchParam,getPageBounds(10, true)));
		return "board/list_board";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Board board, Model model){
		model.addAttribute("board", board);
		return "board/edit_board";
	}
	
	/**
	 * 保存版块信息（新建与更新）
	 * @param board
	 * @param userIdStr 多个用户id所连成的字符串   版主选定
	 * @return
	 */
	@RequestMapping(value="save", method=RequestMethod.POST)
	@ResponseBody
	public Response save(Board board,Model model){
		if(StringUtils.isEmpty(board.getId())){
			return boardService.create(board);
		}else{
			return boardService.update(board);
		}
	}
	/**
	 * 删除版块，可删除多个版块
	 * 多个id用逗号连接成一个字符串，放入到board.id中
	 * @param board
	 */
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Board board, Model model){
		return boardService.delete(board);
	}
	
	/**
	 * 修改版块，返回修改页面
	 * userIds 这个有点特殊，给版主多选设定默认值
	 */
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Board board, Model model){
		board = boardService.get(board);		
		model.addAttribute("board", board);
		return "board/edit_board";
	}
	
	
	@RequestMapping(value="getBoardList")
	@ResponseBody
	public List<Board> listBoard(Board board){
		return boardService.list(board, null);
	}
	
	@RequestMapping(value="listActiveUser")
	public String listActiveUser(SearchParam searchParam,Model model){
		model.addAttribute("activeUsers",boardService.listActiveUser(searchParam, getPageBounds(10, true))); 
		return "board/list_activeUser";
	}
	
	
}
