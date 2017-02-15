package com.haoyu.utils;

public class StringUtils{
	
	public static String split(String input,String splitStr,int resultIndex){
		if (org.apache.commons.lang3.StringUtils.isNotEmpty(input)) {
			return input.split(splitStr)[resultIndex];
		}
		return null;
	}
	
}
