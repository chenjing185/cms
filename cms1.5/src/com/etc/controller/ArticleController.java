package com.etc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.etc.entity.Article;
import com.etc.service.impl.ArticleServiceImpl;
import com.etc.util.PageData;
import com.google.gson.Gson;

/**
 * Servlet implementation class ArticleController
 */
@WebServlet("/ArticleController")
public class ArticleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//创建service对象
	ArticleServiceImpl service = new ArticleServiceImpl();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleController() {
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
		
		}else if("frontQuery".equals(op)) {
			//普通用户-首页操作
			frontQuery(op,request,response);
			
		}else if("forntQueryById".equals(op)) {
			//普通用户-首页点击详情页操作
			forntQueryById(op,request,response);
			
		}else {
			//访问的时候发现没有登录,就跳转到登录页面去
			response.sendRedirect("mvc/login.jsp");
		}
		
		
		
		
		
	}

	private void forntQueryById(String op, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//根据id调用业务层
		
		//1.获取前端传递过来的id
		int articleId=Integer.parseInt(request.getParameter("articleId")) ;
		Article article=service.getArticleId(articleId);
		request.setAttribute("article", article);
		//转发到详情页
		request.getRequestDispatcher("front/detail.jsp").forward(request, response);

		
	}

	private void frontQuery(String op, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//查询前3条 调用业务层
		List<Article> topList = service.getTopArticle();
		//存到数据到request作用域,在下一个页面获取
		request.setAttribute("topList", topList);
		request.getRequestDispatcher("front/index.jsp").forward(request, response);
		
	}

	private void adminOp(String op, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if ("query".equals(op)) {
			query(request,response);
			
		}else if("add".equals(op)) {
			add(request,response);
			
		}else if("del".equals(op)) {
			del(request,response);
			
		}else if("queryLike".equals(op)) {
			queryLike(request,response);
			
		}else if("update".equals(op)) {
			update(request,response);
			
		}else if("articlePage_ajax".equals(op)) {
			//分页模糊查询
			articlePage_ajax(request,response);
		}else if("update_ajax".equals(op)) {
			//修改
			update_ajax(request,response);
		}
		else if("del_ajax".equals(op)) {
			//删除
			del_ajax(request,response);
		}
		
	}

	private void del_ajax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json;charset=utf-8");
		//接收参数
		int articleId =Integer.parseInt(request.getParameter("articleId"));
		//调用业务层
		boolean flag = service.deleteArticle(articleId);
		//通过ajax返回json数据
		Gson gson = new Gson();
		String json = gson.toJson(flag);
		response.getWriter().print(json);
		
	}

	private void update_ajax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json;charset=utf-8");
		//接收参数
		String string = request.getParameter("article");
		Gson gson = new Gson();
		Article article=gson.fromJson(string, Article.class);
		//调用业务层
		boolean flag = service.updateArticle(article);
		//通过ajax返回json数据
		String json = gson.toJson(flag);
		response.getWriter().print(json);
	}

	private void articlePage_ajax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json;charset=utf-8");
		//1.默认页码和显示条数
		int pageNo=1;//默认值
		int pageSize=3;//默认值
		String key="";//如果没有传递,默认查所有
		
		//2.如果前台有指定值就使用前台传递的值,否则按默认显示
		if(request.getParameter("pageNo")!=null) {
			pageNo=Integer.parseInt(request.getParameter("pageNo")) ;
		}
		if(request.getParameter("pageSize")!=null) {
			pageSize=Integer.parseInt(request.getParameter("pageSize")) ;
		}
		if(request.getParameter("key")!=null) {
			key=request.getParameter("key") ;
		}
		//3.调用业务层
		PageData pageData = service.getArticle2(pageNo, pageSize, key);
		//4.通过ajax返回json数据
		Gson gson = new Gson();
		String json = gson.toJson(pageData);
		response.getWriter().print(json);
		
	}

	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取模态框的所有数据
		int articleId=Integer.parseInt(request.getParameter("articleId")) ;
		String articleTitle = request.getParameter("articleTitle");
		String articleContent = request.getParameter("articleContent");
		String articleAuthor = request.getParameter("articleAuthor");
		
		Article article = new Article(articleId, articleTitle, articleContent, articleAuthor, null);
		//调用业务层
		boolean flag = service.updateArticle(article);
		//显示最新数据
		request.getRequestDispatcher("ArticleController?op=query").forward(request, response);
		
	}

	private void queryLike(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.获取模糊查询关键字
		String articleLike = request.getParameter("articleLike");
		//调用业务层方法
		List<Article> list = service.getArticlesLike(articleLike);
		//3.将list传递给jsp页面,存储到request的作用域中
		request.setAttribute("articles", list);
		//需要将模糊查询的关键字再传递回来jsp显示
		request.setAttribute("articleLike", articleLike);
		//4.进行页面的跳转
		request.getRequestDispatcher("mvc/showArticles.jsp").forward(request, response);
		
	}

	private void del(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 //获取用户传递过来的id的参数
		 int articleId =Integer.parseInt(request.getParameter("articleId")) ;
		 //调用业务层
		 boolean flag = service.deleteArticle(articleId);
		//显示最新的结果
		 request.getRequestDispatcher("ArticleController?op=query").forward(request, response);
		
	}

	private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取值:文章标题->通过name得到其value,因为表单提交name=value
		  String articleTitle=request.getParameter("articleTitle");
		  //文章内容
		  String articleContent=request.getParameter("articleContent");
		  //文章作者
		  String articleAuthor=request.getParameter("articleAuthor");
		  Article article= new Article(articleTitle,articleContent,articleAuthor);
		  
		  //调用业务层
		  boolean flag=service.addArticle(article);
		  //转发到servlet而不是jsp
		  request.getRequestDispatcher("ArticleController?op=query").forward(request, response);
		
	}

	private void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//调用查询所有文章的方法
		List<Article> list = service.getArticles();
		//这里的list应该渲染给jsp页面
		//1.传递数据给jsp页面做显示
		request.setAttribute("articles", list);//将list对象存放在request的作用域中,在下一个页面就可以通name(过articles)获取list
		//2.进行页面的跳转
		request.getRequestDispatcher("mvc/showArticles.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 因为你不确定用户的入口
		doGet(request, response);
	}

}
