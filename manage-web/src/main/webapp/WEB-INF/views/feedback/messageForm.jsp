﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/system";
%>
<!DOCTYPE html>
<html>
<%@include file="../top.jsp"%>
<body>
	<div class="layui-field-box layui-form" id="messageList" style="padding: 0px 0px 0px 10px;"></div>
	<div style="margin: 15px;">
		<form class="layui-form" action="<%=servicePath%>/sysfeedback/message/send" name="messageForm" id="messageForm">
			<input type="hidden" name='doctorId' id="doctorId" value="${message.doctorId }" />
			<input type="hidden" name='patientId' id="patientId" value="${message.patientId }" />
			<div class="layui-form-item">
				<label class="layui-form-label">消息标题</label>
				<div class="layui-input-block">
					<input type="text" name="title" lay-verify="title" value="意见反馈回复"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">消息内容</label>
				<div class="layui-input-block">
					<input type="text" name="message" lay-verify="title"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<button lay-filter="messageSubmit" lay-submit style="display: none;"></button>
		</form>
	</div>
	<script type="text/javascript">
			layui.config({
				base: '<%=contextPath%>/static/js/'
			});

			layui.use(['btable','jquery','jquery_form','form'], function() {
				var $ = layui.jquery;
				var $ = layui.jquery_form($);
					btable = layui.btable(),
					layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
					layer = layui.layer, //获取当前窗口的layer对象
					form = layui.form();
					
					//监听提交
					form.on('submit(messageSubmit)', function(data) {
								$("#messageForm").ajaxSubmit({
									 	type:'post',      
						                success:function(data)
						                {    //成功执行的方法  
						                	if(data.msg){
						                		layer.alert(data.msg);
						                	}
						                	$("#messageForm").resetForm();
						                	btable.get();
						                }     
								});
								return false;
							});
					
					btable.set({
	                    openWait: true,
	                    url: '<%=servicePath%>/sysfeedback/message/page', //地址
	                    paged:true,
						elem: '#messageList', //内容容器
						params: { //发送到服务端的参数
							doctorId: $("#messageForm").find('input[name=doctorId]').val(),
							patientId:  $("#messageForm").find('input[name=patientId]').val()
						},
						even: true,//隔行变色
				        field: 'id', //主键ID
				        checkbox: false,//是否显示多选框
						type: 'GET',
						columns:[{
			                fieldName:'原因',
			                field:'message'
			            },{
			                fieldName:'发送时间',
			                field:'createTime'
			            }],
			            onSuccess: function ($elem) { //$elem当前窗口的jq对象
		                },
						fail: function(msg) { //获取数据失败的回调
							parent.layer.msg(msg, { icon: 2 });
						},
						complate: function() { //完成的回调
						},
					});
					btable.render();
			});
		</script>
</body>

</html>