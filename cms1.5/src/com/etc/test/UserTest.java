package com.etc.test;

import java.util.List;

import org.junit.Test;

import com.etc.entity.Users;
import com.etc.service.impl.UserServiceImpl;

public class UserTest {
	UserServiceImpl service=new UserServiceImpl();
	
	@Test
	public void test1() {
		List<Users> list = service.getUsers();
		for (Users users : list) {
			System.out.println(users);
		}
	}
	
	@Test
	public void test2() {
		boolean f = service.addUser(new Users(0,"康康","123",1,1));
		System.out.println(f);
	}
	
	@Test
	public void test3() {
		Users user = service.login("康康2", "123");
		System.out.println(user);
	}

}
