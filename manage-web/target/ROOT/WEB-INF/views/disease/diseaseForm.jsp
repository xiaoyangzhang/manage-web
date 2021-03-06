﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/system";
%>

	<div style="margin: 15px;">
		<form class="layui-form" action="<%=servicePath%>/disease/edit" name="diseaseForm" id="diseaseForm">
			<input type="hidden" name='id' id="diseaseId" value="${disease.id }" />
			<div class="layui-form-item">
				<label class="layui-form-label">编码</label>
				<div class="layui-input-block">
					<input type="text" name="code" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">名称</label>
				<div class="layui-input-block">
					<input type="text" name="name" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">标签</label>
				<div class="layui-input-block">
					<input type="text" name="tags" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">全拼</label>
				<div class="layui-input-block">
					<input type="text" name="fullSpell" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">简拼</label>
				<div class="layui-input-block">
					<input type="text" name="abbrSpell" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<button lay-filter="diseaseSubmit" lay-submit style="display: none;"></button>
		</form>
	</div>

