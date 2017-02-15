/**
 * 
 */
package com.haoyi.ipanther.common.dict.utils;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyi.ipanther.common.dict.dao.DictEntryDao;
import com.haoyi.ipanther.common.dict.vo.DictEntry;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.utils.PropertiesLoader;

/**
 * @author shisibo
 *
 */
@Component
public class DictionaryUtils{
	
	@Resource  
	private DictEntryDao dictEntryDao;
	@Resource  
	private RedisTemplate redisTemplate;
	@Resource
	private PropertiesLoader propertiesLoader;
	
	private static String appName;
	
	private static DictionaryUtils dictionaryUtils;  
	  
	@PostConstruct  
	public void init() {  
		dictionaryUtils = this;  
		dictionaryUtils.dictEntryDao = this.dictEntryDao;  
		dictionaryUtils.redisTemplate = this.redisTemplate;  
		appName = propertiesLoader.getProperty("redis.app.key");
	}  
	
	public static void init(String dictTypeCode){
		dictionaryUtils.redisTemplate.setValueSerializer(dictionaryUtils.redisTemplate.getDefaultSerializer());
		ValueOperations<String, List<DictEntry>> valueOper = dictionaryUtils.redisTemplate.opsForValue();
		String key = appName+":dict:"+dictTypeCode;
		dictionaryUtils.redisTemplate.delete(key);
	}
	
	public static void init(String[] dictTypeCodes){
		dictionaryUtils.redisTemplate.setValueSerializer(dictionaryUtils.redisTemplate.getDefaultSerializer());
		ValueOperations<String, List<DictEntry>> valueOper = dictionaryUtils.redisTemplate.opsForValue();
		List<String> keys = Lists.newArrayList();
		for (String dictTypeCode : dictTypeCodes) {
			String key = appName+":dict:"+dictTypeCode;
			if (!keys.contains(key)) {
				keys.add(key);
			}
		}
		dictionaryUtils.redisTemplate.delete(keys);
	}
	
	public static void initAll(){
		Set<String> keys =  dictionaryUtils.redisTemplate.keys("*dictEntryMap_"+appName+"*");
		if(!keys.isEmpty()){
			dictionaryUtils.redisTemplate.delete(keys);
		}
	}
	
	public static Map<String, DictEntry> getEntryMap(String dictTypeCode) {
		Map<String, DictEntry> entryMap = Maps.newHashMap();
		dictionaryUtils.redisTemplate.setHashValueSerializer(new JacksonJsonRedisSerializer(DictEntry.class));
		HashOperations<String,String,DictEntry> hashOper = dictionaryUtils.redisTemplate.opsForHash();
		String key = appName+":dict:"+dictTypeCode;
		if(dictionaryUtils.redisTemplate.hasKey(key)){
			entryMap = hashOper.entries(key);
		}else {
			DictEntry dictEntry = new DictEntry();
			dictEntry.setDictTypeCode(dictTypeCode);
			entryMap = dictionaryUtils.dictEntryDao.selectByObjectForMap(dictEntry);
			if (entryMap != null && !entryMap.isEmpty()) {
				hashOper.putAll(key, entryMap);
			}
		}
		return entryMap;
	}
	
	public static Map<String, DictEntry> getEntryMap(String dictTypeCode, String parentValue) {
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		Map<String, DictEntry> resultMap = Maps.newHashMap();
		for (DictEntry dictEntry : entryMap.values()) {
			if (parentValue.equals(dictEntry.getParentValue())) {
				resultMap.put(dictEntry.getDictValue(), dictEntry);
			}
		}
		return resultMap;
	}
	
	public static Map<String, DictEntry> getEntryMapNotParent(String dictTypeCode) {
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		Map<String, DictEntry> resultMap = Maps.newHashMap();
		for (DictEntry dictEntry : entryMap.values()) {
			if (StringUtils.isEmpty(dictEntry.getParentValue())) {
				resultMap.put(dictEntry.getDictValue(), dictEntry);
			}
		}
		return resultMap;
	}
	
	public static List<DictEntry> getEntryList(String dictTypeCode) {
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		return getSortEntryList(entryMap);
	}
	
	public static List<DictEntry> getEntryListNotParent(String dictTypeCode) {
		Map<String, DictEntry> entryMap = getEntryMapNotParent(dictTypeCode);
		return getSortEntryList(entryMap);
	}
	
