package com.haoyu.dept.modal;

import java.util.List;
import java.util.Map;

import com.google.common.collect.Lists;

public class DeptStatistic {

	private int resourceNum;
	
	private int newResourceNum;
	
	private int teacherNum;
	
	private int discoveryNum;
	
	private List<Map<String, Object>> departmentInfos = Lists.newArrayList();
	
	public int getResourceNum() {
		return resourceNum;
	}

	public void setResourceNum(int resourceNum) {
		this.resourceNum = resourceNum;
	}

	public int getNewResourceNum() {
		return newResourceNum;
	}

	public void setNewResourceNum(int newResourceNum) {
		this.newResourceNum = newResourceNum;
	}

	public int getTeacherNum() {
		return teacherNum;
	}

	public void setTeacherNum(int teacherNum) {
		this.teacherNum = teacherNum;
	}

	public int getDiscoveryNum() {
		return discoveryNum;
	}

	public void setDiscoveryNum(int discoveryNum) {
		this.discoveryNum = discoveryNum;
	}

	public List<Map<String, Object>> getDepartmentInfos() {
		return departmentInfos;
	}

	public void setDepartmentInfos(List<Map<String, Object>> departmentInfos) {
		this.departmentInfos = departmentInfos;
	}

//	public List<DepartmentInfo> getDepartmentInfos() {
//		return departmentInfos;
//	}
//
//	public void setDepartmentInfos(List<DepartmentInfo> departmentInfos) {
//		this.departmentInfos = departmentInfos;
//	}
	
}
