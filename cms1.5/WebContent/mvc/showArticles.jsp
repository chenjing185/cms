<%@page import="com.etc.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.etc.service.impl.ArticleServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--  访问控制,判断session中是否有值,如果没有,则跳转到登录页面 -->
<%-- <c:if test="${sessionScope.user ==null }">
   <c:redirect url="login.jsp"></c:redirect>
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

<title>Dashboard Template for Bootstrap</title>

<!-- ../返回上一级 -->
<link href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css" rel="stylesheet">


<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/dist/css/dashboard.css" rel="stylesheet">
<!-- 检查:不要有重复的包 -->
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
				<a class="navbar-brand" href="#">CMS文章管理系统</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" style="color:red;">欢迎${sessionScope.user.userName }登录</a></li>
					<li><a href="#">Settings</a></li>
					<li><a href="#">Profile</a></li>
					<li><a href="#">Help</a></li>
				</ul>
				<form class="navbar-form navbar-right" method="post"
					action="${pageContext.request.contextPath}/ArticleController?op=queryLike">
					<input type="text" class="form-control" placeholder="搜索标题..."
						name="articleLike"
						value="${requestScope.articleLike==null?"":articleLike }" />
					<button type="submit" class="btn btn-default">搜索</button>
				</form>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="">文章列表 <span class="sr-only">(current)</span></a></li>
					<li><a href="mvc/addArticle.jsp">增加文章</a></li>
					<li><a href="#">Analytics</a></li>
					<li><a href="#">Export</a></li>
				</ul>
				<ul class="nav nav-sidebar">
				  <!--   pageContext.request=>pageContext.getRequest()
				         request.contextPath=>request.getContextPath() -->
					<li><a href="${pageContext.request.contextPath}/UserController?op=query">用户列表</a></li>
					<li><a href="${pageContext.request.contextPath}/mvc/addUser.jsp">增加用户</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
					<li><a href="">More navigation</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="">Nav item again</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">文章列表</h1>

				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>文章编号</th>
								<th>文章标题</th>
								<th>文章内容</th>
								<th>文章作者</th>
								<th>发布时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
	   
	                
	                	<c:if test="${sessionScope.user!=null }" > 
	                	  
	                	   <c:forEach items="${requestScope.articles }" var="article">
	                	      <tr>
								<td>${article.articleId }</td>
								<td>${article.articleTitle }</td>
								<td>${article.articleContent }</td>
								<td>${article.articleAuthor }</td>
								<td>${article.articleDate }</td>
								<td><button type="button" class="btn btn-warning"
										data-toggle="modal" data-target="#myModal" 
										data-articleid="${article.articleId }"
										data-articletitle="${article.articleTitle }"
										data-articlecontent="${article.articleContent }"
										data-articleauthor="${article.articleAuthor }"
										onclick="showUpdateData(this)">修改</button> <a
									href="javascript:delFun(${article.articleId })"><button
											type="button" class="btn btn-danger">删除</button></a></td>
							 </tr>
	                	   
	                	   </c:forEach>
	                	
	                	</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 放最后 -->
	<!-- 模态框Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form class="form-horizontal" role="form"
					action="${pageContext.request.contextPath}/ArticleController?op=update" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改文章内容</h4>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="articleId" class="col-sm-2 control-label">文章编号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="articleId" name="articleId" readonly="readonly"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="articleTitle" class="col-sm-2 control-label">文章标题</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="articleTitle" name="articleTitle" />
							</div>
						</div>
						<div class="form-group">
							<label for="articleContent" class="col-sm-2 control-label">文章内容</label>
							<div class="col-sm-8">
								<textarea rows="5" class="form-control" id="articleContent" name="articleContent"></textarea>
							</div>
						</div>

						<div class="form-group">
							<label for="articleAuthor" class="col-sm-2 control-label">文章作者</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="articleAuthor" name="articleAuthor" />
							</div>
							
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" class="btn btn-primary">保存修改</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
<script>
   function delFun(articleId){
	   var flag=confirm("是否确定删除文章编号为:"+articleId);
	   if(flag){
		   //跳转页面
		   location.href="ArticleController?op=del&articleId="+articleId;
	   }
   }
   
   function showUpdateData(obj){
	   //获取原来的数据
	   var articleId=$(obj).data("articleid");
	   /* console.log(articleId); */
	   var articleTitle=$(obj).data("articletitle");
	   var articleContent=$(obj).data("articlecontent");
	   var articleAuthor=$(obj).data("articleauthor");
	   //显示在模态框中指定的位置
	   $("#myModal #articleId").val(articleId);
	   $("#myModal #articleTitle").val(articleTitle);
	   $("#myModal #articleContent").val(articleContent);
	   $("#myModal #articleAuthor").val(articleAuthor);
   }
  </script>
</html>
