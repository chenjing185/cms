<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 加入访问控制,只有登录才能看详情 -->
<c:if test="${sessionScope.frontUser==null }">
  <script>
     alert("请登录");
     location.href="front/index.jsp";
  </script>
</c:if>
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

    <title>Blog Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/front/blog.css" rel="stylesheet">

    
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
    <div class="blog-masthead">
      <div class="container">
        <nav class="blog-nav">
          <a class="blog-nav-item active" href="#">Home</a>
          <a class="blog-nav-item" href="#">New features</a>
          <a class="blog-nav-item" href="#">Press</a>
          <a class="blog-nav-item" href="#">New hires</a>
          <a class="blog-nav-item" href="#">About</a>
        </nav>
      </div>
    </div>

    <div class="container">

      <div class="blog-header">
        <h1 class="blog-title">文章内容详情页</h1>
      </div>
       <hr/>
      <div class="row">

        <div class="col-sm-8 blog-main">
        <c:if test="${requestScope.article!=null }">
          <div class="blog-post">
            <h2 class="blog-post-title">${requestScope.article.articleTitle }</h2>
            <p class="blog-post-meta">${requestScope.article.articleDate } by <a href="#">${requestScope.article.articleAuthor }</a></p>

            <p>${requestScope.article.articleContent }</p>
          </div><!-- /.blog-post -->
		</c:if>

          <nav>
            <ul class="pager">
              <li><a href="#">上一篇</a></li>
              <li><a href="#">下一篇</a></li>
            </ul>
          </nav>

        </div><!-- /.blog-main -->

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
          <div class="sidebar-module sidebar-module-inset">
            <h4>About</h4>
            <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
          </div>
          <div class="sidebar-module">
            <h4>Archives</h4>
            <ol class="list-unstyled">
              <li><a href="#">March 2014</a></li>
              <li><a href="#">February 2014</a></li>
              <li><a href="#">January 2014</a></li>
              <li><a href="#">December 2013</a></li>
              <li><a href="#">November 2013</a></li>
              <li><a href="#">October 2013</a></li>
              <li><a href="#">September 2013</a></li>
              <li><a href="#">August 2013</a></li>
              <li><a href="#">July 2013</a></li>
              <li><a href="#">June 2013</a></li>
              <li><a href="#">May 2013</a></li>
              <li><a href="#">April 2013</a></li>
            </ol>
          </div>
          <div class="sidebar-module">
            <h4>Elsewhere</h4>
            <ol class="list-unstyled">
              <li><a href="#">GitHub</a></li>
              <li><a href="#">Twitter</a></li>
              <li><a href="#">Facebook</a></li>
            </ol>
          </div>
        </div><!-- /.blog-sidebar -->

      </div><!-- /.row -->

    </div><!-- /.container -->

    <footer class="blog-footer">
      <p>Blog template built for <a href="http://getbootstrap.com">Bootstrap</a> by <a href="https://twitter.com/mdo">@mdo</a>.</p>
      <p>
        <a href="#">Back to top</a>
      </p>
    </footer>


  
  </body>
</html>