	public static List<DictEntry> getEntryList(String dictTypeCode, String parentValue) {
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode,parentValue);
		return getSortEntryList(entryMap);
	}

	private static List<DictEntry> getSortEntryList(Map<String, DictEntry> entryMap) {
		List<DictEntry> entryList = Lists.newArrayList();
		for (DictEntry dictEntry : entryMap.values()) {
			entryList.add(dictEntry);
		}
		Collections.sort(entryList, new Comparator<DictEntry>(){
			public int compare(DictEntry o1, DictEntry o2) {
				if (o1.getSortNo() != null && o2.getSortNo() != null) {
					int result = o1.getSortNo().compareTo(o2.getSortNo());
					if (result != 0) {
						return result;
					}
				}
				return o1.getDictValue().compareTo(o2.getDictValue());
			}
		});
		return entryList;
	}
	
	public static String getEntryOptions(String dictTypeCode){
		List<DictEntry> entryList = getEntryList(dictTypeCode);
		return getOptionsString(entryList);
	}
	
	public static String getEntryOptionsNotParent(String dictTypeCode){
		List<DictEntry> entryList = getEntryListNotParent(dictTypeCode);
		return getOptionsString(entryList);
	}
	
	public static String getEntryOptions(String dictTypeCode,String parentValue){
		List<DictEntry> entryList = getEntryList(dictTypeCode, parentValue);
		return getOptionsString(entryList);
	}

	private static String getOptionsString(List<DictEntry> entryList) {
		StringBuffer entryOptions = new StringBuffer();
		for(DictEntry entry: entryList){
			if(!ObjectUtils.toString(entry.getIsHidden()).equals("Y")){
				entryOptions.append("<option value='").append(entry.getDictValue()).append("'>");
				entryOptions.append(entry.getDictName()).append("</option>");
			}
		}
		return entryOptions.toString();
	}
	
	public static String getEntryOptionsSelected(String dictTypeCode,String defaultValue){
		List<DictEntry> entryList = getEntryList(dictTypeCode);
		return getOptionsSelectedString(defaultValue, entryList);
	}
	
	/**
	 * 截取 getEntryOptionsSelected
	 * 
	 * @param dictTypeCode
	 * @param defaultValue
	 * @param toIndex
	 * @return
	 */
	public static String getEntryOptionsSelected(String dictTypeCode,String defaultValue,int toIndex){
		List<DictEntry> entryList = getEntryList(dictTypeCode);
		entryList=entryList.subList(0, toIndex);
		return getOptionsSelectedString(defaultValue, entryList);
	}
	
	public static String getEntryOptionsSelectedNotParent(String dictTypeCode,String defaultValue){
		List<DictEntry> entryList = getEntryListNotParent(dictTypeCode);
		return getOptionsSelectedString(defaultValue, entryList);
	}
	
	public static String getEntryOptionsSelected(String dictTypeCode,String parentValue,String defaultValue){
		List<DictEntry> entryList = getEntryList(dictTypeCode, parentValue);
		return getOptionsSelectedString(defaultValue, entryList);
	}

	private static String getOptionsSelectedString(String defaultValue, List<DictEntry> entryList) {
		StringBuffer entryOptions = new StringBuffer();
		for(DictEntry entry: entryList){
			if(!ObjectUtils.toString(entry.getIsHidden()).equals("Y")){
				entryOptions.append("<option value='").append(entry.getDictValue()).append("'");
				if (StringUtils.isNotEmpty(defaultValue) && defaultValue.equals(entry.getDictValue())) {
					entryOptions.append(" selected ");
				}
				entryOptions.append(">").append(entry.getDictName()).append("</option>");
			}
		}
		return entryOptions.toString();
	}
	
	public static String getEntryName(String dictTypeCode,String dictValue){
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		if (entryMap != null && entryMap.containsKey(dictValue)) {
			return entryMap.get(dictValue).getDictName();
		}
		return "";
	}
	
	public static String getEntryValue(String dictTypeCode,String dictEntryName){
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		if (entryMap != null) {
			for (DictEntry dictEntry : entryMap.values()) {
				if (dictEntry.getDictName().equals(dictEntryName)) {
					return dictEntry.getDictValue();
				}
			}
		}
		return "";
	}

	public static DictEntry getEntry(String dictTypeCode, String dictValue){
		Map<String, DictEntry> entryMap = getEntryMap(dictTypeCode);
		if (entryMap != null && entryMap.containsKey(dictValue)) {
			return entryMap.get(dictValue);
		}
		return null;
	}
	
	public static String getAllParentName(String dictTypeCode, String dictValue){
		DictEntry dictEntry = getEntry(dictTypeCode,dictValue);
		StringBuilder parentNameSum = new StringBuilder();
		while(dictEntry != null && StringUtils.isNotEmpty(dictEntry.getParentValue())){
			dictEntry = DictionaryUtils.getEntry(dictEntry.getDictTypeCode(), dictEntry.getParentValue());
			parentNameSum.append(dictEntry.getDictName()+",");
		}
		return StringUtils.removeEnd(parentNameSum.toString(),",");
	}
	
	public static String getAllParentValue(String dictTypeCode, String dictValue){
		DictEntry dictEntry = getEntry(dictTypeCode,dictValue);
		List<String> dictValues = Lists.newArrayList();
		while(dictEntry != null && StringUtils.isNotEmpty(dictEntry.getParentValue())){
			dictEntry = DictionaryUtils.getEntry(dictEntry.getDictTypeCode(), dictEntry.getParentValue());
			dictValues.add(dictEntry.getDictValue());
		}
		
		if (!dictValues.isEmpty()) {
			Collections.reverse(dictValues);
			return new JsonMapper().toJson(dictValues);
		}
		return "{}";
	}
	
}
