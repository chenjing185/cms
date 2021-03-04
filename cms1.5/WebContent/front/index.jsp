<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>Jumbotron Template for Bootstrap</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css"
	rel="stylesheet">


<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/front/jumbotron.css"
	rel="stylesheet">

</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">CMS首页</a>
			</div>
			<c:choose>
 				<c:when test="${sessionScope.frontUser==null }">
				 <div id="navbar" class="navbar-collapse collapse">
					<form class="navbar-form navbar-right"
						action="${pageContext.request.contextPath}/UserController?op=frontLogin"
						method="post">
						<div class="form-group">
							<input type="text" placeholder="用户名" class="form-control"
								name="uname">
						</div>
						<div class="form-group">
							<input type="password" placeholder="密码" class="form-control"
								name="upwd">
						</div>
						<button type="submit" class="btn btn-success">登录</button>
						<button class="btn btn-success"><a href="${pageContext.request.contextPath}/register.jsp" style="text-decoration:none;color:white">注册</a></button>
					</form>
				</div>
			 </c:when>
			 <c:otherwise>
			    <ul class="nav navbar-nav navbar-right">
					<li><a href="#" style="color:red;">${sessionScope.frontUser.userName }</a></li>
					<li><a href="#">个人中心</a></li>
					<li><a href="${pageContext.request.contextPath}/UserController?op=frontExit">退出</a></li>
				</ul>
			 </c:otherwise>
			</c:choose>
			<!--/.navbar-collapse -->
		</div>
	</nav>

	<!-- Main jumbotron for a primary marketing message or call to action -->
	<div class="jumbotron">
		<div class="container">
			<h1>Hello, world!</h1>
			<p>This is a template for a simple marketing or informational
				website. It includes a large callout called a jumbotron and three
				supporting pieces of content. Use it as a starting point to create
				something more unique.</p>
			<p>
				<a class="btn btn-primary btn-lg" href="#" role="button">Learn
					more &raquo;</a>
			</p>
		</div>
	</div>
	<c:if test="${requestScope.topList == null  }">
		<c:redirect url="/ArticleController?op=frontQuery"></c:redirect>
	</c:if>
	<div class="container">
		<!-- Example row of columns -->
		<div class="row">
			<c:if test="${requestScope.topList != null  }">
				<c:forEach items="${requestScope.topList}" var="article">
					<div class="col-md-4">
						<h2>${article.articleTitle }</h2>
						<p style="width:300px;white-space: nowrap;text-overflow: ellipsis;overflow:hidden;">${article.articleContent }</p>
						<p>
							<a class="btn btn-default" 
							href="${pageContext.request.contextPath}/ArticleController?op=forntQueryById&articleId=${article.articleId}" 
							role="button">查看详情&raquo;</a>
						</p>

					</div>
				</c:forEach>
			</c:if>
		</div>

		<hr>

		<footer>
			<p>&copy; 2016 Company, Inc.</p>
		</footer>
	</div>

</body>
</html>
