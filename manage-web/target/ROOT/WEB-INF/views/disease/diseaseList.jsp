﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	System.out.println(gateWay);
	String servicePath = gateWay+"/system";
%>
<!DOCTYPE html>
<html>
<%@include file="../top.jsp"%>
<body>
	<div style="margin: 0px; background-color: white;">
		<blockquote class="layui-elem-quote">
			<form class="layui-form">
				<div class="layui-form-item" style="margin: 0;" id="diseaseQueryForm">
					<label class="layui-form-label layui-form-label-sm">编码</label>
					<div class="layui-input-inline">
						<input type="text" name="code" autocomplete="off" class="layui-input layui-btn-small">
					</div>
					<label class="layui-form-label layui-form-label-sm">名称</label>
					<div class="layui-input-inline">
						<input type="text" name="name" autocomplete="off" class="layui-input layui-btn-small">
					</div>
					<div class="layui-form-mid layui-word-aux" style="padding:0;">
						<button lay-filter="search" class="layui-btn" lay-submit >
							<i class="fa fa-search" aria-hidden="true"></i> 查询</button>
					</div>
					<div class="layui-form-mid layui-word-aux" style="padding:0;">
						<a href="javascript:" class="layui-btn" id="diseaseadd">
						<i class="layui-icon">&#xe608;</i>添加</a>
					</div>
				</div>
			</form>
		</blockquote>
		<div class="layui-form" id="diseaseList"></div>
	</div>
	<script type="text/javascript">
			layui.config({
				base: '<%=contextPath%>/static/js/'
			});

			layui.use(['btable','jquery','jquery_form','form'], function() {
				var $ = layui.jquery;
				var $ = layui.jquery_form($);
				var	btable = layui.btable(),
					layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
					layer = layui.layer, //获取当前窗口的layer对象
					form = layui.form();
				
				var del = function(id,tr){
					$.ajax({
		                type: "POST",
		                url: "<%=servicePath%>/disease/delete/"+id,
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
					$.get('<%=contextPath%>/dictPage/disease/form'+endIndex, null, function(form) {
						addBoxIndex = layer.open({
							type: 1,
							title: title,
							content: form,
							btn: ['保存', '取消'],
							shade: false,
							offset: ['100px', '30%'],
							area: ['600px', '400px'],
							zIndex: 2017,
							maxmin: true,
							yes: function(index) {
								//触发表单的提交事件
								$('form.layui-form').find('button[lay-filter=diseaseSubmit]').click();
							},
							success: function(layero, index) {
								var form = layui.form();
								form.render();
								var layer = layui.layer;
								if($.trim($("#diseaseId").val()).length > 0){
									$.ajax({
						                type: "GET",
						                url: "<%=servicePath%>/disease/"+$.trim($("#diseaseId").val()),
						                success: function (obj) {
						                    if(obj.msg){
						                    	layer.alert(data.msg);
						                    	layer.close(index);
						                    }else{
						                    	 $("#diseaseForm").find('input[name=code]').val(obj.code);
						                    	 $("#diseaseForm").find('input[name=name]').val(obj.name);
						                    	 $("#diseaseForm").find('input[name=tags]').val(obj.tags);
						                    	 $("#diseaseForm").find('input[name=fullSpell]').val(obj.fullSpell);
						                    	 $("#diseaseForm").find('input[name=abbrSpell]').val(obj.abbrSpell);
						                    }
						                },
						                error: function(data) {
						                	layer.alert(data.msg);
						                	layer.close(index);
						                }
						            });
                                }
                                //监听提交
								form.on('submit(diseaseSubmit)', function(data) {
									$("#diseaseForm").ajaxSubmit({
										 	type:'post',      
							                success:function(data)
							                {    //成功执行的方法  
							                	if(data.msg){
							                		layer.alert(data.msg);
							                	}
//							                	btable.get();
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
                    url: '<%=servicePath%>/disease/page', //地址
                    paged:true,
					elem: '#diseaseList', //内容容器
//					params: { //发送到服务端的参数
//						code: $("#diseaseQueryForm").find('input[name=code]').val(),
//						name:  $("#diseaseQueryForm").find('input[name=name]').val()
//					},
					even: true,//隔行变色
			        field: 'id', //主键ID
			        checkbox: false,//是否显示多选框
					type: 'POST',
					pageSize:15,
					columns:[{
		                fieldName:'编码',
		                field:'code'
		            },{
		                fieldName:'名称',
		                field:'name'
		            },{
		                fieldName:'标签',
		                field:'tags'
		            },{
		                fieldName:'全拼',
		                field:'fullSpell'
		            },{
		                fieldName:'简拼',
		                field:'abbrSpell'
		            }, {
		                fieldName: '操作',
		                field: 'id',
		                format: function (val,obj) {
		                    var html = '<input type="button" value="编辑" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ' +
		                    '<input type="button" value="删除" data-action="del" data-id="' + val + '" class="layui-btn layui-btn-mini layui-btn-danger" />';
		                    return html;
		                }
		            }],
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

				form.on('submit(search)', function(data) {
					 btable.get({
						 	code: data.field.code,
							name: data.field.name
		                });
					 return false;
				}); 
				   //这个是点击之后才添加的。
	            $('#diseaseadd').on('click', function (){onEdit("添加",null);});
			});
		</script>
</body>

</html>