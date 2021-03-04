package com.etc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.etc.entity.Article;
import com.etc.entity.Users;
import com.etc.service.impl.ArticleServiceImpl;
import com.etc.service.impl.UserServiceImpl;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserServiceImpl service = new UserServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置请求的编码,位置在最前面
		//request.setCharacterEncoding("utf-8");
		String op=request.getParameter("op");
		//提升:访问控制->从session中获取用户信息,如果有,才能进行查询.添加...
		//获取session对象
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		if (obj!=null) {
			//管理员登录后的操作
			adminOp(op,request,response);
		}else if("login".equals(op)){
			//管理员登录
			login(request,response,session);

		}else if("frontLogin".equals(op)) {
			//普通用户登录
			frontLogin(request,response,session);

		}else if("frontExit".equals(op)) {
			//普通用户退出
			frontExit(request,response,session);
		}else if("register".equals(op)) {
			register(request,response);
		}else if("checkName".equals(op)) {
			checkName(request,response);
		}else {
			//管理员访问的时候发现没有登录,就跳转到登录页面去
			response.sendRedirect("mvc/login.jsp");
		}



	}

	private void checkName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//判断用户名是否存在
		String uname = request.getParameter("uname");
		//调用业务层
		boolean flag = service.getUserByName(uname);
		if (flag) {
			response.getWriter().print("可用");
		}else {
			response.getWriter().print("此用户名太受欢迎,请换一个!");
		}
		
	}

	private void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		//注册功能
		String userName = request.getParameter("logname");
		String userPwd = request.getParameter("logpass");
		//调用注册功能
		boolean flag = service.addUser(new Users(0, userName, userPwd, 1, 1));
		if (flag) {
			//注册成功跳往首页
			response.getWriter().print("<script>alert('注册成功!');location.href='front/index.jsp'</script>");
		}
	}

	private void frontExit(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {

		//普通用户退出,清除session中的信息
		request.getSession().removeAttribute("frontUser");
		//重定向 
		request.getRequestDispatcher("ArticleController?op=frontQuery").forward(request, response);


	}

	private void frontLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		//普通用户登录
		//1.获取用户名与密码
		String uname = request.getParameter("uname");
		String upwd = request.getParameter("upwd");
		//2.调用业务层
		Users user = service.login(uname, upwd);
		//3.判断用户是否存在
		if (user!=null) {
			//4.判断其状态与等级是普通用户
			if(user.getUserState()==1 && user.getUserLevel()==1) {
				//5.把用户信息存到session
				HttpSession session2 = request.getSession();
				session2.setAttribute("frontUser", user);
				//6.转发
				request.getRequestDispatcher("ArticleController?op=frontQuery").forward(request, response);
			}
		}else {
			//没有这个人,返回首页
			response.sendRedirect("front/index.jsp");
		}


	}

	private void login(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		//管理员登录
		//获取用户输入的用户名和密码
		String  userName= request.getParameter("userName");
		String  userPwd= request.getParameter("userPwd");
		//调用业务层的代码
		Users user = service.login(userName, userPwd);
		if(user!=null) {
			//用户名和密码正确
			//只有管理员登录才能访问后台的管理界面,需判断其状态==1和等级==2管理员
			if(user.getUserState()==1 && user.getUserLevel()==2) {
				 //判断用户是否记住密码
				String reme = request.getParameter("remember-me");
				if(reme!=null) {
					System.out.println("用户选择记住密码:"+reme);
					//存
					Cookie cookie1 = new Cookie("userName", userName);
					Cookie cookie2 = new Cookie("userPwd", userPwd);
					//选择状态
					Cookie cookie3 = new Cookie("checked", "checked");
					
					//设置cookie的过期时间
					cookie1.setMaxAge(240);//单位秒 4分钟
					cookie2.setMaxAge(240);//单位秒 4分钟
					cookie3.setMaxAge(240);//单位秒 4分钟
					
					//写到本地
					response.addCookie(cookie1);
					response.addCookie(cookie2);
					response.addCookie(cookie3);
				}
				//跳转到后台的管理界面
				//提升:加入访问控制->登录成功应该通过session存储用户的登录信息
				session = request.getSession();//获取session对象
				//使用session的setAttribute()将user存储
				session.setAttribute("user", user);
				//跳转到后台管理的首页
				request.getRequestDispatcher("mvc/showArticles_ajax.jsp").forward(request, response);
			}else {
				//转发  或重定向
				response.sendRedirect("mvc/login.jsp");
			}
		}else {
			//用户名和密码错误
			//1.转发  或重定向
			response.sendRedirect("mvc/login.jsp");
		}

	}

	private void adminOp(String op, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//不为空表示用户已经登录过了,就可以做下面的操作
		if ("query".equals(op)) {
			query(request,response);
		}else if("add".equals(op)) {
			add(request,response);
		}else if("login".equals(op)) {
		    HttpSession	session = request.getSession();//获取session对象
			login(request,response,session);
		}

	}

	private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取值:
		String userName=request.getParameter("userName");
		String userPwd=request.getParameter("userPwd");
		int userState=Integer.parseInt(request.getParameter("userState"))  ;
		int userLevel=Integer.parseInt(request.getParameter("userLevel"))  ;
		Users users=new Users(0, userName, userPwd, userState, userLevel);

		//调用业务层
		boolean flag=service.addUser(users);
		//转发到servlet而不是jsp
		request.getRequestDispatcher("UserController?op=query").forward(request, response);


	}

	private void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//调用查询所有用户的方法
		List<Users> list = service.getUsers();
		//这里的list应该渲染给jsp页面
		//1.传递数据给jsp页面做显示
		request.setAttribute("users", list);//将list对象存放在request的作用域中,在下一个页面就可以通name(过articles)获取list
		//2.进行页面的跳转
		request.getRequestDispatcher("mvc/showUsers.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
