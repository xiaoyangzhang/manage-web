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
	<div style="margin: 0px; background-color: white; margin: 0 10px;">
		<blockquote class="layui-elem-quote">
			<form class="layui-form-item" action="<%=servicePath%>/diseaseGroupRelation/add" style="margin: 0;" id="diseaseGroupRelationForm" name="diseaseGroupRelationForm">
				<input type="hidden" name="diseaseGroupId" id="diseaseGroupId" value="${diseaseGroupRelation.dictDiseaseGroupId }">
				<button lay-filter="diseaseRelationSubmit" lay-submit style="display: none;"></button>
				<label class="layui-form-mid">编码</label>
				<div class="layui-input-inline">
					<input type="text" name="code" 
						autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-mid">名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name"
						autocomplete="off" class="layui-input">
				</div>
				<a href="javascript:" class="layui-btn layui-btn-small" id="diseasesearch">
					<i class="layui-icon">&#xe615;</i> 搜索
				</a>
			</form>
		</blockquote>
		<div class="layui-field-box layui-form" id="diseaseFormList"></div>
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
					
					var getSelected = function (){
						btable.getSelections(function(data){
							for(var index = 0; index<data.ids.length;index++){
									/* if($("#diseaseIds").val().length>0){
										$("#diseaseIds").val($("#diseaseIds").val()+","+params.id);
									}else{
										$("#diseaseIds").val(params.id);
									} */
									var input = $("<input type='hidden' name='diseaseIds' value='"+data.ids[index]+"' />");
									$("#diseaseGroupRelationForm").append(input);
							}
						});
						return true;
					};
					
					//监听提交
					form.on('submit(diseaseRelationSubmit)', function(data) {
						if(getSelected()){
							$("#diseaseGroupRelationForm").ajaxSubmit({
								 	type:'post',      
					                success:function(data){    //成功执行的方法  
					                	if(data.msg){
					                		parent.layer.alert(data.msg);
					                	}
					                	btable.get();
					                	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					                	parent.layer.close(index);
					                }
							});
						}
						return false;
					});
					
					//var layer = layui.layer;
				btable.set({
                    openWait: true,
                    url: '<%=servicePath%>/diseaseGroupRelation/disease/page/'+$("#diseaseGroupId").val(),
                    paged:true,
                    pageSize:5,
					elem: '#diseaseFormList', //内容容器
					params: {code: $("#diseaseGroupRelationForm").find('input[name=code]').val(),
						name: $("#diseaseGroupRelationForm").find('input[name=name]').val()},
					even: true,//隔行变色
			        field: 'id', //主键ID
			        checkbox: true,//是否显示多选框
			        singleSelect:false,
					type: 'GET',
					columns:[{
		                fieldName:'编码',
		                field:'code'
		            },{
		                fieldName:'名称',
		                field:'name'
		            }],
					fail: function(msg) { //获取数据失败的回调
						parent.layer.msg(msg, { icon: 2 });
					},
					complate: function() { //完成的回调
					}
				});
				btable.render();

				$('#diseasesearch').on('click', function() {
					 btable.get({
						 	code: $("#diseaseGroupRelationForm").find('input[name=code]').val(),
							name: $("#diseaseGroupRelationForm").find('input[name=name]').val()
		                });
				}); 
			});
		</script>
	</body>

</html>