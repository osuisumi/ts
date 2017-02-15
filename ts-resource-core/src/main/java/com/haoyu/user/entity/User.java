package com.haoyu.user.entity;

import java.util.Date;

import com.haoyu.dept.entity.Department;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.entity.BaseEntity;

public class User extends BaseEntity{
	
	private static final long serialVersionUID = 5816396046167136862L;

	private String id;
	
	private String realName;
	
	private String paperworkNo;
	
	private Date bornDate;
	
	private String avatar;
	
	private String summary;
	
	private String sex;
	
	private String post;
	
	private String phone;
	
	private String email;
	
	private Department department;
	
	private Account account;
	
	private UserDept userDept;
	
	private AuthRole authRole;
	
	private String stage;
	
	private String subject;
	
	public AuthRole getAuthRole() {
		return authRole;
	}

	public void setAuthRole(AuthRole authRole) {
		this.authRole = authRole;
	}

	public UserDept getUserDept() {
		return userDept;
	}

	public void setUserDept(UserDept userDept) {
		this.userDept = userDept;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPaperworkNo() {
		return paperworkNo;
	}

	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}

	public Date getBornDate() {
		return bornDate;
	}

	public void setBornDate(Date bornDate) {
		this.bornDate = bornDate;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
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

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	
}
