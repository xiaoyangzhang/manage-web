<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>新健康后台管理系统</title>
		<script type="text/javascript" src="<%= contextPath%>/static/plugins/layui/layui.js"></script>
		<link rel="stylesheet" href="<%= contextPath%>/static/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="<%= contextPath%>/static/css/login.css" />
	</head>

	<body class="beg-login-bg">
		<div class="beg-login-box">
			<header>
				<h1>新健康后台管理系统</h1>
			</header>
			<div class="beg-login-main">
				<form action="/manage/login" class="layui-form" method="post"><input name="__RequestVerificationToken" type="hidden" value="fkfh8D89BFqTdrE2iiSdG_L781RSRtdWOH411poVUWhxzA5MzI8es07g6KPYQh9Log-xf84pIR2RIAEkOokZL3Ee3UKmX0Jc8bW8jOdhqo81" />
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe612;</i>
                    </label>
						<input type="text" id="userName" name="username" lay-verify="userName" autocomplete="off" placeholder="这里输入登录名" class="layui-input">
					</div>
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe642;</i>
                    </label>
						<input type="password" name="password" lay-verify="password" autocomplete="off" placeholder="这里输入密码" class="layui-input">
					</div>
					<div class="layui-form-item">
						<div class="beg-pull-left beg-login-remember">
							<label>记住帐号？</label>
							<input type="checkbox" id="rememberMe" name="rememberMe" value="true" lay-skin="switch" checked title="记住帐号">
						</div>
						<div class="beg-pull-right">
							<button class="layui-btn layui-btn-primary" id="loginBtn" lay-submit lay-filter="login">
                            <i class="layui-icon">&#xe650;</i> 登录
                        </button>
						</div>
						<div class="beg-clear"></div>
					</div>
				</form>
			</div>
			<!-- <footer>
				<p>Beginner © www.zhengjinfan.cn</p>
			</footer> -->
		</div>
		<script>
			function setCookie(name,value) {
				var Days = 30;
				var exp = new Date();
				exp.setTime(exp.getTime() + Days*24*60*60*1000);
				document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
			}

			function getCookie(name) {
				var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
				if(arr=document.cookie.match(reg))
					return unescape(arr[2]);
				else
					return null;
			}

			function delCookie(name) {
				var exp = new Date();
				exp.setTime(exp.getTime() - 1);
				var cval=getCookie(name);
				if(cval!=null)
					document.cookie= name + "="+cval+";expires="+exp.toGMTString();
			}

			layui.use(['layer', 'form'], function() {
				var layer = layui.layer,
					$ = layui.jquery,
					form = layui.form();

				if(getCookie('userName')){
					$("#userName").val(getCookie('userName'));
				}else{
					$("#userName").val('');
					$("#rememberMe").removeAttr('checked');
					$("#rememberMe").next().removeClass('layui-form-onswitch');
				}

				$('#loginBtn').on('click',function(data){
					var remBool = $("#rememberMe").prop('checked'),
						userName = $("#userName").val();
					if(remBool){
						setCookie('userName',userName);
					}else{
						if(getCookie('userName')){
							delCookie('userName');
						}
					}
				});
			});
		</script>
	</body>

</html>