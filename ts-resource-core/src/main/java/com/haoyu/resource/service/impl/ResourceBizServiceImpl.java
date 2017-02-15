package com.haoyu.resource.service.impl;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.data.redis.core.ZSetOperations.TypedTuple;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.utils.DictionaryUtils;
import com.haoyu.ipanther.common.excel.ExcelImport;
import com.haoyu.resource.dao.IResourceBizDao;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.resource.utils.ResourceState;
import com.haoyu.resource.utils.ResourceType;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.entity.FileRelation;
import com.haoyu.sip.file.service.IFileInfoService;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.textbook.utils.TextBookParam;
import com.haoyu.sip.textbook.utils.TextBookUtils;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.resource.entity.ResourceExtend;
import com.haoyu.resource.entity.Resources;
import com.haoyu.resource.excel.RecourceExport;
import com.haoyu.resource.excel.ResourceModel;
import com.haoyu.resource.result.ResourceUserInfo;

@Service
public class ResourceBizServiceImpl implements IResourceBizService{
	
	@Resource
	private IResourceBizDao resourceBizDao;
	@Resource
	private IFileService fileService;
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceRelationService resourceRelationService;
	@Resource
	private IFileInfoService fileInfoService;
	@Resource
	private RedisTemplate redisTemplate;
	
	@Override
	public List<Resources> listResource(SearchParam searchParam, PageBounds pageBounds, boolean getFile) {
		List<Resources> resources = resourceBizDao.select(searchParam.getParamMap(), pageBounds);
		if (getFile) {
			for (Resources resource : resources) {
				resource.setFileInfos(fileService.listFileInfoByRelationId(resource.getId()));
			}
			return resources;
		}else{
			return resources;
		}
	}

	@Override
	public List<Resources> listResource(SearchParam searchParam, PageBounds pageBounds) {
		return this.listResource(searchParam, pageBounds, false);
	}

	@Override
	public Response saveResource(Resources resource) {
		if (StringUtils.isEmpty(resource.getId())) {
			resource.setId(Identities.uuid2());
			if (Collections3.isNotEmpty(resource.getFileInfos())) {
				ResourceExtend resourceExtend = resource.getResourceExtend();
				resourceExtend.setResourceId(resource.getId());
				int count = resourceBizDao.insertResourceExtend(resourceExtend);
				if (count > 0) {
					FileInfo fileInfo = resource.getFileInfos().get(0);
					resource.setTitle(fileInfo.getFileName());
				}
				return resourceService.createResource(resource);
			}
			return Response.failInstance();
		}else {
			ResourceExtend resourceExtend = resource.getResourceExtend();
			resourceExtend.setResourceId(resource.getId());
			int count = resourceBizDao.updateResourceExtend(resourceExtend);
			if (count > 0) {
				FileInfo fileInfo = resource.getFileInfos().get(0);
				resource.setTitle(fileInfo.getFileName());
				return resourceService.updateResource(resource);
			}
			return Response.failInstance();
		}
	}

	@Override
	public Resources viewResource(Resources resource) {
		resource = this.getResource(resource.getId());
		if (resource != null) {
			if (Collections3.isNotEmpty(resource.getResourceRelations())) {
				for(ResourceRelation resourceRelation : resource.getResourceRelations()){
					ResourceRelation rr = new ResourceRelation();
					rr.setId(resourceRelation.getId());
					resourceRelationService.updateBrowseNum(rr);
				}
			}
		}
		return resource;
	}

	@Override
	public Response saveDiscovery(Resources resource) {
		if (StringUtils.isEmpty(resource.getId())) {
			resource.setId(Identities.uuid2());
			Response response = resourceService.createResource(resource);
			if(response.isSuccess()){
				ResourceExtend resourceExtend = resource.getResourceExtend();
				resourceExtend.setResourceId(resource.getId());
				resourceBizDao.insertResourceExtend(resourceExtend);
			}
			return response;
		}else {
			//跟新
			ResourceExtend resourceExtend = resource.getResourceExtend();
			resourceExtend.setResourceId(resource.getId());
			int count = resourceBizDao.updateResourceExtend(resourceExtend);
			if(count>0){
				return resourceService.updateResource(resource);
			}else{
				return Response.failInstance();
			}
			
		}
	}

