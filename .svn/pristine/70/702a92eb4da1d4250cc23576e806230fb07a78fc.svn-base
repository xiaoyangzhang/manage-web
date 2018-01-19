<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/system";
%>
	<div style="margin: 15px;">
		<form class="layui-form" action="<%=servicePath%>/city/edit" name="dictCityForm" id="dictCityForm">
			<input type="hidden" name='id' id="id" value="${dictCity.id }" />
			<input type="hidden" name='parentId' id="parentId" value="${dictCity.parentId }" />
			<input type="hidden" name='level' id="level" value="${dictCity.level }" />
			<div class="layui-form-item">
				<label class="layui-form-label">城市编码</label>
				<div class="layui-input-block">
					<input type="text" name="cityCode" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">城市名称</label>
				<div class="layui-input-block">
					<input type="text" name="name" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">是否主要城市：</label>
				<div class="layui-input-block">
					<input type="checkbox" name="isMainCity" lay-verify="title" value="1"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">映射编码</label>
				<div class="layui-input-block">
					<input type="text" name="mappingCode" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">排序序号</label>
				<div class="layui-input-block">
					<input type="text" name="sortNo" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">城市简称</label>
				<div class="layui-input-block">
					<input type="text" name="abbrName" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">城市全拼</label>
				<div class="layui-input-block">
					<input type="text" name="fullSpell" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">城市简拼</label>
				<div class="layui-input-block">
					<input type="text" name="abbrSpell" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<button lay-filter="citySubmit" lay-submit style="display: none;"></button>
		</form>
	</div>

