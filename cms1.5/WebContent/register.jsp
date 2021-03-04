<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>register</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/demo.css" />
<!--必要样式-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/component.css" />
<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>

</head>
<body>
		<div class="container demo-1">
			<div class="content">
				<div id="large-header" class="large-header">
					<canvas id="demo-canvas"></canvas>
					<div class="logo_box">
						<h3>欢迎你</h3>
						<form id="regForm" action="${pageContext.request.contextPath}/UserController?op=register" name="f" method="post">
							<div class="input_outer">
								<span class="u_user"></span>
								<input name="logname" id="logname" class="text" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">
							     <br/><span id="lognameId"></span>
							</div>
							<div class="input_outer">
								<span class="us_uer"></span>
								<input name="logpass" id="logpass" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入密码">
							    <br/><span id="logpassId" style="position:relative;top:30px"></span>
							</div>
							<div class="input_outer">
								<span class="us_uer"></span>
								<input name="logrepass"  id="logrepass" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入确认密码">
								<br/><span id="logrepassId" style="position:relative;top:30px"></span>
							</div>
							<div class="mb2"><button type="submit" class="act-but submit" style="color: #FFFFFF;margin:0 auto;border:0;width:330px">注册</button></div>
						</form>
					</div>
				</div>
			</div>
		</div><!-- /container -->
		<script src="${pageContext.request.contextPath}/dist/js/TweenLite.min.js"></script>
		<script src="${pageContext.request.contextPath}/dist/js/EasePack.min.js"></script>
		<script src="${pageContext.request.contextPath}/dist/js/rAF.js"></script>
		<script src="${pageContext.request.contextPath}/dist/js/demo-1.js"></script>
		<div style="text-align:center;">
<p>更多模板：<a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>
</div>
	</body>
	<script>
	  $(function(){
		  //失去焦点时触发
		  $("#logname").blur(function(){
			  //判断用户名是否为空
			  if( $("#logname").val().trim()==""){
				  $("#lognameId").text("用户名不能为空");
			  }else{
				  //发送ajax请求,进行用户名验证是否重复
				  $.ajax({
					  type:"POST",
					  url:"${pageContext.request.contextPath}/UserController",
					  contentType:"application/x-www-form-urlencoded",
					  data:{op:"checkName",uname:$("#logname").val()},
					  dataType:"text",
					  success:function(data){
						  $("#lognameId").text(data); 
					  }
				  });
			  }
		  });
		  
		  //判断密码,>6,不能包含空格
		   $("#logpass").blur(function(){
			   if( $("#logpass").val().trim().length>=6 && $("#logpass").val().trim().indexOf(" ")==-1){
				   $("#logpassId").text("正确");
			   }else{
				   $("#logpassId").text("密码长度大于6,并且不能包含空格!");
			   }
		   });
		  
		 //判断确认密码
		   $("#logrepass").blur(function(){
			   var urepwd=$("#logrepass").val();
			   var upwd=$("#logpass").val();
			   if(urepwd==upwd){
				   $("#logrepassId").text("两次密码一致");
			   }else{
				   $("#logrepassId").text("两次密码不一致"); 
			   }
		   });
		 //最终表单提交事件
		 $("#regForm").submit(function(){
			 if($("#lognameId").text()=="可用" &&  $("#logpassId").text()=="正确" &&  $("#logrepassId").text()=="两次密码一致"){
				 return true;
			 }else{
				 return false;
			 }
		 })
	  })
	
	</script>
</html>