package com.haoyu.workshop.entity;

import java.io.Serializable;

import com.haoyu.tip.workshop.entity.Workshop;

public class WorkshopResult implements Serializable{
	
	private static final long serialVersionUID = -1545757007835345119L;

	private Workshop workshop;
	
	private int completeNum;
	
	public Workshop getWorkshop() {
		return workshop;
	}

	public void setWorkshop(Workshop workshop) {
		this.workshop = workshop;
	}

	public int getCompleteNum() {
		return completeNum;
	}

	public void setCompleteNum(int completeNum) {
		this.completeNum = completeNum;
	}

}
