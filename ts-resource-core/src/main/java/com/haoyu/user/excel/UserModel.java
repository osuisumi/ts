package com.haoyu.user.excel;

import com.haoyu.ipanther.common.excel.DataType;
import com.haoyu.ipanther.common.excel.annotations.ExcelEntity;
import com.haoyu.ipanther.common.excel.annotations.ImportField;
import com.haoyu.ipanther.common.excel.model.ImportModel;

@ExcelEntity
public class UserModel extends ImportModel {
	@ImportField(colName = "用户名", validate = { DataType.REQURIED })
	private String userName;
	@ImportField(colName = "密码", validate = { DataType.REQURIED })
	private String password;
	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号", validate = { DataType.REQURIED })
	private String paperworkNo;
	@ImportField(colName = "所在单位", validate = { DataType.REQURIED })
	private String deptName;
	@ImportField(colName = "性别", validate = {  })
	private String sex;
	@ImportField(colName = "岗位", validate = {  })
	private String post;
	@ImportField(colName = "联系电话", validate = {  })
	private String phone;
	@ImportField(colName = "电子邮箱", validate = {  })
	private String email;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
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

	public String getPaperworkNo() {
		return paperworkNo;
	}

	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}
}