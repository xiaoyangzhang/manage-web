<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/system";
%>
	<div style="margin: 15px;">
		<form class="layui-form" action="<%=servicePath%>/diseaseGroup/edit" name="diseaseGroupForm" id="diseaseGroupForm">
			<input type="hidden" name='id' id="diseaseGroupId" value="${diseaseGroup.id }" />
			<div class="layui-form-item">
				<label class="layui-form-label">分组名称</label>
				<div class="layui-input-block">
					<input type="text" name="name" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">分组描述</label>
				<div class="layui-input-block">
					<input type="text" name="desc" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<button lay-filter="diseaseGroupSubmit" lay-submit style="display: none;"></button>
		</form>
	</div>

