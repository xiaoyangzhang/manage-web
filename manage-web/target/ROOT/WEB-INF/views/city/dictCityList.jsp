<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String gateWay = (String) request.getAttribute("gateWay");
	System.out.println(gateWay);
	String servicePath = gateWay + "/system";
%>
<!DOCTYPE html>
<html>
<title>城市维护</title>
<%@include file="../top.jsp"%>
<body>
	<div style="margin: 0px; background-color: white;">
		<blockquote class="layui-elem-quote" style="float: right">
			<a href="javascript:" class="layui-btn layui-btn-small" id="add">
				<i class="layui-icon">&#xe608;</i> 添加根城市
			</a> <!-- <a href="javascript:" class="layui-btn layui-btn-small"
				id="addChild"> <i class="layui-icon">&#xe608;</i> 添加子城市
			</a> -->
		</blockquote>
		<div class="layui-form">
			<table class="layui-table admin-table">
				<thead>
					<tr>
						<th>城市名称</th>
						<th>城市简称</th>
						<th>城市全拼</th>
						<th>城市简拼</th>
						<th>城市编码</th>
						<th>是否主要城市</th>
						<th>映射编码</th>
						<th>序号</th>
						<th>地区级别</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="content">
				</tbody>
			</table>
		</div>
	</div>
	<!--模板-->
	<script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-parent="{{item.parentId}}" data-id="{{item.id}}" data-name="{{ item.name }}" data-havChild="{{ item.havChild }}" data-spread="false">
				<td data-id="{{ item.id }}" >
					{{# if(item.havChild&&item.havChild>0){ }}
						<a href="javascript:" onclick="openChild(this,'{{item.id}}');">
							<i class="layui-icon layui-tree-spread">+</i>
						</a>
						<cite>{{ item.name }}</cite></a>
					{{# }else{ }}
						<span class="layui-icon layui-tree-leaf">&nbsp;&nbsp;</span>
						<cite>{{ item.name }}</cite>
					{{# } }}
			<!--打开样式 <a href="javascript:;"><i class="layui-icon layui-tree-spread"></i>
					<i class="layui-icon layui-tree-branch"></i>
					<cite>{{ item.name }}</cite></a>-->
				</td>
				<td>{{ item.abbrName }}</td>
				<td>{{ item.fullSpell }}</td>
				<td>{{ item.abbrSpell }}</td>
				<td>{{ item.cityCode }}</td>
				<td>{{# if(item.isMainCity&&item.isMainCity==1){ }}
					{{ "是" }}
					{{# }else{ }}
					{{ "否" }}
					{{# } }}
				</td>
				<td>{{ item.mappingCode }}</td>
				<td>{{ item.sortNo==null?"":item.sortNo }}</td>
				<td>{{ item.regionLevel }}</td>
				<td>
					<a href="javascript:" data-id="{{ item.id }}" data-opt="edit" class="layui-btn layui-btn-mini">添加子城市</a>
					<a href="javascript:" data-id="{{ item.id }}" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
				</td><!---->
			</tr>
			{{# }); }}
			
		</script>
	<script type="text/javascript">
			layui.config({
				base: '<%=contextPath%>/static/js/'
			});
			var $ = layui.jquery;
			var addChildCity = null;
			var del = null;
			var layerTips = null;
			
			
			function spread(tr){
				var after = $(tr).next();
				if(after){
					var id = tr.attr("data-id");
	    			var parentId = after.attr("data-parent");
	       			while(id==parentId){
	       				//after.hide();
	       				if("true"==(tr.attr("data-spread"))){
	       					after.show(); 
	       				}
	       				after = spread(after);
	       				parentId = after.attr("data-parent");
	       			}
	       			return after;
				}
    		}
			
			function closed(tr){
				var after = $(tr).next();
				if(after){
					var id = $(tr).attr("data-id");
	    			var parentId = after.attr("data-parent");
	       			while(id==parentId){
	       				//after.hide();
	       				after.hide(); 
	    				after = closed(after);
	        			parentId = after.attr("data-parent");
	       			}
	       			return after;
				}
    		}
			
			function openChild(elem,id){
				var tr = $(elem).parent().parent();
        		if("false"==($(tr).attr("data-spread"))){
        			$(tr).attr("data-spread","true");
        			$(elem).empty();
        			$(elem).prepend('<i class="layui-icon layui-tree-spread">-</i>');
        			
        			var after = $(tr).next();
        			var parentId = after.attr("data-parent");
        			if(id==parentId){
        				spread($(tr));

        			}else{
        				$.ajax({
        	                type: "GET",
        	                url: "<%=servicePath%>/city/",
        	                dataType : 'json',
        	                data:{parentId:id},
        	                success: function (obj) {
        	                    if(obj.msg){
        	                    	layer.alert(data.msg);
        	                    }else{
        	                      	layui.each(obj, function(index, item){
        	                    		var html = '<tr data-parent="'+item.parentId+'" data-havChild="'+item.havChild+'" data-id="'+item.id+'"  data-name="'+item.name+'" data-spread="false"><td  data-id="'+item.id+'" >';
        	                    		if(item.havChild&&item.havChild>0){
        	                    			html = html +'<a href="javascript:" onclick="openChild(this,\''+item.id+'\');">'+'<i class="layui-icon layui-tree-spread">+</i></a>';
        	                    		}else{
        	                    			html = html + '<span width="'+60*(item.level-1)+'px;">&nbsp;&nbsp;</span>';
        	                    		}
        	                    		var isMainCity = "否";
                                        if (item.isMainCity && item.isMainCity == 1) {
                                            isMainCity = "是"
                                        }
                                        html = html+'<cite>'+item.name+'</cite></a></td><td>'+item.abbrName +'</td><td>'+item.fullSpell +'</td><td>'+item.abbrSpell
        	                    			+'</td><td>'+item.cityCode +'</td><td>'+ isMainCity +'</td><td>'+item.mappingCode +'</td><td>'+item.sortNo 
        	                    			+'</td><td>'+item.regionLevel +'</td>'
        	                    			+'<td><a href="javascript:;" data-id="'+item.id+'" data-opt="edit" class="layui-btn layui-btn-mini">添加子城市</a>'
        	            					+'<a href="javascript:;" data-id="'+item.id+'" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a></td>';
        	            				
        	            				$(tr).after(html);
        	                    		//绑定所有编辑按钮事件
        	                    		//console.log($(tr).next().prop("outerHTML"));
        	                    		//console.log($(tr).next().children('td:last-child').prop("outerHTML"));
        	                    		var id = $(tr).next().data('id');
        	                    		
        	                    		$(tr).next().children('td:last-child').children('a[data-opt=edit]').on('click', function() {
	        	           					 addChildCity(id,$(tr).next());
	        	           				});
        	                    		var name =  $(tr).next().data('name');
        	                    		$(tr).next().children('td:last-child').children('a[data-opt=del]').on('click', function() {
	        	                               layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
	        	                                   del(id,$(tr).next());
	        	                               });
	        	           				}); 
    	    						});
        	                    }
        	                },
        	                error: function(data) {
        	                	layer.alert(data.msg);
        	                }
        	            });
        			}
        		}else{
        			$(tr).attr("data-spread","false");
        			$(elem).empty();
        			$(elem).prepend('<i class="layui-icon layui-tree-spread">+</i>');
        			closed($(tr));
        		}
			}
			
			//后期代码整合
			function addChild(item,tr){
				var html = '<tr data-parent="'+item.parentId+'" data-havChild="'+item.havChild+'" data-id="'+item.id+'"  data-name="'+item.name+'" data-spread="false"><td  data-id="'+item.id+'" >';
        		if(item.havChild&&item.havChild>0){
        			html = html +'<a href="javascript:" onclick="openChild(this,\''+item.id+'\');">'+'<i class="layui-icon layui-tree-spread">+</i></a>';
        		}else{
        			html = html + '<span width="'+60*(item.level-1)+'px;">&nbsp;&nbsp;</span>';
        		}
        		var isMainCity = "否";
                if (item.isMainCity && item.isMainCity == 1) {
                    isMainCity = "是"
                }
                html = html+'<cite>'+item.name+'</cite></a></td><td>'+item.abbrName +'</td><td>'+item.fullSpell +'</td><td>'+item.abbrSpell
        			+'</td><td>'+item.cityCode +'</td><td>'+ isMainCity +'</td><td>'+item.mappingCode +'</td><td>'+item.sortNo 
        			+'</td><td>'+item.regionLevel +'</td>'
        			+'<td><a href="javascript:;" data-id="'+item.id+'" data-opt="edit" class="layui-btn layui-btn-mini">添加子城市</a>'
					+'<a href="javascript:;" data-id="'+item.id+'" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a></td>';
				
				$(tr).after(html);
				$(tr).attr("data-spread","true");
				var td = $(tr).children('td:first-child');
				var span = td.children('span:first-child');
				span.after('<a href="javascript:" onclick="openChild(this,\''+$(tr).data('id')+'\');">'+'<i class="layui-icon layui-tree-spread">-</i></a>');
        		//绑定所有编辑按钮事件
        		console.log($(tr).next().prop("outerHTML"));
        		console.log($(tr).next().children('td:last-child').prop("outerHTML"));
        		var id = $(tr).next().data('id');
				$(tr).next().children('td:last-child').children('a[data-opt=edit]').on('click', function() {
					 addChildCity(id,$(tr).next());
				});
				$(tr).next().children('td:last-child').children('a[data-opt=del]').on('click', function() {
                    layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
                        del(id,$(tr).next());
                    });
				});
			}
			
			layui.use(['jquery','paging', 'form','jquery_form'], function() {
				 	$ = layui.jquery_form(layui.jquery);
				 	layerTips = parent.layer === undefined ? layui.layer : parent.layer; //获取父窗口的layer对象
					var paging = layui.paging(),
					layer = layui.layer, //获取当前窗口的layer对象
					form = layui.form();

                paging.init({
                    openWait: true,
                    url: '<%=servicePath%>/city/',
					elem: '#content', //内容容器
					params: { //发送到服务端的参数
						level:1
					},
					type: 'GET',
					tempElem: '#tpl', //模块容器
					paged:false,
					complate: function() { //完成的回调
						//绑定所有编辑按钮事件						
						$('#content').children('tr').each(function() {
							var $that = $(this);
							var id = $that.data('id');
							var name = $that.data('name');
							$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
	                        	addChildCity(id,$that);
							});
							$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
	                            layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
	                                del(id,$that);
	                            });
							}); 
						});
					}
				});

				var addBoxIndex = -1;
				$('#add').on('click', function() {
					if(addBoxIndex !== -1) return;
					//本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
					$.get('<%=contextPath%>/cityPage/toAddCity?level=1', null, function(form) {
						addBoxIndex = layer.open({
							type: 1,
							title: '添加根城市',
							content: form,
							btn: ['保存', '取消'],
							shade: false,
							offset: ['100px', '30%'],
							area: ['600px', '400px'],
							zIndex: 19950924,
							maxmin: true,
							yes: function(index) {
								//触发表单的提交事件
								$('form.layui-form').find('button[lay-filter=citySubmit]').click();
							},
							full: function(elem) {
								var win = window.top === window.self ? window : parent.window;
								$(win).on('resize', function() {
									var $this = $(this);
									elem.width($this.width()).height($this.height()).css({
										top: 0,
										left: 0
									});
									elem.children('div.layui-layer-content').height($this.height() - 95);
								});
							},
							success: function(layero, index) {
								//弹出窗口成功后渲染表单
								var form = layui.form();
								form.render();
								form.on('submit(citySubmit)', function(data) {
									$("#dictCityForm").ajaxSubmit({
									 	type:'post',      
						                success:function(data)
						                {   //成功执行的方法
						                	if(data.msg){
						                		layer.alert(data.msg);
						                	}else{
						                		addChild(data,$('#content').children('tr:last'));
						                	}
						                	//btable.get();
						                	layer.close(index);
						                }     
									});
									return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。									
								});
							},
							end: function() {
								addBoxIndex = -1;
							}
						});
					});
				});

				addChildCity = function(parentId,tr) {
					if(addBoxIndex !== -1) return;
					var that = this;
                    $.get('<%=contextPath%>/cityPage/toAddCity?parentId='+parentId, null, function(form) {
                        addBoxIndex = layer.open({
                            type: 1,
                            title: '添加子城市',
                            content: form,
                            btn: ['保存', '取消'],
                            shade: false,
                            offset: ['100px', '30%'],
                            area: ['600px', '400px'],
                            zIndex: 19950924,
                            maxmin: true,
                            yes: function(index) {
                                //触发表单的提交事件
                                $('form.layui-form').find('button[lay-filter=citySubmit]').click();
                            },
                            full: function(elem) {
                                var win = window.top === window.self ? window : parent.window;
                                $(win).on('resize', function() {
                                    var $this = $(this);
                                    elem.width($this.width()).height($this.height()).css({
                                        top: 0,
                                        left: 0
                                    });
                                    elem.children('div.layui-layer-content').height($this.height() - 95);
                                });
                            },
                            success: function(layero, index) {
                                //弹出窗口成功后渲染表单
                                var form = layui.form();
                                form.render();
                                form.on('submit(citySubmit)', function(data) {
                                	$("#dictCityForm").ajaxSubmit({
									 	type:'post',      
						                success:function(data)
						                {   //成功执行的方法
						                	if(data.msg){
						                		layer.alert(data.msg);
						                	}else{
						                		addChild(data, tr);
						                	}
						                	//btable.get();
						                	layer.close(index);
						                }     
									});
                                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                                });
                            },
                            end: function() {
                                addBoxIndex = -1;
                            }
                        });
                    });
				};
			del = function(id,tr){
				$.ajax({
	                type: "POST",
	                url: "<%=servicePath%>/city/delete/"+id,
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
		});
		</script>
</body>

</html>