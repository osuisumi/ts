package com.haoyu.search.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.search.entity.PageAndResults;
import com.haoyu.search.service.ISearchService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("search")
public class SearchController extends AbstractBaseController {
	
	@Resource
	private ISearchService searchService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		if (searchParam.getParamMap().containsKey("keywords")) {
			PageAndResults pageAndResults = searchService.list(searchParam, getPageBounds(10, true));
			model.addAttribute("searchResult", pageAndResults.getSearchResults());
			model.addAttribute("paginator", pageAndResults.getPaginator());
		}
		return "search/list_search";
	}
	
	@RequestMapping("initSearchIndex")
	@ResponseBody
	public Response initSearchIndex(){
		return searchService.initSearchIndex();
	}

}
