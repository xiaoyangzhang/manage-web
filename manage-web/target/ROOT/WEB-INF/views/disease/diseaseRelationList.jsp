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
	<div class="layui-form-item" id="diseaseGroupQueryForm" style="text-align: right;padding-right: 0px;margin-bottom: 0;">
		<blockquote class="layui-elem-quote">
			<form class="layui-form">
				<input type="hidden" id="dictDiseaseGroupId" value="${diseaseGroupRelation.dictDiseaseGroupId }"/>
				<a href="javascript:" class="layui-btn layui-btn-small"
				   id="diseaseGroupRelationadd"> <i class="layui-icon">&#xe608;</i> 添加疾病
				</a>
			</form>
		</blockquote>
		</div>
		<div class="layui-field-box layui-form" id="diseaseList" style="padding: 0px 0px 0px 10px;"></div>
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
				
					var addBoxIndex = -1;
					var onEdit = function(title){
						//本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
						if(addBoxIndex !== -1)
								return;
							addBoxIndex = parent.layer.open({
								type: 2,
								title: title,
								content: '<%=contextPath%>/dictPage/diseaseGroupRelation/form/'+$("#dictDiseaseGroupId").val(),
								btn: ['保存', '取消'],
								shade: false,
								offset: ['100px', '30%'],
								area: ['680px', '460px'],
								zIndex: 2017,
								maxmin: true,
								yes: function(index,layero) {
									//触发表单的提交事件
									var body = parent.layer.getChildFrame('body', index);
									body.find('button[lay-filter=diseaseRelationSubmit]').click();
									//var iframeWin = window[layero.find('iframe')[0]['name']];
									//iframeWin.getSelected(); 
								},
								success: function(layero, index) {
									/* var form = layui.form();
									form.render();
									//监听提交
									form.on('submit(diseaseRelationSubmit)', function(data) {
										console.log(data);
										$("#diseaseGroupRelationForm").ajaxSubmit({
											 	type:'post',      
								                success:function(data)
								                {    //成功执行的方法  
								                	if(data.msg){
								                		parent.layer.alert(data.msg);
								                	}
								                	btable.get();
								                	parent.layer.close(index);
								                }     
										});
										return false;
									}); */
								},
								end: function() {
									addBoxIndex = -1;
								}
							});
					};
					
					var delDiseaseGroupRelation = function(id,tr){
							$.ajax({
				                type: "POST",
				                url: "<%=servicePath%>/diseaseGroupRelation/delete/?dictDiseaseId="+id+"&dictDiseaseGroupId="+$.trim($("#dictDiseaseGroupId").val()),
				                success: function (obj) {
				                    if(obj.msg){
				                    	parent.layer.alert(data.msg);
				                    	return false;
				                    }else{
				                    	tr.remove();
				                    	parent.layerTips.msg('删除成功.');
				                    }
				                },
				                error: function(data) {
				                	parent.layer.alert(data.msg);
				                	return false;
				                }
				            });
						};
						
						btable.set({
		                    openWait: true,
		                    url: '<%=servicePath%>/disease?diseaseGroupId='+$('#dictDiseaseGroupId').val(), //地址
		                    paged:false,
							elem: '#diseaseList', //内容容器
							params: { //发送到服务端的参数
							},
							even: true,//隔行变色
					        field: 'id', //主键ID
					        checkbox: false,//是否显示多选框
							type: 'GET',
							columns:[{
				                fieldName:'疾病编码',
				                field:'code'
				            },{
				                fieldName:'疾病名称',
				                field:'name'
				            }, {
				                fieldName: '操作',
				                field: 'id',
				                format: function (val,obj) {
				                    var html = '<input type="button" value="删除" data-action="del" data-id="' + val + '" class="layui-btn layui-btn-mini layui-btn-danger" />';
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
			                                    case 'del': //删除
			                                        var name = $that.parent('td').siblings('td[data-field=name]').text();
			                                        //询问框
			                                        parent.layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
			                                        	delDiseaseGroupRelation(id,$that.parent('td').parent('tr'));
			                                        });
			                                        break;
			                                }
			                            });
			                        });
			                    });
			                },
							fail: function(msg) { //获取数据失败的回调
								parent.layer.msg(msg, { icon: 2 });
							},
							complate: function() { //完成的回调
							},
						});
						btable.render();
						   
						$('#diseaseGroupRelationadd').on('click', function (){ onEdit("添加疾病");});
			});
		</script>
</body>

</html>