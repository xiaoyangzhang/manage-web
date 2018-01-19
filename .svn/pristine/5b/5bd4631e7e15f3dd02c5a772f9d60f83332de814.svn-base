<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	String servicePath = gateWay+"/patient";
%>
<!DOCTYPE html>
<html>
<%@include file="../top.jsp"%>
<body>
	<div style="margin: 0px; background-color: white;">
		<blockquote class="layui-elem-quote">
			<form class="layui-form" style="margin: 0;" name="complaintQueryForm" id="complaintQueryForm">
				<div class="layui-form-item" style="margin: 0;">
					<label class="layui-form-label layui-form-label-lg">医院名称</label>
					<div class="layui-input-inline">
						<input type="text" name="hospitalName" autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label layui-form-label-lg">科室名称</label>
					<div class="layui-input-inline">
						<input type="text" name="departmentName" autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label layui-form-label-lg">患者用户名</label>
					<div class="layui-input-inline">
						<input type="text" name="patientName" autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label layui-form-label-lg">提交时间</label>
					<div class="layui-input-inline">
						<input type="text" placeholder="yyyy-mm-dd" id="startDate" name="startDate" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline">
						<input type="text" placeholder="yyyy-mm-dd" id="endDate" name="endDate" autocomplete="off" class="layui-input" >
					</div>
					<div class="layui-form-mid layui-word-aux" style="padding:0;">
						<button lay-filter="search" class="layui-btn" lay-submit>
							<i class="fa fa-search" aria-hidden="true"></i> 查询</button>
					</div>
				</div>
			</form>
		</blockquote>
		<div class="layui-form" id="complaintList"></div>
	</div>
	<script type="text/javascript">

			layui.config({
				base: '<%=contextPath%>/static/js/'
			});

			layui.use(['btable','jquery','jquery_form','form','laydate'], function() {
				var $ = layui.jquery;
				var $ = layui.jquery_form($);
				var	btable = layui.btable(),form=layui.form(),
					layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
					layer = layui.layer, //获取当前窗口的layer对象
					laydate = layui.laydate;

					var startDate={
			           min: laydate.now(),
			           max: '2099-6-16 23:59:59',
			            istoday:false,
			            choose:function (datas) {
			                end.min=datas;
			                end.start=datas
			            }
			        };
			         var endDate={
			           min: laydate.now(),
			           max: '2099-6-16 23:59:59',
			            istoday:false,
			            choose:function (datas) {
			                start.max=datas;
			            }
			        };

			         $("#startDate").on('click',function () {
			        	 startDate.elem=this;
			              laydate(startDate);
			         });

			        $("#endDate").on('click',function () {
			        	endDate.elem=this;
			              laydate(endDate);
			         });

			        //赠送咨询卡
				var handle = function(id){
					$.ajax({
		                type: "POST",
		                url: "<%=servicePath%>/complaint/serviceCard/"+id,
		                success: function (obj) {
		                    if(obj.msg){
		                    	layer.alert(data.msg);
		                    }else{
		                    	btable.get();
		                    }
		                },
		                error: function(data) {
		                	layer.alert("该订单已经赠送过,不能再赠");
		                	btable.get();
		                }
		            });
				};

				var addBoxIndex = -1;
				var con = '<div style="margin: 15px;"><div class="layui-form" name="complaintForm" id="complaintForm"><div class="layui-input-inline"><textarea name="description" placeholder="1-200字" class="layui-textarea"></textarea></div></div></div>';
                var onEdit = function(id){
					//本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
					if(addBoxIndex !== -1)
							return;
	                layer.open({
	                    type: 1,
	                    title: "请输入处理结果",
	                    content: con,
	                    btn: ['确定', '取消'],
	                    area: ['320px', '280px'],
	                    yes: function (index, layero) {
	                        //这是核心的代码。
	                        	$.ajax({
						                type: "POST",
						                url: "<%=servicePath%>/complaint/dispose/"+id,
						                dataType : 'json',
						                data:{id:id,
						                	description:$(layero).find('textarea[name=description]').val()
						                },
						                success: function (obj) {
						                    if(obj.msg){
						                    	layer.alert(data.msg);
						                    }else{
						                    	btable.get();
						                    	layer.close(index);
						                    }
						                },
						                error: function(data) {
						                	layer.alert("订单已经处理过了");
						                	btable.get();
						                }
						            });
	                    },
	                    success: function(layero, index) {
	                    },
	                    shade: false,
	                    maxmin: true
	                });
				};

				btable.set({
                    openWait: true,
                    url: '<%=servicePath%>/complaint/page', //地址
                    paged:true,
					elem: '#complaintList', //内容容器
//					params: { //发送到服务端的参数
//						 hospitalName:$("#complaintQueryForm").find('input[name=hospitalName]').val(),
//						 departmentName:$("#complaintQueryForm").find('input[name=departmentName]').val(),
//						 patientName:$("#complaintQueryForm").find('input[name=patientName]').val(),
//						 startDate:$("#complaintQueryForm").find('input[name=startDate]').val(),
//						 endDate:$("#complaintQueryForm").find('input[name=endDate]').val()
//					},
					even: true,//隔行变色
			        field: 'id', //主键ID
			        checkbox: false,//是否显示多选框
					type: 'GET',
					pageSize:20,
					columns:[{
		                fieldName:'提交时间',
		                field:'createTime'
		            },{
		                fieldName:'医疗机构',
		                field:'hospitalName'
		            },{
		                fieldName:'用户',
		                field:'patientName'
		            },{
		                fieldName:'投诉内容',
		                field:'content'
		            },{
		                fieldName:'服务订单号',
		                field:'orderNo'
		            },{
		            	fieldName: '关联对话',
		                field: 'id',
		                format: function (val,obj) {
		                	var value = '';
		                	if(obj&&obj.userId){
		                		value = obj.orderNo;
		                	}
							return '<input type="button" value="查看" data-action="sendMsg" data-id="' + value + '" class="layui-btn layui-btn-mini" />';
		                }
		            },{
		                fieldName: '处理结果',
		                field: 'description'
		            }, {
		                fieldName: '操作',
		                field: 'isGive',
		                format: function (val,obj) {
		                	var html = "";
		                	if(obj&&obj.isGive&&obj.isGive==2){
		                		html ='<input type="button" class="layui-btn layui-btn-mini layui-btn-disabled" value="已赠送"/>';
		                	}else{
		                		html = '<input type="button" value="赠送一次诊后咨询" data-action="sendServiceCard" data-id="' + val + '" class="layui-btn layui-btn-mini" />';
		                	}
		                	if(obj&&obj.state&&obj.state==2){
		                		html = html+ '<input type="button" class="layui-btn layui-btn-mini layui-btn-disabled" value="已处理"/>';
		                	}else{
		                		html = html+ '<input type="button" data-action="handle"  data-id="' + val + '" class="layui-btn layui-btn-mini" " value="未处理" />';
		                	}
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
	                                    case 'sendMsg':
	                                        //onEdit("发送消息",id)
	                                        break;
	                                    case 'sendServiceCard':
	                                    	handle(id);
	                                        break;
	                                    case 'handle':
	                                    	onEdit(id);
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
				/*$('#complaintsearch').on('click', function() {
					 btable.get({
						 hospitalName:$("#complaintQueryForm").find('input[name=hospitalName]').val(),
						 departmentName:$("#complaintQueryForm").find('input[name=departmentName]').val(),
						 patientName:$("#complaintQueryForm").find('input[name=patientName]').val(),
						 startDate:$("#complaintQueryForm").find('input[name=startDate]').val(),
						 endDate:$("#complaintQueryForm").find('input[name=endDate]').val()
		                });
				});*/
                form.on('submit(search)', function(data) {
                    btable.get(data.field);
                    return false;
                });
            });
		</script>
</body>

</html>