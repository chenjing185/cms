package com.etc.service.impl;

import java.util.List;

import com.etc.dao.UsersDao;
import com.etc.dao.impl.UsersDaoImpl;
import com.etc.entity.Users;
import com.etc.service.UserService;

public class UserServiceImpl implements UserService {
	UsersDao dao=new UsersDaoImpl();

	@Override
	public List<Users> getUsers() {
		// TODO Auto-generated method stub
		return dao.queryUsers();
	}

	@Override
	public boolean addUser(Users user) {
		// TODO Auto-generated method stub
		return dao.insertUser(user);
	}

	@Override
	public Users login(String userName, String userPwd) {
		// TODO Auto-generated method stub
		return dao.queryUserByOp(userName, userPwd);
	}

	@Override
	public boolean getUserByName(String userName) {
		Users user = dao.queryUserByName(userName);
		if (user==null) {
			return true;
		} else {
			return false;
		}
	}
	

	

}
