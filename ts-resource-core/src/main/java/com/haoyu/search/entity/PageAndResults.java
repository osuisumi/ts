package com.haoyu.search.entity;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.google.common.collect.Lists;

public class PageAndResults {

	private List<SearchResult> searchResults = Lists.newArrayList();
	
	private Paginator paginator;

	public List<SearchResult> getSearchResults() {
		return searchResults;
	}

	public void setSearchResults(List<SearchResult> searchResults) {
		this.searchResults = searchResults;
	}

	public Paginator getPaginator() {
		return paginator;
	}

	public void setPaginator(Paginator paginator) {
		this.paginator = paginator;
	}
	
}
