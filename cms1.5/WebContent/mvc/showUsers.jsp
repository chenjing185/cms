<%@page import="com.etc.entity.Users"%>
<%@page import="com.etc.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.etc.service.impl.ArticleServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String contextPath=request.getContextPath();// /cms1.1
	//System.out.print(contextPath);	
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Dashboard Template for Bootstrap</title>

    <!-- ../返回上一级 -->
    <link href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/dist/css/dashboard.css" rel="stylesheet">

  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">CMS文章管理系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">登录</a></li>
            <li><a href="#">设置</a></li>
            <li><a href="#">个人信息</a></li>
            <li><a href="#">帮助</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="${pageContext.request.contextPath}/mvc/showArticles_ajax.jsp">文章列表 <span class="sr-only">(current)</span></a></li>
            <li><a href="${pageContext.request.contextPath}/mvc/addArticle.jsp">增加文章</a></li>
            <li><a href="#">Analytics</a></li>
            <li><a href="#">Export</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li  class="active"><a href="${pageContext.request.contextPath}/UserController?op=query">用户列表</a></li>
            <li><a href="${pageContext.request.contextPath}/mvc/addUser.jsp">增加用户</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">用户列表</h1>

          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>编号</th>
                  <th>姓名</th>
                  <th>密码</th>
                  <th>状态</th>
                  <th>等级</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
		 <%
		       		//java代码 从servlet中获取传递过来的结果
				    List<Users> list=( List<Users>)request.getAttribute("users");
					for (Users user : list) {
		 %>
				<tr>
                  <td><%=user.getUserId() %></td>
                  <td><%=user.getUserName()%></td>
                  <td><%=user.getUserPwd()%></td>
                  <td><%=user.getUserState()==1?"正常":"禁用" %></td>
                  <td><%=user.getUserLevel()==1?"普通用户":"管理员" %></td>
                  <td><button type="button" class="btn btn-warning">修改</button> <button type="button" class="btn btn-danger">删除</button></td>
                </tr>
               
		 <%
					}
		  %>
               
                
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
