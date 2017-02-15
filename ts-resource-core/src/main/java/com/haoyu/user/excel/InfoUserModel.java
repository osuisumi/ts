package com.haoyu.user.excel;

import com.haoyu.ipanther.common.excel.DataType;
import com.haoyu.ipanther.common.excel.annotations.ExcelEntity;
import com.haoyu.ipanther.common.excel.annotations.ImportField;
import com.haoyu.ipanther.common.excel.model.ImportModel;

@ExcelEntity
public class InfoUserModel extends ImportModel {
	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "用户名", validate = { DataType.REQURIED })
	private String userName;
	@ImportField(colName = "密码", validate = { DataType.REQURIED })
	private String password;
	@ImportField(colName = "单位", validate = {  })
	private String deptName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}
}