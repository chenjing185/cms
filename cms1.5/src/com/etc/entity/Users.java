package com.etc.entity;

public class Users {
	private int userId;
	private String userName;
	private String userPwd;
	private int userState;//用户状态  0禁用 1启动
	private int userLevel; //用户等级 1 普通用户 2管理员
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
	public Users(int userId, String userName, String userPwd, int userState, int userLevel) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPwd = userPwd;
		this.userState = userState;
		this.userLevel = userLevel;
	}
	
	public Users() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Users [userId=" + userId + ", userName=" + userName + ", userPwd=" + userPwd + ", userState="
				+ userState + ", userLevel=" + userLevel + "]";
	}
	

}