	@Override
	public Map<String, Object> getResourceInfo(SearchParam searchParam) {
		List<ResourceUserInfo> resourceUserInfos = resourceBizDao.selectResourceUserInfo(searchParam.getParamMap());
		int resourceNum = 0;
		for (ResourceUserInfo resourceUserInfo : resourceUserInfos) {
			resourceNum += resourceUserInfo.getResourceNum();
		}
		Map<String, Object> resultMap = Maps.newHashMap();
		resultMap.put("resourceNum", resourceNum);
		resultMap.put("teacherNum", resourceUserInfos.size());
		return resultMap;
	}

	@Override
	public Response updateResourceExtend(ResourceExtend resourceExtend) {
		int count = resourceBizDao.updateResourceExtend(resourceExtend);
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Resources getResource(String id) {
		Resources resource = resourceBizDao.selectById(id);
		if (resource != null) {
			resource.setFileInfos(fileService.listFileInfoByRelationId(resource.getId()));
		}
		return resource;
	}

	@Override
	public Response deleteResource(Resources resource) {
		Response response = resourceService.deleteByIds(resource.getId());
		if (response.isSuccess()) {
			String [] idArray = resource.getId().split(",");
			for (String id : idArray) {
				List<FileInfo> oldFileInfos = fileService.listFileInfoByRelationId(id);
				for (FileInfo fileInfo : oldFileInfos) {
					fileService.deleteFileFromServer(fileInfo);
				}
			}
		}
		return response;
	}

	@Override
	public Map<String, Object> importResource(String url, String deptId) {
		String tempFileDir = PropertiesLoader.get("file.temp.dir");
		String remoteFileDir = PropertiesLoader.get("file.remote.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<RecourceExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<ResourceModel> ei = new ExcelImport<ResourceModel>(ResourceModel.class);
		Collection<ResourceModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		for (ResourceModel rm : list) {
			RecourceExport resourceExport = new RecourceExport();
			int dataRow = rm.getLineNumber();
			String fileDir = rm.getUrl();
			String fileName = rm.getFileName();
			String fileUrl = remoteFileDir + File.separator + fileDir + File.separator + fileName;
			File resourceFile = new File(fileUrl);
			if (resourceFile.exists()) {
				String id = DigestUtils.md5Hex(fileUrl);
				Resources resource = this.getResource(id);
				if (resource == null) {
					String type = rm.getType();
					//设置resource
					resource = new Resources();
					resource.setId(id);
					resource.setType(type);
					resource.setState(ResourceState.PASS);
					resource.setTitle(rm.getResourceName());
					
					//设置resourceRelation
					ResourceRelation resourceRelation = new ResourceRelation();
					resourceRelation.setRelation(new Relation(deptId));
					resource.setResourceRelations(Lists.newArrayList(resourceRelation));
					
					//设置resourceExtend
					ResourceExtend resourceExtend = new ResourceExtend();
					resourceExtend.setResourceId(resource.getId());
					if (type.equals(ResourceType.SYNC)) {
						String stage = TextBookUtils.getEntryValue("STAGE", rm.getStage());
						String subject = TextBookUtils.getEntryValue("SUBJECT", rm.getSubject());
						String grade = TextBookUtils.getEntryValue("GRADE", rm.getGrade());
						String tbVersion = TextBookUtils.getEntryValue("VERSION", rm.getTbVersion());
						String section = TextBookUtils.getEntryValue("SECTION", rm.getSection());
						resourceExtend.setStage(stage);
						resourceExtend.setSubject(subject);
						resourceExtend.setGrade(grade);
						resourceExtend.setTbVersion(tbVersion);
						resourceExtend.setSection(section);
						TextBookParam textBookParam = new TextBookParam();
						textBookParam.setStage(stage);
						textBookParam.setSubject(subject);
						textBookParam.setGrade(grade);
						textBookParam.setVersion(tbVersion);
						textBookParam.setSection(section);
						textBookParam.setTextBookTypeCode("SECTION");
						textBookParam.setTextBookName(rm.getChapter());
						resourceExtend.setChapter(TextBookUtils.getEntryValue(textBookParam)); 
						resourceExtend.setType(DictionaryUtils.getEntryValue("RESOURCE_SYNC_TYPE", rm.getExtendType()));
					}else{
						resourceExtend.setPost(DictionaryUtils.getEntryValue("POST", rm.getPost()));
						resourceExtend.setType(DictionaryUtils.getEntryValue("RESOURCE_CLASSIFY_TYPE", rm.getExtendType()));
					}
					int count = resourceBizDao.insertResourceExtend(resourceExtend);
					if (count > 0) {
						Response response = resourceService.createResource(resource);
						if (response.isSuccess()) {
							//设置fileInfo
							FileInfo fileInfo = new FileInfo();
							fileInfo.setFileName(rm.getResourceName());
							fileInfo.setFileSize(resourceFile.length());
							fileInfo.setUrl(fileDir + File.separator + fileName);
							
							//设置fileRelation
							FileRelation fileRelation = new FileRelation();
							fileRelation.setRelation(new Relation(resource.getId(), "resources"));
							fileInfo.setFileRelations(Lists.newArrayList(fileRelation));
							response = fileInfoService.createFileInfo(fileInfo);
							if (response.isSuccess()) {
								try {
									PropertyUtils.copyProperties(resourceExport, rm);
								} catch (IllegalAccessException e) {
									e.printStackTrace();
								} catch (InvocationTargetException e) {
									e.printStackTrace();
								} catch (NoSuchMethodException e) {
									e.printStackTrace();
								}
								resourceExport.setMsg("导入成功");
								successList.add(resourceExport);
							}
						}
					}
				}else{
					resourceExport.setMsg("导入失败,第" + dataRow + "行,该文件已导入");
					failList.add("第" + dataRow + "行,该文件已导入");
				}
			}else{
				resourceExport.setMsg("导入失败,第" + dataRow + "行,找不到该文件,请确认文件名和目录是否正确");
				failList.add("第" + dataRow + "行,找不到该文件,请确认文件名和目录是否正确");
			}
		}
		resultMap.put("successList", successList);
		resultMap.put("failList", failList);
		return resultMap;
	}

	@Override
	public Response deleteResourceByIds(String ids) {
		Response response = resourceService.deleteByIds(ids);
		if(response.isSuccess()){
			String [] idsArray = ids.split(",");
			for(int i=0;i<ids.length();i++){
				List<FileInfo> oldFileInfos = fileService.listFileInfoByRelationId(idsArray[i]);
				for (FileInfo fileInfo : oldFileInfos) {
					fileService.deleteFileFromServer(fileInfo);
				}
			}
		}
		return response;
	}

	@Override
	public Response updateResponseExtendByIds(ResourceExtend resourceExtend) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("entity", resourceExtend);
		param.put("ids", Arrays.asList(resourceExtend.getResourceId().split(",")));
		return this.resourceBizDao.updateResourceExtendByIds(param)>0?Response.successInstance():Response.successInstance();
	}

	@Override
	public int getCount(Map<String, Object> paramMap) {
		return resourceBizDao.getCount(paramMap);
	}

	@Override
	public List<Resources> listRankResource() {
		String key = PropertiesLoader.get("redis.app.key")+":weekRank_resource_downloadNum";
		Calendar c= Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int week = c.get(Calendar.WEEK_OF_YEAR);
		String thisWeekKey = key+"_"+year+week;
		if (redisTemplate.hasKey(thisWeekKey)) {
			ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
			Set<TypedTuple<String>> set = zSetOperations.reverseRangeByScoreWithScores(thisWeekKey, 0, Double.MAX_VALUE, 0 ,5);
			List<String> ids = Lists.newArrayList();
			Map<String, Integer> scoreMap = Maps.newHashMap();
			for (TypedTuple<String> typedTuple : set) {
				ids.add(typedTuple.getValue());
				scoreMap.put(typedTuple.getValue(), (BigDecimal.valueOf(typedTuple.getScore())).intValue());
			}
			Map<String, Object> param = Maps.newHashMap();
			param.put("ids", ids);
			List<Resources> resources = resourceBizDao.select(param, null);
			for (Resources r : resources) {
				r.getResourceRelations().get(0).setDownloadNum(scoreMap.get(r.getId()));
			}
			Collections.sort(resources, new Comparator<Resources>() {
				@Override
				public int compare(Resources o1, Resources o2) {
					return o2.getResourceRelations().get(0).getDownloadNum() - o1.getResourceRelations().get(0).getDownloadNum();
				}
			});
			return resources;
		}else{
			redisTemplate.delete(key+"*");
			Map<String, Object> param = Maps.newHashMap();
			param.put("stateNotEquils", ResourceState.NOPASS);
			PageBounds pageBounds = new PageBounds(5);
			pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
			List<Resources> resources = resourceBizDao.select(param, pageBounds);
			for (Resources r : resources) {
				ZSetOperations<String, String> zSetOperations = redisTemplate.opsForZSet();
				zSetOperations.incrementScore(thisWeekKey, r.getId(), 0);
			}
			return listRankResource();
		}
	}

}
