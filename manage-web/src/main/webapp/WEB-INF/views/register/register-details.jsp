﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String contextPath = request.getContextPath();
%>
<html>

<head>
	<meta charset="UTF-8">
	<title>产科患者详情</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<%=contextPath%>/static/plugins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="<%=contextPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=contextPath%>/static/css/btable.css" />
	<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/static/js/jquery.tmpl.min.js"></script>
</head>
<body>
<blockquote class="layui-elem-quote" style="padding: 10px 15px;line-height: 30px;">当前位置:产科患者详情<a href="javascript:history.back(-1);" style="float: right;height: 30px;line-height: 30px;" class="layui-btn layui-btn-normal">返回</a></blockquote>
<div class="layui-whole">
	<div class="layui-whole-con">
		<input type="hidden" value="${id}" id="registerId" />
		<h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>基础信息</h2>
		<table class="layui-table" style="margin:0 0 10px 0;">
			<colgroup>
				<col width="100px">
				<col>
				<col width="100px">
				<col>
				<col width="100px">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<td>用户名</td>
				<td>${userPatientInfo.realname}</td>
				<td>性别</td>
				<td>${userPatientInfo.sex==1?'男':'女'}</td>
				<td>出生日期</td>
				<td>${userPatientInfo.birthday}</td>
			</tr>
			<tr>
				<td>手机号</td>
				<td>${userPatientInfo.username}</td>
				<td>身份证号</td>
				<td>${userPatientInfo.idno}</td>
				<td>填写时间</td>
				<td>${userInfo.createTime}</td>
			</tr>
			</tbody>
		</table>

		<h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>孕妇信息</h2>
		<table class="layui-table" style="margin:0 0 10px 0;">
			<colgroup>
				<col width="110px">
				<col>
				<col width="110px">
				<col>
				<col width="110px">
				<col>
				<col width="110px">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<td>丈夫姓名</td>
				<td>${userInfo.husbandName}</td>
				<td>联系电话</td>
				<td>${userInfo.husbandMobile}</td>
				<td>现住址</td>
				<td>${userInfo.resideAdress}</td>
				<td>户口</td>
				<td>${userInfo.birthPlace}</td>
			</tr>
			<tr>
				<td>孕周</td>
				<td>${userInfo.pregnantWeek}</td>
				<td>预产期</td>
				<td>${userInfo.expectBirthDate}</td>
				<td>孕次</td>
				<td>${userInfo.pregnantTime}</td>
				<td>产次</td>
				<td>${userInfo.produceTime}</td>
			</tr>
			<tr>
				<td>高危因素</td>
				<td>${userInfo.dangerous}</td>
				<td>备注</td>
				<td>${userInfo.remark}</td>
				<td>三联单回执</td>
				<td></td>
				<td>转出单位</td>
				<td></td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
<script type="application/javascript">

</script>
</body>
</html>