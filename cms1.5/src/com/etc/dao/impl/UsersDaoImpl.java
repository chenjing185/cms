package com.etc.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.CachedRowSet;

import com.etc.dao.UsersDao;
import com.etc.entity.Users;
import com.etc.util.DButil;

public class UsersDaoImpl implements UsersDao {

	@Override
	public List<Users> queryUsers() {
		Users user =null;
		List<Users> list=new ArrayList<Users>();
		CachedRowSet crs = DButil.execQuery("select * from t_user");
		try {
			while(crs.next()) {
				int userId = crs.getInt(1);
				String userName = crs.getString(2);
				String userPwd = crs.getString(3);
				int userState = crs.getInt(4);
				int userLevel = crs.getInt(5);
				user=new Users(userId, userName, userPwd, userState, userLevel);
				list.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean insertUser(Users user) {
		return DButil.execUpdate("insert into t_user values(null,?,?,?,?)", user.getUserName(),user.getUserPwd(),user.getUserState(),user.getUserLevel());
	}

	@Override
	public Users queryUserByOp(String userName, String userPwd) {
		Users user =null;
		CachedRowSet crs = DButil.execQuery("select * from t_user where admin_name=? and admin_pwd=?",userName,userPwd);
		try {
			while(crs.next()) {
				int userId = crs.getInt(1);
				String userName2 = crs.getString(2);
				String userPwd2 = crs.getString(3);
				int userState = crs.getInt(4);
				int userLevel = crs.getInt(5);
				user=new Users(userId, userName2, userPwd2, userState, userLevel);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public Users queryUserByName(String userName) {
		CachedRowSet crs = DButil.execQuery("select * from t_user where admin_name=?", userName);
		Users user =null;
		try {
			while(crs.next()) {
				int userId = crs.getInt(1);
				String userName2 = crs.getString(2);
				String userPwd2 = crs.getString(3);
				int userState = crs.getInt(4);
				int userLevel = crs.getInt(5);
				user=new Users(userId, userName2, userPwd2, userState, userLevel);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

}
