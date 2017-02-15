package com.haoyu.board.controller;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.board.entity.Board;
import com.haoyu.board.service.IBoardService;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
@Controller
@RequestMapping("board")
public class BoardController extends AbstractBaseController{
	@Resource
	private IBoardService boardService;
	
	@RequestMapping("index")
	public String index(Model model){
		model.addAllAttributes(request.getParameterMap());
		return "board/board_index";
	}
	
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
