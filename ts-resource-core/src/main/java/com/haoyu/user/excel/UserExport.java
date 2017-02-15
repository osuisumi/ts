package com.haoyu.user.excel;

import java.io.Serializable;

import com.haoyu.ipanther.common.excel.annotations.ExcelEntity;
import com.haoyu.ipanther.common.excel.annotations.ExportField;

@ExcelEntity(sortHead=true,sheetName="用户信息",wrapText=true)
public class UserExport implements Serializable{
	
	private static final long serialVersionUID = 8451679649078502528L;

	@ExportField(colName="用户名",colWidth=6000,index=0)
	private String userName;
	@ExportField(colName="姓名",colWidth=3000,index=1)
	private String realName;
	@ExportField(colName="身份证号",colWidth=6000,index=2)
	private String paperworkNo;
	@ExportField(colName="所在单位",colWidth=9000,index=3)
	private String deptName;
	@ExportField(colName="联系电话",colWidth=6000,index=4)
	private String phone;
	@ExportField(colName="电子邮箱",colWidth=9000,index=5)
	private String email;
	@ExportField(colName="角色",colWidth=9000,index=6)
	private String roleName;
	@ExportField(colName="结果",colWidth=12000,index=7)
	private String msg;
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPaperworkNo() {
		return paperworkNo;
	}

	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

}
