<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 	导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String contextPath=request.getContextPath();// /cms1.1
	//System.out.print(contextPath);	
%>
<%
  String userName="";
  String userPwd="";
  String checked="";
  
  //读取cookies
  Cookie[] cookies= request.getCookies();
  if(cookies!=null){
	  for(Cookie c:cookies){
		  //判断key
		  if(c.getName().equals("userName")){
			  userName=c.getValue();
		  }else if(c.getName().equals("userPwd")){
			  userPwd=c.getValue();
		  }else if(c.getName().equals("checked")){
			  checked=c.getValue();
		  }
	  }
  }

  //将参数存储在作用域中
  pageContext.setAttribute("userName", userName);
  pageContext.setAttribute("userPwd", userPwd);
  pageContext.setAttribute("checked", checked);
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

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=contextPath %>/dist/css/bootstrap.min.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="<%=contextPath %>/dist/css/signin.css" rel="stylesheet">


    
  </head>

  <body>

    <div class="container">
 		${sessionScope.msg }
      <form class="form-signin" action="<%=contextPath %>/UserController?op=login" method="post">
        <h2 class="form-signin-heading">请登录</h2>
        <label for="userName" class="sr-only">用户名</label>
        <input type="text" id="userName"  name="userName" class="form-control" placeholder="用户名" required autofocus value="${userName}">
        <label for="userPwd" class="sr-only">密码</label>
        <input type="password" id="userPwd" name="userPwd" class="form-control" placeholder="密码" required value="${userPwd }">
        <div class="checkbox">
          <label>
            <c:if test="${checked eq 'checked'}">
                <input type="checkbox" value="remember-me" name="remember-me" checked > 记住密码
            </c:if>
            <c:if test="${checked != 'checked'}">
                <input type="checkbox" value="remember-me" name="remember-me" > 记住密码
            </c:if>
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>

    </div> <!-- /container -->


  </body>
</html>
