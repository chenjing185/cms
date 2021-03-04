<%@page import="com.etc.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.etc.service.impl.ArticleServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
<!-- <style>
ul.pagination {
    display: inline-block;
    padding: 0;
    margin: 0;
}

ul.pagination li {display: inline;}

ul.pagination li a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    border-radius: 5px;
}

ul.pagination li a.active {
    background-color: #4CAF50;
    color: white;
    border-radius: 5px;
}

ul.pagination li a:hover:not(.active) {background-color: #ddd;}
</style> -->
<!-- ../返回上一级 -->
<link
	href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css"
	rel="stylesheet">


<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/dist/css/dashboard.css"
	rel="stylesheet">
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
					<li><a href="#" style="color: red;">欢迎${sessionScope.user.userName }登录</a></li>
					<li><a href="#">设置</a></li>
					<li><a href="#">个人信息</a></li>
					<li><a href="#">帮助</a></li>
				</ul>
				<!-- 搜索功能 -->
				<form class="navbar-form navbar-right">
					<input type="text" class="form-control" placeholder="搜索标题..." id="keyword"
						name="articleLike" value="" />
				<!--form表单下的button按钮会自动提交表单的功能
					如果点击事件,就需要button改成普通按钮<input type="button"/> -->
					<input type="button" class="form-control" id="seachBtn"   value="搜索"/>
					<input type="button" class="form-control" id="clearBtn"   value="清除"/>
				</form>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="${pageContext.request.contextPath}/mvc/showArticles_ajax.jsp">文章列表 <span class="sr-only">(current)</span></a></li>
					<li><a href="${pageContext.request.contextPath}/mvc/addArticle.jsp">增加文章</a></li>
					<li><a href="#">Analytics</a></li>
					<li><a href="#">Export</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<!--   pageContext.request=>pageContext.getRequest()
				         request.contextPath=>request.getContextPath() -->
					<li><a
						href="${pageContext.request.contextPath}/UserController?op=query">用户列表</a></li>
					<li><a
						href="${pageContext.request.contextPath}/mvc/addUser.jsp">增加用户</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
					<li><a href="">More navigation</a></li>
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
						<tbody id="articleList">


							<%--<c:if test="${sessionScope.user!=null }" > 
	                	  
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
	                	
	                	</c:if>--%>
						</tbody>
					</table>
					<!-- 显示分页信息 -->
					<div id="showPageInfo"></div>
					<!-- 分页栏显示 -->
					<div class="col-md-12 text-center">
						<ul class="pagination" id="pageItem">
							
						</ul>
					</div>
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
				<form class="form-horizontal" role="form">
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
								<input type="text" class="form-control" id="articleId"
									name="articleId" readonly="readonly" />
							</div>
						</div>

						<div class="form-group">
							<label for="articleTitle" class="col-sm-2 control-label">文章标题</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="articleTitle"
									name="articleTitle" />
							</div>
						</div>
						<div class="form-group">
							<label for="articleContent" class="col-sm-2 control-label">文章内容</label>
							<div class="col-sm-8">
								<textarea rows="5" class="form-control" id="articleContent"
									name="articleContent"></textarea>
							</div>
						</div>

						<div class="form-group">
							<label for="articleAuthor" class="col-sm-2 control-label">文章作者</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="articleAuthor"
									name="articleAuthor" />
							</div>

						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="updateBtn" >保存修改</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
<script>
   //全局变量
   var titlekey="";
	$(function() {
		//界面一进来就发送ajax请求文章列表
		$.get("${pageContext.request.contextPath}/ArticleController", {
			op : "articlePage_ajax"
		}, function(result) {
			//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
			showData(result);
		}, "json");
		
		//首页
		$(document).on("click",".first",function(){
			//发送ajax请求  首页
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				showData(result);
			}, "json");
		});
		//末页
		$(document).on("click",".last",function(){
			var totalPage=$("#totalPage").text();
			//发送ajax请求  
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				pageNo:totalPage,
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				showData(result);
			}, "json");
		});
		//下一页
		$(document).on("click",".next",function(){
			var pageNo=$("#pageNo").text(); //获取到的值是字符串类型
			//发送ajax请求  
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				pageNo:(parseInt(pageNo)+1),   //当前页+1=下一页(转型)
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				showData(result);
			}, "json");
		});
		//每一页
		$(document).on("click",".currentPage",function(){
			//$(this)获取正在点击的a标签,text()获取a标签(按钮)的值
			var pageNo=$(this).text();
			//发送ajax请求  
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				pageNo:pageNo,
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				showData(result);
			}, "json");
		});
		//跳转
		$(document).on("click",".turnto",function(){
			//获取文本框的值
			var pageNo=$("#turntoId").val();
			var totalPage=$("#totalPage").text(); 
			if(pageNo<1){
				pageNo=1;
				$("#turntoId").val(pageNo);
			}else if(pageNo>totalPage*1){ //*1弱类型语言,字符串*1直接转数字
				pageNo=totalPage;
				$("#turntoId").val(pageNo);
			}
			//发送ajax请求  
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				pageNo:pageNo,
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				showData(result);
			}, "json");
		});
		
		
		//搜索按钮的模糊查询
		$("#seachBtn").click(function(){
			//获取用户输入的关键字
			titlekey=$("#keyword").val();
			//发送ajax请求
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "articlePage_ajax",
				key:titlekey
			}, function(result) {
				//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
				console.log(result);
				showData(result);
				
			}, "json");
		});
		//清除按钮
		$("#clearBtn").click(function(){
			titlekey="";
			$("#keyword").val("");
				//发送ajax请求  首页
				$.get("${pageContext.request.contextPath}/ArticleController", {
					op : "articlePage_ajax",
					key:titlekey
				}, function(result) {
					//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
					showData(result);
				}, "json");
		});
		//修改文章功能
		$("#updateBtn").click(function(){
			//创建一个js对象存储文章修改后的信息发送到服务器
			var article={
				articleId:$("#articleId").val(),
				articleTitle:$("#articleTitle").val(),
				articleContent:$("#articleContent").val(),
				articleAuthor:$("#articleAuthor").val(),
			}
			//发送ajax请求的修改操作
			$.post("${pageContext.request.contextPath}/ArticleController",{
				op:"update_ajax",
				article:JSON.stringify(article)
			},function(flag){
				if(flag){
					//关闭模态框后刷新数据
					$("#myModal").modal('hide');
					//显示最新数据->发ajax请求 
					$.get("${pageContext.request.contextPath}/ArticleController", {
						op : "articlePage_ajax",
						pageNo:$("#pageNo").text(),   //刷新当前页
						key:titlekey
					}, function(result) {
						//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
						showData(result);
					}, "json");
				}else{
					alert("修改失败");
				}
				
			},"json")
		});
		
		
	});
	function showData(result) {
		//每一次遍历之前都要清空
		$("#articleList").empty();
		$("#showPageInfo").empty();
		$("#pageItem").empty();
		//显示文章数据
		$.each(result.data,function(index, article) {
							//先把整个tr复制到后端的字符串中,自动转义,但是变量与字符串需要拼接 ,把转义后的内容复制到记事本,编辑,替换(ctrl+h)
							$("#articleList")
									.append(
											" <tr>\r\n" + "								<td>"
													+ article.articleId
													+ "</td>\r\n"
													+ "								<td>"
													+ article.articleTitle
													+ "</td>\r\n"
													+ "								<td>"
													+ article.articleContent
													+ "</td>\r\n"
													+ "								<td>"
													+ article.articleAuthor
													+ "</td>\r\n"
													+ "								<td>"
													+ article.articleDate
													+ "</td>\r\n"
													+ "								<td><button type=\"button\" class=\"btn btn-warning\"\r\n"
													+ "										data-toggle=\"modal\" data-target=\"#myModal\" \r\n"
													+ "										data-articleid=\""
													+ article.articleId
													+ "\"\r\n"
													+ "										data-articletitle=\""
													+ article.articleTitle
													+ "\"\r\n"
													+ "										data-articlecontent=\""
													+ article.articleContent
													+ "\"\r\n"
													+ "										data-articleauthor=\""
													+ article.articleAuthor
													+ "\"\r\n"
													+ "										onclick=\"showUpdateData(this)\">修改</button> <a\r\n"
													+ "									href=\"javascript:delFun("
													+ article.articleId
													+ ")\"><button\r\n" + 
					"											type=\"button\" class=\"btn btn-danger\">删除</button></a></td>\r\n"
													+ "							 </tr>");

						});
		//显示分页信息
		$("#showPageInfo").append(
				"当前第<span id='pageNo'>" +
				 result.pageNo +
				"</span>页/共<span id='totalPage'>"+
				 result.totalPage +
				"</span>页/每页显示<span id='pageSize'>"+
				 result.pageSize + 
				"</span>条/共<span id='totalCount'>" + 
				 result.totalCount + "</span>条");
		
		//分页栏显示
		//首页
		if(1==result.pageNo){
			$("#pageItem").append("<li class='disabled'><a>首页</a></li>");
		}else{
			$("#pageItem").append("<li><a class='first'>首页</a></li>");
		}
		//分页栏目
		for(var i=1;i<=result.totalPage;i++){
			if(i==result.pageNo){
				$("#pageItem").append("<li class='active'><a>"+i+"</a></li>");
			}else{
				$("#pageItem").append("<li><a class='currentPage'>"+i+"</a></li>")
			}
		}
		//下一页
		if(result.totalPage==result.pageNo){
			$("#pageItem").append("<li class='disabled'><a>下一页</a></li>");
		}else{
			$("#pageItem").append("<li><a class='next'>下一页</a></li>")
		}
		//末页
		if(result.totalPage==result.pageNo){
			$("#pageItem").append("<li class='disabled'><a>末页</a></li>");
		}else{
			$("#pageItem").append("<li><a class='last'>末页</a></li>")
		}
		//跳转页
		$("#pageItem").append("<li><a><input id='turntoId' style='height:20px;width:40px' type='number' min='1' max='"+result.totalPage+"'/></a><li>");
		$("#pageItem").append("<li><a class='turnto'>跳转</a><li>");
	}
	function delFun(articleId) {
		var flag = confirm("是否确定删除文章编号为:" + articleId);
		if (flag) {
			//发送ajax请求
			$.get("${pageContext.request.contextPath}/ArticleController", {
				op : "del_ajax",
				articleId:articleId
			}, function(result) {
				if(flag){
					//显示最新数据->发ajax请求 
					$.get("${pageContext.request.contextPath}/ArticleController", {
						op : "articlePage_ajax",
						pageNo:$("#pageNo").text(),   //刷新当前页
						key:titlekey
					}, function(result) {
						//显示数据在表格中,可以写成一个方法,以后就不用再拼接,一劳永逸
						showData(result);
					}, "json");
				}else{
					alert("删除失败");
				}
			}, "json");
		}
	}

	function showUpdateData(obj) {
		//获取原来的数据
		var articleId = $(obj).data("articleid");
		/* console.log(articleId); */
		var articleTitle = $(obj).data("articletitle");
		var articleContent = $(obj).data("articlecontent");
		var articleAuthor = $(obj).data("articleauthor");
		//显示在模态框中指定的位置
		$("#myModal #articleId").val(articleId);
		$("#myModal #articleTitle").val(articleTitle);
		$("#myModal #articleContent").val(articleContent);
		$("#myModal #articleAuthor").val(articleAuthor);
	}
</script>
</html>
