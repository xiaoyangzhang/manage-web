<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	<div style="margin: 0px; background-color: white;">
		<blockquote class="layui-elem-quote">
			<div class="layui-form-item" style="margin: 0;" id="dictionaryQueryForm">
				<label class="layui-form-label layui-form-label-lg">字典编码</label>
				<div class="layui-input-inline">
					<input type="text" name="dictCode" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label layui-form-label-lg">字典名称</label>
				<div class="layui-input-inline">
					<input type="text" name="dictName" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label layui-form-label-lg">条目名称</label>
				<div class="layui-input-inline">
					<input type="text" name="itemName" autocomplete="off" class="layui-input">
				</div>
				<a href="javascript:" class="layui-btn" id="dictionarysearch">
					<i class="layui-icon">&#xe615;</i> 搜索
				</a>
				<a href="javascript:" class="layui-btn" id="dictionaryadd">
						<i class="layui-icon">&#xe608;</i> 添加
				</a>
			</div>
		</blockquote>
		<div class="layui-form" id="dictionaryList">
		</div>
	</div>
	<script>
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
		                url: "<%=servicePath%>/dictionary/delete/"+id,
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
					$.get('<%=contextPath%>/dictPage/dictionary/form'+endIndex, null, function(form) {
						addBoxIndex = layer.open({
							type: 1,
							title: '添加表单',
							content: form,
							btn: ['保存', '取消'],
							shade: false,
							offset: ['100px', '30%'],
							area: ['600px', '400px'],
							zIndex: 2017,
							maxmin: true,
							yes: function(index) {
								//触发表单的提交事件
								$('form.layui-form').find('button[lay-filter=dictionarySubmit]').click();
							},
							success: function(layero, index) {
								var form = layui.form();
								form.render();
								var layer = layui.layer;
								if($.trim($("#dictionaryId").val()).length > 0){
									$.ajax({
						                type: "GET",
						                url: "<%=servicePath%>/dictionary/"+$.trim($("#dictionaryId").val()),
						                success: function (obj) {
						                    if(obj.msg){
						                    	layer.alert(data.msg);
						                    	layer.close(index);
						                    }else{
						                    	 $("#dictionaryForm").find('input[name=dictCode]').val(obj.dictCode);
						                    	 $("#dictionaryForm").find('input[name=dictName]').val(obj.dictName);
						                    	 $("#dictionaryForm").find('input[name=itemCode]').val(obj.itemCode);
						                    	 $("#dictionaryForm").find('input[name=itemName]').val(obj.itemName);
						                    	 $("#dictionaryForm").find('input[name=itemDesc]').val(obj.itemDesc);
						                    }
						                },
						                error: function(data) {
						                	layer.alert(data.msg);
						                	layer.close(index);
						                }
						            });
                                }
                                //监听提交
								form.on('submit(dictionarySubmit)', function(data) {
									$("#dictionaryForm").ajaxSubmit({
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
					<%-- $.get('<%=contextPath%>/dictPage/dictionary/form'+endIndex, null, function(form) {
						addBoxIndex = layer.open({
							type: 1,
							title: title,
							content: form,
							btn: ['确定', '取消'],
							shade: false,
							offset: ['100px', '30%'],
							area: ['600px', '400px'],
							zIndex: 2017,
							maxmin: true,
							yes: function(index, layero) {
								//触发表单的提交事件
								btable.get();
								layer.close(index);
							},
							end: function() {
								addBoxIndex = -1;
							}
						});
					}); --%>
				};
				
				
				btable.set({
                    openWait: true,
                    url: '<%=servicePath%>/dictionary/', //地址
                    paged:false,
					elem: '#dictionaryList', //内容容器
					params: { //发送到服务端的参数
						dictCode: $("dictionaryQueryForm").find('input[name=dictCode]').val(),
						dictName: $('input[name=dictName]').val(),
						itemName: $('input[name=itemName]').val()
					},
					even: true,//隔行变色
			        field: 'id', //主键ID
			        checkbox: false,//是否显示多选框
					type: 'GET',
//					pageSize:10,
					columns:[{
		                fieldName:'字典编码',
		                field:'dictCode'
		            },{
		                fieldName:'字典名称',
		                field:'dictName'
		            },{
		                fieldName:'条目编码',
		                field:'itemCode'
		            },{
		                fieldName:'条目名称',
		                field:'itemName'
		            },{
		                fieldName:'条目描述',
		                field:'itemDesc'
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
	                                        var name = $that.parent('td').siblings('td[data-field=itemName]').text();
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
				   /* form.on('click(dictionarysearch)', function () {
		                btable.get({
		                	dictCode: $("dictionaryQueryForm").find('input[name=dictCode]').val(),
							dictName: $('input[name=dictName]').val(),
							itemName: $('input[name=itemName]').val()
		                });
		                return false;
		            }); */
				$('#dictionarysearch').on('click', function() {
					 btable.get({
		                	dictCode: $('input[name=dictCode]').val(),
							dictName: $('input[name=dictName]').val(),
							itemName: $('input[name=itemName]').val()
		                });
				}); 
				   //这个是点击之后才添加的。
	            $('#dictionaryadd').on('click', function (){onEdit("添加",null);});
			});
		</script>
</body>

</html>