﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 String basePath = request.getContextPath();

%>
	<head>
		<meta charset="utf-8">
		<title>新健康管理后台</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="<%= basePath%>/static/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="<%= basePath%>/static/css/global.css" media="all">
		<link rel="stylesheet" href="<%= basePath%>/static/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/static/css/btable.css" />
		<script type="text/javascript" src="<%= basePath%>/static/plugins/layui/layui.js"></script>
		<%--<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>--%>

	<%-- <script type="text/javascript" src="<%= basePath%>/static/plugins/layui/lay/dest/layui.all.js"></script> --%>
	</head>