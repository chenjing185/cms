<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String contextPath=request.getContextPath();// /cms1.1
	//System.out.print(contextPath);	
%>
<!--  访问控制,判断session中是否有值,如果没有,则跳转到登录页面 -->
<%-- <c:if test="${sessionScope.user ==null }">
   <script>
      alert("请登录");
      location.href="login.jsp";
   </script>
</c:if> --%>
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

<title>CMS后台管理</title>

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/dist/css/bootstrap.css" rel="stylesheet">



<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/dist/css/dashboard.css" rel="stylesheet">


</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">CMS系统后台管理</a>
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
					<li><a href="${pageContext.request.contextPath}/mvc/showArticles_ajax.jsp">文章管理 <span class="sr-only">(current)</span></a>
					</li>
					<li class="active"><a href="${pageContext.request.contextPath}/mvc/addArticle.jsp">增加文章</a></li>
					<li><a href="#">Analytics</a></li>
					<li><a href="#">Export</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="${pageContext.request.contextPath}/UserController?op=query">用户管理</a></li>
					<li><a href="${pageContext.request.contextPath}/mvc/addUser.jsp">增加用户</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
					<li><a href="">More navigation</a></li>
				</ul>
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<h2 class="sub-header">增加文章</h2>


				<form class="form-horizontal" role="form" action="<%=contextPath %>/ArticleController?op=add" method="post">
					<div class="form-group">
						<label for="articleTitle" class="col-sm-2 control-label">文章标题</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="articleTitle"   name="articleTitle"/>
						</div>
					</div>
					<div class="form-group">
						<label for="articleContent" class="col-sm-2 control-label">文章内容</label>
						<div class="col-sm-8">
							<textarea rows="5" class="form-control" id="articleContent" name="articleContent"></textarea>
						</div>
					</div>

					<div class="form-group">
						<label for="inputPassword3" class="col-sm-2 control-label">文章类型</label>
						<div class="col-sm-2">
							<select class="form-control">
								<option>娱乐</option>
								<option>体育</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="articleAuthor" class="col-sm-2 control-label">文章作者</label>
						<div class="col-sm-2">
							<select class="form-control" name="articleAuthor"  id="articleAuthor">
								<option value="小白">小白</option>
								<option value="小红">小红</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-danger">提交</button>
							<button type="button" class="btn btn-success">预览</button>
						</div>
					</div>
				</form>



			</div>
		</div>
	</div>

	

</body>

</html>