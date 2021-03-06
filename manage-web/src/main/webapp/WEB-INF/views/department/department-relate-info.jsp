﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String contextPath = request.getContextPath();
	String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>
<head>
	<meta charset="UTF-8">
	<title>签约科室详情</title>
	<link rel="stylesheet" href="<%=contextPath%>/static/plugins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="<%=contextPath%>/static/css/main.css" />
	<link rel="stylesheet" href="<%=contextPath%>/static/css/global.css" />
	<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
	<div class="layui-whole">
		<blockquote class="layui-elem-quote">当前位置:签约科室详情</blockquote>
		<blockquote class="layui-elem-quote">
			<a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>
			<a href="javascript:location.href=location.href;" style="float: right" id="refresh" class="layui-btn layui-btn-normal">刷新</a>
		</blockquote>
		<div class="layui-whole-con">
			<input type="hidden" value="${id}" id="deptId" />
			<%--基础信息--%>
			<h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>基础信息</h2>
			<table class="layui-table" style="margin:0 0 10px 0;">
				<colgroup>
					<col width="100px">
					<col>
					<col width="100px">
					<col>
					<col width="100px">
					<col width="100px">
				</colgroup>
				<tbody id="dept-info">
				</tbody>
			</table>
			<%--合作科室--%>
			<h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>合作科室</h2>
			<table class="layui-table" style="margin:0 0 10px 0;">
				<thead>
				<tr>
					<th>外院（序号）</th>
					<th>合作医院</th>
					<th>合作科室</th>
					<th>合作发起人</th>
					<th>发起时间</th>
					<th>本科室审批人</th>
					<th>本科室审批时间</th>
					<th>合作科室审批人</th>
					<th>合作科室审批时间</th>
					<th>状态</th>
				</tr>
				</thead>
				<tbody id="dept-coop-other-coo">
				</tbody>
			</table>
			<table class="layui-table" style="margin:0 0 10px 0;">
				<thead>
				<tr>
					<th>外院（序号）</th>
					<th>本科室</th>
					<th>本科室发起人</th>
					<th>发起时间</th>
					<th>合作医院</th>
					<th>合作科室</th>
					<th>合作科室审批人</th>
					<th>合作室审批时间</th>
					<th>本科室审批人</th>
					<th>本科室审批时间</th>
					<th>状态</th>
				</tr>
				</thead>
				<tbody id="dept-coop-other-ori">
				</tbody>
			</table>
			<table  class="layui-table">
				<thead>
				<tr>
					<th>本院（序号）</th>
					<th>合作医院</th>
					<th>合作科室</th>
					<th>状态</th>
				</tr>
				</thead>
				<tbody id="dept-coop-home">
				</tbody>
			</table>
			<%--科室服务设置--%>
			<h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>科室服务设置</h2>
			<table class="layui-table" style="margin:0 0 10px 0;">
				<thead>
				<tr>
					<th>序号</th>
					<th>科室服务</th>
					<th>状态</th>
					<th>更新人</th>
					<th>更新时间</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody id="deptService">
				</tbody>
			</table>

			<div>
				<form class="layui-form" id="noticeForm">
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label layui-form-label-lg">就诊须知</label>
						<div class="layui-input-inline">
							<textarea class="layui-textarea layui-inline" style="resize: none;width: 500px;height: 100px;" name="notice" ></textarea>
							<button class="layui-btn layui-btn-normal layui-btn-mini">保存</button>
							<a href="javascript:history.back(-1);" class="layui-btn layui-btn-normal  layui-btn-mini">返回</a>
						</div>
					</div>
				</form>
			</div>
			<div class="layui-box">
				<label class="layui-form-label layui-form-label-lg">科室二维码</label>
				<div class="layui-input-inline" id="qrCode">

				</div>
			</div>
		</div>
	</div>

	<!--模板-->
	<script type="text/html" id="deptTpl">
		<tr>
			<th >科室名称</th>
			<td>{{d.name}}</td>
			<th >医院名称</th>
			<td>{{d.hospital}}</td>
			<th  rowspan="2" >图标</th>
			<td rowspan="2"><div>
				{{# if(d.icon!=null && d.icon.length>0) {}}
				<img src="{{d.icon}}" width="100" height="100">
				{{# }else{}}
				<img  width="100" height="100">
				{{#}}}
			</div>
			</td>
		</tr>
		<tr>
			<th >科室分类</th>
			<td>{{d.departmentCategory}}</td>
			<th >管理员</th>
			<td>{{d.admin}}</td>
		</tr>
		<tr>
			<th >简介</th>
			<td colspan="5">{{d.summary}}</td>
		</tr>
		<tr>
			<th >科室介绍链接</th>
			<td colspan="5">{{d.exhibitUrl}}</td>
		</tr>
		<tr>
			<th >健康宣教链接</th>
			<td colspan="5">{{d.healthUrl}}</td>
		</tr>
		<tr>
			<th >典型病例链接</th>
			<td colspan="5">{{d.typicalIllUrl}}</td>
		</tr>
	</script>

	<script type="text/html" id="deptCoopOtherCooTpl">
		{{# if(d.departCoopList!=null && d.departCoopList.length>0){}}
		{{# layui.each(d.departCoopList, function(index, item){ }}
		<tr>
			<td>{{index+1}}</td>
			<td>{{ item.initiatorHospital }}</td>
			<td>{{ item.initiatorDepartment }}</td>
			<td>{{ item.initiatorDoctor }}</td>
			<td>{{item.initiatorTime}}</td>
			<td>{{item.localReviewDoctor}}</td>
			<td>{{item.localReviewTime}}</td>
			<td>{{item.initiatorReviewDoctor}}</td>
			<td>{{item.initiatorReviewTime}}</td>
			<td>{{# if(item.state==1){}}
				 待审核
				{{# }else if(item.state==2){}}
				审核通过
				{{#}else if(item.state==3){}}
				审核拒绝
				{{#}}}</td>
		</tr>
		{{# }); }}
		{{#}}}
	</script>
	<script type="text/html" id="deptCoopOtherOriTpl">
		{{# if(d.departCoopOriList!=null && d.departCoopOriList.length>0){}}
		{{# layui.each(d.departCoopOriList, function(index, item){ }}
		<tr>
			<td>{{index+1}}</td>
			<td>{{ d.name }}</td>
			<td>{{ item.initiatorDoctor }}</td>
			<td>{{item.initiatorTime}}</td>
			<td>{{item.localReviewHospital}}</td>
			<td>{{item.localReviewDept}}</td>
			<td>{{item.localReviewDoctor}}</td>
			<td>{{item.localReviewTime}}</td>
			<td>{{item.initiatorReviewDoctor}}</td>
			<td>{{item.initiatorReviewTime}}</td>
			<td>{{# if(item.state==1){}}
				待审核
				{{# }else if(item.state==2){}}
				审核通过
				{{#}else if(item.state==3){}}
				审核拒绝
				{{#}}}</td>
		</tr>
		{{# }); }}
		{{#}}}
	</script>

	<script type="text/html" id="deptCoopHomeTpl">
		{{# if(d.departCoopDTOList!=null && d.departCoopDTOList.length>0){}}
		{{# layui.each(d.departCoopDTOList, function(index, item){ }}
		<tr>
			<td>{{index+1}}</td>
			<td>{{ d.hospital }}</td>
			<td>{{ item.department }}</td>
			<td>系统默认合作关系</td>
		</tr>
		{{# }); }}
		{{#}}}
	</script>

	<script type="text/html" id="deptServiceTpl">
		<tr>
			<td>1</td>
			<td>诊后咨询(平台通用)</td>
			<td>{{d.isFree==1?'已关闭':'已开启'}}</td>
			<td>{{d.operator}}</td>
			<td>{{d.updateTime}}</td>
			<td>{{# if(d.isFree==2){}}
				<a href="javascript:" data-id="{{d.id}}" data-opt="close" data-action="close"  class="layui-btn layui-btn-mini">关闭</a>
				{{# } else{ }}
				<a href="javascript:" data-id="{{d.id}}" data-opt="open" data-action="open"  class="layui-btn layui-btn-mini">开启</a>
				{{#}}}
			</td>
		</tr>
	</script>
	<script type="text/html" id="qrCodeTpl">
		<div style="position: relative;">
			<%--<div style="position: absolute;bottom:22px;left:29px">
				<img src="<%=contextPath%>/static/images/aa.jpg">
			</div>--%>
			<img src="<%=imgUrl%>/{{d.qrCode}}">
		</div>
</script>

	<script type="text/javascript" src="<%=contextPath%>/static/plugins/layui/layui.js"></script>
	<script>
        layui.use(['laytpl','element','form','layer'],function () {
            var laytpl = layui.laytpl,element=layui.element(),form=layui.form,layer=layui.layer;
			$.ajax({
				url:'<%=contextPath%>/department/dept-coop/get/'+$("#deptId").val(),
				type:'get',
				dataType:'json',
				success:function (data) {
					data = data.entity;
					laytpl($('#deptTpl').html()).render(data,function (html) {
					    $('#dept-info').html(html);
                    });
					console.log(data.departCoopList);
					console.log(data);
					laytpl($('#deptCoopOtherCooTpl').html()).render(data,function (html) {
							$('#dept-coop-other-coo').html(html);
						});
					laytpl($('#deptCoopOtherOriTpl').html()).render(data,function (html) {
							$('#dept-coop-other-ori').html(html);
						});
					laytpl($('#deptCoopHomeTpl').html()).render(data,function (html) {
							$('#dept-coop-home').html(html);
						});
					laytpl($('#deptServiceTpl').html()).render(data,function (html) {
							$('#deptService').html(html);
						});
					laytpl($('#qrCodeTpl').html()).render(data,function (html) {
						$("#qrCode").html(html);
                    });
					$('textarea[name="notice"]').val(data.notice);
					//科室服务设置事件绑定
					$('#deptService').children('tr').each(function () {
					$(this).children('td:last-child').children('a').each(function () {
						var $that = $(this);
						var action = $that.data("action");
						var id = $that.data('id');
						$that.on('click',function () {
							switch (action){
								case "open":
									$.ajax({
										url:'<%=contextPath%>/department/deptServiceState/update',
										type:'post',
										dataType:'json',
			//							contentType:'application/json',
										data:{
											id:id,
											isFree:2
										},
										success:function (result) {
											if (result.code==200) {
												layer.msg("启用成功",{icon:1});
												location.reload();
											}
											else
												layer.msg("启用失败",{icon:2});
										},
										error:function (result) {
												layer.msg("启用失败",{icon:2});

										}
									});
									break;
								case "close":
                                    $.ajax({
                                        url:'<%=contextPath%>/department/deptServiceState/update',
                                        type:'post',
                                        dataType:'json',
                                        //							contentType:'application/json',
                                        data:{
                                            id:id,
                                            isFree:1
                                        },
                                        success:function (result) {
                                            if (result.code==200) {
                                                layer.msg("关闭成功",{icon:1});
                                                location.reload();
                                            }
                                            else
                                                layer.msg("关闭失败",{icon:2});
                                        },
                                        error:function (result) {
                                            layer.msg("关闭失败",{icon:2});

                                        }
                                    });
								    break;
							}
                        });
						});
					});
                },
				error:function (data) {
                }
			});
            $("#noticeForm").find("button").on('click',function () {
                $.ajax({
                    url:'<%=contextPath%>/department/deptNotice/update',
                    type:'post',
                    dataType:'json',
//					contentType:'application/json',
                    data:{
                        id:$("#deptId").val(),
                        notice:$('textarea').val()
                    },
                    success:function (result) {
                        if (result.code==200) {
                            layer.msg("保存成功",{icon:1});
//                            location.reload();
                        }
                        else
                            layer.msg("保存失败",{icon:2});
                    },
                    error:function (result) {
                        layer.msg("保存失败",{icon:2});

                    }
                });
            });
        });
	</script>
</body>

</html>