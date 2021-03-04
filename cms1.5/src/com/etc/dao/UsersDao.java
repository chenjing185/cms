package com.etc.dao;

import java.util.List;

import com.etc.entity.Users;

public interface UsersDao {
	//查询所有用户
	List<Users> queryUsers();
	//增加用户
	boolean insertUser(Users user);
	//根据用户名和密码查询用户信息
	Users queryUserByOp(String userName,String userPwd);
	/**
	 * 根据用户名查询用户
	 */
	Users queryUserByName(String userName);
	
	


}
