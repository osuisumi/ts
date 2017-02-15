package com.haoyu.board.entity;

import com.haoyu.sip.core.entity.User;

public class ActiveUser extends User {
	private static final long serialVersionUID = 8484008596261845503L;

	private int discussionCount;

	private int score;

	public int getDiscussionCount() {
		return discussionCount;
	}

	public void setDiscussionCount(int discussionCount) {
		this.discussionCount = discussionCount;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

}
