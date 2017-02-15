package com.haoyu.menu.util;

import java.util.ArrayList;
import java.util.List;

public class DataGrid {

	/** 总记录数 */
	private int total;

	/** 每行记录 */
	private List<?> rows;


	public List<?> data;

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}


	public List<?> getRows() {
		if (rows == null) {
			rows = new ArrayList<>();
		}
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}


	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}

}
