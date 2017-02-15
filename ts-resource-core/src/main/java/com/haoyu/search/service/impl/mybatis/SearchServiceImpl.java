package com.haoyu.search.service.impl.mybatis;

import java.text.ParseException;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.lucene.document.Document;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.competition.entity.Competition;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.search.entity.PageAndResults;
import com.haoyu.search.entity.QueryField;
import com.haoyu.search.entity.SearchResult;
import com.haoyu.search.entity.SearchResultBean;
import com.haoyu.search.service.ISearchService;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.search.utils.SearchUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.announcement.entity.Announcement;
import com.haoyu.tip.announcement.service.IAnnouncementService;

@Service
public class SearchServiceImpl implements ISearchService {

	@Resource
	private IAnnouncementService announcementService;
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private ICompetitionService competitionService;

	@Override
	public PageAndResults list(SearchParam searchParam, PageBounds pageBounds) {
		List<QueryField> queryFields = Lists.newArrayList();
		if (searchParam.getParamMap().containsKey("keywords")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)searchParam.getParamMap().get("keywords"));
			queryField.setFields(new String[]{"title"});
			queryFields.add(queryField);
		}
		if (searchParam.getParamMap().containsKey("type")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)searchParam.getParamMap().get("type"));
			queryField.setFields(new String[]{"type"});
			queryFields.add(queryField);
		}
		if (searchParam.getParamMap().containsKey("stage")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)searchParam.getParamMap().get("stage"));
			queryField.setFields(new String[]{"stage"});
			queryFields.add(queryField);
		}
		if (searchParam.getParamMap().containsKey("subject")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)searchParam.getParamMap().get("subject"));
			queryField.setFields(new String[]{"subject"});
			queryFields.add(queryField);
		}
		if (searchParam.getParamMap().containsKey("grade")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)searchParam.getParamMap().get("grade"));
			queryField.setFields(new String[]{"grade"});
			queryFields.add(queryField);
		}
		SearchResultBean searchResultBean = SearchUtils.searchDocument(queryFields, pageBounds.getPage(), pageBounds.getLimit(), true, "title", "<em class='u-key'>", "</em>");
		List<SearchResult> searchResults = Lists.newArrayList();
		if (Collections3.isNotEmpty(searchResultBean.getDocuments())) {
			for (Document doc : searchResultBean.getDocuments()) {
				SearchResult searchResult = new SearchResult();
				searchResult.setId(doc.get("id"));
//				if (searchResultBean.getHighLightValues().containsKey(searchResult.getId())) {
//					searchResult.setTitle(searchResultBean.getHighLightValues().get(searchResult.getId()));
//				}else{
//					searchResult.setTitle(doc.get("title"));
//				}
				searchResult.setTitle(doc.get("title"));
				searchResult.setType(doc.get("type"));
				searchResult.setCreateTime(doc.get("createTime"));
				searchResults.add(searchResult);
			}
		}
		Paginator paginator = new Paginator(pageBounds.getPage(), pageBounds.getLimit(), searchResultBean.getTotalCount());
		PageAndResults pageAndResults = new PageAndResults();
		pageAndResults.setSearchResults(searchResults);
		pageAndResults.setPaginator(paginator);
		return pageAndResults;
	}

	@Override
	public Response initSearchIndex() {
		List<Map<String, Object>> list = Lists.newArrayList();
		List<Announcement> announcements = announcementService.list(new SearchParam(), null);
		if (Collections3.isNotEmpty(announcements)) {
			for (Announcement announcement : announcements) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", announcement.getId());
				map.put("title", announcement.getTitle());
				map.put("createTime", DateFormatUtils.format(announcement.getCreateTime(), "yyyy-MM-dd"));
				map.put("type", "announcement");
				list.add(map);
			}
		}
		List<Resources> resources = resourceBizService.listResource(new SearchParam(), null);
		if (Collections3.isNotEmpty(resources)) {
			for (Resources resource : resources) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", resource.getId());
				map.put("title", resource.getTitle());
				map.put("createTime", DateFormatUtils.format(resource.getCreateTime(), "yyyy-MM-dd"));
				if (ResourceType.DISCOVERY.equals(resource.getType())) {
					map.put("type", "discovery");
				}else{
					map.put("type", "resource");
					if (StringUtils.isNotEmpty(resource.getResourceExtend().getStage())) {
						map.put("stage", resource.getResourceExtend().getStage());
					}
					if (StringUtils.isNotEmpty(resource.getResourceExtend().getSubject())) {
						map.put("subject", resource.getResourceExtend().getSubject());
					}
					if (StringUtils.isNotEmpty(resource.getResourceExtend().getGrade())) {
						map.put("grade", resource.getResourceExtend().getGrade());
					}
				}
				list.add(map);
			}
		}
		List<Discussion> discussions = discussionService.list(new SearchParam(), null);
		if (Collections3.isNotEmpty(discussions)) {
			for (Discussion discussion : discussions) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", discussion.getId());
				map.put("title", discussion.getTitle());
				map.put("createTime", DateFormatUtils.format(discussion.getCreateTime(), "yyyy-MM-dd"));
				map.put("type", "discussion");
				list.add(map);
			}
		}
		List<Competition> competitions = competitionService.list(new SearchParam(), null);
		if(Collections3.isNotEmpty(competitions)){
			for(Competition competition:competitions){
				Map<String,Object> map = Maps.newHashMap();
				map.put("id",competition.getId());
				map.put("title",competition.getTitle());
				map.put("createTime", DateFormatUtils.format(competition.getCreateTime(), "yyyy-MM-dd"));
				map.put("type", "competition");
				list.add(map);
			}
		}
		Collections.sort(list, new Comparator<Map<String, Object>>() {
			@Override
			public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				try {
					Date createTime1 = DateUtils.parseDate((String)o1.get("createTime"), "yyyy-MM-dd");
					Date createTime2 = DateUtils.parseDate((String)o2.get("createTime"), "yyyy-MM-dd");
					return (int) (createTime2.getTime() - createTime1.getTime());
				} catch (ParseException e) {
					e.printStackTrace();
				}
				return 0;
			}
		});
		IndexUtils.updateIndex(list, true);
		return Response.successInstance();
	}

}
