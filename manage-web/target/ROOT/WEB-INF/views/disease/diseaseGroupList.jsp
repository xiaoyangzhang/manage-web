﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/system";
%>
<!DOCTYPE html>
<html>
<title>疾病分组</title>
<%@include file="../top.jsp"%>
<body>
    <div class="site-demo-editor">
		<blockquote class="layui-elem-quote">
			<form class="layui-form">
				<div class="layui-form-item" style="margin:0;" id="diseaseGroupQueryForm">
					<label class="layui-form-mid" style="padding: 5px 0;">疾病组名称</label>
					<div class="layui-input-inline">
						<input type="text" name="name" autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-mid" style="padding: 5px 0;">描述</label>
					<div class="layui-input-inline">
						<input type="text" name="desc" autocomplete="off" class="layui-input">
					</div>
					<a href="javascript:" class="layui-btn layui-btn-small" id="diseaseGroupsearch">
						<i class="layui-icon">&#xe615;</i> 搜索
					</a>
					<a href="javascript:" class="layui-btn layui-btn-small" id="diseaseGroupadd">
							<i class="layui-icon">&#xe608;</i> 添加
					</a>
				</div>
			</form>
		</blockquote>
		<div class="layui-form" id="diseaseGroupList"></div>
    </div>
    <div class="site-demo-result" id="diseaseRalationDiv">
		<iframe frameborder="0" id="LAY_demo" name="LAY_demo" ></iframe>
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
				
				var del = function(id,tr){
					$.ajax({
		                type: "POST",
		                url: "<%=servicePath%>/diseaseGroup/delete/"+id,
		                success: function (obj) {
		                    if(obj.msg){
		                    	layer.alert(data.msg);
		                    	return false;
		                    }else{
		                    	tr.remove();
                                layerTips.msg('删除成功.');
		                    }
		                },
		                error: function(data) {
		                	layer.alert(data.msg);
		                	return false;
		                }
		            });
				};
				
				var addBoxIndex = -1;
				var onEdit = function(title,id){
					//本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
					if(addBoxIndex !== -1)
							return;
					var endIndex = "";
					if(id!=null){
						endIndex = "?id="+id;
					}
					$.get('<%=contextPath%>/dictPage/diseaseGroup/form'+endIndex, null, function(form) {
						addBoxIndex = layer.open({
							type: 1,
							title: title,
							content: form,
							btn: ['保存', '取消'],
							shade: false,
							offset: ['100px', '30%'],
							area: ['400px', '320px'],
							zIndex: 2017,
							maxmin: true,
							yes: function(index) {
								//触发表单的提交事件
								$('form.layui-form').find('button[lay-filter=diseaseGroupSubmit]').click();
							},
							success: function(layero, index) {
								var form = layui.form();
								form.render();
								var layer = layui.layer;
								if($.trim($("#diseaseGroupId").val()).length > 0){
									$.ajax({
						                type: "GET",
						                url: "<%=servicePath%>/diseaseGroup/"+$.trim($("#diseaseGroupId").val()),
						                success: function (obj) {
						                    if(obj.msg){
						                    	layer.alert(data.msg);
						                    	layer.close(index);
						                    }else{
						                    	$("#diseaseGroupForm").find('input[name=name]').val(obj.name);
						                    	 $("#diseaseGroupForm").find('input[name=desc]').val(obj.desc);
						                    }
						                },
						                error: function(data) {
						                	layer.alert(data.msg);
						                	layer.close(index);
						                }
						            });
                                }
                                //监听提交
								form.on('submit(diseaseGroupSubmit)', function(data) {
									$("#diseaseGroupForm").ajaxSubmit({
										 	type:'post',      
							                success:function(data)
							                {    //成功执行的方法  
							                	if(data.msg){
							                		layer.alert(data.msg);
							                	}
							                	btable.get();
							                	layer.close(index);
							                }     
									});
									return false;
								});
							},
							end: function() {
								addBoxIndex = -1;
							}
						});
					});
				};
				
				btable.set({
                    openWait: true,
                    url: '<%=servicePath%>/diseaseGroup', //地址
                    paged:false,
					elem: '#diseaseGroupList', //内容容器
					params: { //发送到服务端的参数
						name: $("#diseaseGroupQueryForm").find('input[name=name]').val(),
						 desc: $("#diseaseGroupQueryForm").find('input[name=desc]').val()
					},
					even: true,//隔行变色
			        field: 'id', //主键ID
			        checkbox: false,//是否显示多选框
					type: 'GET',
					columns:[{
		                fieldName:'疾病组名称',
		                field:'name'
		            },{
		                fieldName:'描述',
		                field:'desc'
		            },{
		                fieldName:'疾病统计数',
						width:60,
		                field:'num'
		            }, {
		                fieldName: '操作',
		                field: 'id',
		                format: function (val,obj) {
		                    var html = '<input type="button" value="编辑" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ' +
		                    '<input type="button" value="删除" data-action="del" data-id="' + val + '" class="layui-btn layui-btn-mini layui-btn-danger" />'+
		                    '<input type="button" value="详情" data-action="trclick" data-id="' + val + '" class="layui-btn layui-btn-mini layui-btn-danger" />';
		                    return html;
		                }
		            }],
		            onclick:function(tr){
		            	
		            },
		            onSuccess: function ($elem) { //$elem当前窗口的jq对象
	                    $elem.children('tr').each(function () {
	                        $(this).children('td:last-child').children('input').each(function () {
	                            var $that = $(this);
	                            var action = $that.data('action');
	                            var id = $that.data('id');
	                            $that.on('click', function () {
	                                switch (action) {
	                                    case 'edit':
	                                        onEdit("编辑",id);
	                                        break;
	                                    case 'trclick':
	                                    	$("#LAY_demo").attr('src', "<%=contextPath%>/dictPage/diseaseGroupRelation?dictDiseaseGroupId="+id);
	                                        break;
	                                    case 'del': //删除
	                                        var name = $that.parent('td').siblings('td[data-field=name]').text();
	                                        //询问框
	                                        layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
	                                            del(id,$that.parent('td').parent('tr'));
	                                        });
	                                        break;
	                                }
	                            });
	                        });
	                    });
	                },
					fail: function(msg) { //获取数据失败的回调
						layer.msg(msg, { icon: 2 });
					},
					complate: function() { //完成的回调
					},
				});
				btable.render();

				$('#diseaseGroupsearch').on('click', function() {
					 btable.get({
						 name: $("#diseaseGroupQueryForm").find('input[name=name]').val(),
						 desc: $("#diseaseGroupQueryForm").find('input[name=desc]').val()
		                });
				}); 
				   //这个是点击之后才添加的。
	            $('#diseaseGroupadd').on('click', function (){onEdit("添加",null);});
			});
		</script>
</body>

</html>