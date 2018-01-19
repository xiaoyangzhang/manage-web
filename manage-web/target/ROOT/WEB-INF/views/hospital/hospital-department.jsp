<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String staticPath=request.getContextPath();
String imgUrl= (String) request.getAttribute("imgUrl");
%>
<html>

<head>
    <meta charset="utf-8">
    <title>签约科室</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=staticPath%>/static/css/btable.css" />
    <link rel="stylesheet" href="<%=staticPath%>/static/css/global.css" />
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
    <div class="layui-whole">
        <blockquote class="layui-elem-quote">
            当前位置:签约科室
        </blockquote>
        <blockquote class="layui-elem-quote">
            <a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>
            <a href="javascript:location.href=location.href;" style="float: right" id="refresh" class="layui-btn layui-btn-normal">刷新</a>
            <a href="javascript:" class="layui-btn layui-btn-small" id="add" style="float: right;">
                <i class="layui-icon">&#xe608;</i> 添加科室
            </a>
        </blockquote>
        <input type="hidden" value="${id}" id="hosId" />
        <div class="layui-whole-con">
            <table class="layui-table layui-form" >
                <thead>
                <tr>
                    <th width="30">图标</th>
                    <th width="80">科室名称</th>
                    <th width="50">科室分类</th>
                    <th>简介</th>
                    <th width="180">科室信息</th>
                    <th width="130">管理员</th>
                    <th width="50">成员信息</th>
                </tr>
                </thead>
                <tbody id="hosp-dept" >

                </tbody>
            </table>
        </div>
    </div>
<script type="text/html" id="hos-dept">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="text-align: center;">
            {{# if(item.icon!=null && item.icon.length>0) {}}
            <img height="20px" width="20px" src="{{ item.icon }}"/>
            {{# }}}
        </td>
        <td style="text-align: center;">{{ item.name }}</td>
        <td style="text-align: center;">{{ item.departmentCategory==null?"":item.departmentCategory }}</td>
        <td style="text-align: center;">{{item.summary}}</td>
        <td style="text-align: center;">
            <a href="javascript:" data-id="{{item.id}}" data-opt="view" class="layui-btn layui-btn-mini">查看</a>
            <a href="javascript:" data-id="{{item.id}}" data-opt="edit" class="layui-btn layui-btn-mini">编辑</a>
            <a href="javascript:" data-opt="view1" data-id="{{item.id}}" class="layui-btn layui-btn-mini">关联疾病</a>

        </td>
        <td style="text-align: center;">{{item.admin}}</td>
        <td style="text-align: center;">
            <a href="javascript:" data-opt="view2" data-id="{{item.id}}" class="layui-btn layui-btn-mini">查看</a>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    layui.use(['layer','laytpl'],function () {
        var laytpl=layui.laytpl,layer=layui.layer;
        //渲染页面
        $.ajax({
            url:'<%=staticPath%>/department/departmentList/'+$("#hosId").val(),
            type:'get',
            dataType:'json',
            success:function (data) {
                laytpl($('#hos-dept').html()).render(data,function (html) {
                    $('#hosp-dept').html(html);
                });
                //绑定所有编辑按钮事件
                $('#hosp-dept').children('tr').each(function() {
                    var $that = $(this);
                    $that.children('td:eq(4)').find('a[data-opt=edit]').on('click', function() {
                        var id=$(this).data("id");
                        /*layer.open({
                            type:2,
                            area:['800px','500px'],
                            shadeClose:true,
                            btn:['保存','取消'],
                            title:'编辑科室',
                            yes:function (index,layero) {
                                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                var params=iframeWin.getParams();
                                params.id=id;
                                $.ajax({
                                    type:'post',
                                    dataType:'json',
                                    data:JSON.stringify(params),
                                    contentType:'application/json',
                                    success:function (data) {
                                        if (data.code=='200') {
                                            layer.msg("修改科室成功");
                                            layer.close(index);
                                        }
                                        else
                                            layer.msg("修改科室失败");

                                    },
                                    error:function (data) {
                                        console.log("修改科室失败");
                                    }
                                });
                            },
                            cancel:function (index,layero) {
                                layer.close(index);
                            }

                        });*/
                        location.href='<%=staticPath%>/department/getDepartment/'+id;
                    });

                });
                //绑定科室查看按钮事件
                $('#hosp-dept').children('tr').each(function() {
                    var $that = $(this);
                    $that.children('td:eq(4)').children('a[data-opt=view]').on('click', function() {
                        var id=$(this).data("id");
                        location.href='<%=staticPath%>/department/to-dept-coop/get/'+id;
                    });
                });
                //绑定关联疾病按钮事件
                $('#hosp-dept').children('tr').each(function() {
                    var $that = $(this);
                    $that.children('td:eq(4)').children('a[data-opt=view1]').on('click', function() {
                        var id=$(this).data("id");
                        location.href='<%=staticPath%>/department/toDiseaseDept/'+id;
                    });
                });
                //绑定成员信息按钮事件
                $('#hosp-dept').children('tr').each(function() {
                    var $that = $(this);
                    $that.children('td:last-child').children('a[data-opt=view2]').on('click', function() {
                        var id=$(this).data("id");
                        location.href='<%=staticPath%>/department/toDeptDoctors/'+id;
                    });
                });
            },
            error:function (data) {
            }
        });
        $('#add').on('click',function () {
           location.href='<%=staticPath%>/department/toAddDepartment/'+$('#hosId').val();
        });
        /*$('#add').on('click',function () {
            layer.open({
                type:2,
                area:['800px','500px'],
                content:'/department/toAddDepartment/'+$('#hosId').val(),
                shadeClose:true,
                btn:['保存','取消'],
                title:'添加科室',
                yes:function (index,layero) {
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    var params=iframeWin.getParams();
                params.department.hospitalId=$('#hosId').val();
                    $.ajax({
                        url:'/department/addDepartment',
                        type:'post',
                        dataType:'json',
                        data:JSON.stringify(params),
                        contentType:'application/json',
                        success:function (data) {
                            if (data.code=='200') {
                                layer.msg("添加科室成功");
                                layer.close(index);
                            }
                            else
                                layer.msg("添加科室失败");

                        },
                        error:function (data) {
                        }
                    });
                },
                cancel:function (index,layero) {
                    layer.close(index);
                }
            });
        });*/

    });
</script>
</body>

</html>