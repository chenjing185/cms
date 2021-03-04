package com.etc.service;

import java.util.List;

import com.etc.entity.Users;

public interface UserService {
	//得到所有用户
	List<Users> getUsers();
	/**
	 * 增加用户
	 * @param article 新增的用户信息
	 * @return true:增加成功 false:增加失败
	 */
	boolean addUser(Users user);
	//用户登录
	Users login(String userName,String userPwd);
	
	/**
	 * 根据用户名判断用户是否存在
	 */
	boolean getUserByName(String userName);
}
