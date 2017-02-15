package com.haoyi.ipanther.common.dict.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyi.ipanther.common.dict.vo.DictEntry;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("dict")
public class DictController extends AbstractBaseController{
	
	@RequestMapping("getEntryList")
	@ResponseBody
	public List<DictEntry> getEntryList(DictEntry dictEntry){
		return DictionaryUtils.getEntryList(dictEntry.getDictTypeCode());
	}
	@RequestMapping("flushCache")
	@ResponseBody
	public Response flushCache(){
		DictionaryUtils.initAll();
		return Response.successInstance();
	}

}
