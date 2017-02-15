package com.haoyu.board.entity;


import org.apache.commons.codec.digest.DigestUtils;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.User;
/**
 * 版块授权 
 * 例如：版块与版主
 */
public class BoardAuthorize extends BaseEntity{
	private static final long serialVersionUID = 344328827137251443L;

	/** id */
	private String id;
	
	/** 板块id*/
	private String boardId;
	/** 用户 */
	private User user;
	/** 用户在此板块充当的角色 */
	private String role; //master
	/** 状态 */
	private String state;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	public static String getId(String boardId, String userId){
		return DigestUtils.md5Hex(boardId+userId);
	}
	
}
