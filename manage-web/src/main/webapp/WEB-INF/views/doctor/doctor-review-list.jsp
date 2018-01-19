<%--
  Created by IntelliJ IDEA.
  User: zhangxiaoyang
  Date: 2017/8/7
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>审核列表</title>
    <meta charset="utf-8">
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
</head>
<body>
<div style="margin:0px; background-color: white;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form" style="">
            <%--<input type="hidden" value="${operator}" id="currOpt" />--%>
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-md">手机号</label>
                <div class="layui-input-inline">
                    <input type="text" name="mobileNumber" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="realname" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">医院名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="hospitalName" placeholder="支持模糊查询"  name="hospitalName" autocomplete="off"   class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">审核状态</label>
                <div class="layui-input-inline">
                    <select name="reviewState" lay-filter="reviewState">
                        <option value="" >全部</option>
                        <option value="1" >待审核</option>
                        <option value="2">审核通过</option>
                        <option value="3">审核拒绝</option>
                        <option value="4">审核中</option>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
                <div class="layui-form-mid layui-word-aux" style="float: right;padding:0;">
                    <button  class="layui-btn layui-btn-normal" id="releaseAll"><i class="fa" aria-hidden="true"></i> 一键释放</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;"></div>
</div>

<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >
    layui.config({
       base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','layer','jquery'],function () {
        var btable = layui.btable(),
            form = layui.form(),
            layer=layui.layer,$=layui.jquery;

        //权限设置
        if(!window.parent.setPermissions($,"doctorreview:freed")){
            $('#releaseAll').css('display','none');
        }

        btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            url: '<%=staticPath%>/doctor/doctorReviewList', //数据源地址
            pageSize: 20,//页大小
            type:'post',
            params:{
                reviewState:$('select[name=reviewState]').val()
            },
            columns:[{
                fieldName:'申请时间',
                field:'applyTime'
            },{
                fieldName:'手机号',
                field:'mobileNumber'
            },{
                fieldName:'姓名',
                field:'realname'
            },{
                fieldName:'医院名称',
                field:'hospitalName'
            },{
                fieldName:'审核状态',
                field:'state',
                format:function (val,obj) {
                    if(obj){
                        if (obj.state == 1)
                            return "待审核";
                        else if (obj.state==2)
                            return "审核通过";
                        else if (obj.state ==3)
                            return "审核拒绝";
                        else if(obj.state=4)
                            return "审核中";
                    }
                    return "";
                }
            },{
                fieldName:'审核员',
                field:'operator'
            }, {
                fieldName: '操作',
                width:35,
                field: 'id',
                format: function (val,obj) {
                    var html ="";
                    if (obj != null && obj.state==1)
                        html= '<input type="button" value="审核" data-state="'+obj.state+'" lay-filter=" review" data-action="review" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    else
                        html= '<input type="button" value="查看" data-state="'+obj.state+'"  lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    if(window.parent.setPermissions($,"doctorreview:view")){
                        return html;
                    }else{
                        return "";
                    }
                }
            }],
            even: true,//隔行变色
            field: 'id', //主键ID
            //skin: 'row',
            checkbox: false,//是否显示多选框
            paged: true, //是否显示分页
            singleSelect: false, //只允许选择一行，checkbox为true生效
            onSuccess:function ($elem) {
                $elem.children('tr').each(function () {
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        var state = $that.data('state');
                        $that.on('click', function () {
                            switch (action) {
                                case 'review'://编辑
                                    layer.open({
                                        title: '医生认证审核',
                                        type: 2,
                                        content: '<%=staticPath%>/doctor/toDoctorReview/'+id+"/"+state,
                                        area: ['800px', '500px'],
                                        shadeClose: true,
                                        btn:['关闭'],
                                        /*success:function (data) {
                                            $.ajax({
                                               url:'/doctor/changeLockStateReview',
                                               type:'post',
                                               data:JSON.stringify({
                                                   id:id,
                                                   isLock:1,
                                                   state:4
                                               }),
                                                dataType:'json',
                                                contentType:'application/json',
                                                success:function (result) {
                                                    if(result.code==200)
                                                        layer.msg("状态更新成功");
                                                    else
                                                        layer.msg("状态更新失败");
                                                },
                                                error:function (result) {
                                                    layer.msg("状态更新失败");
                                                }
                                            });
                                        },*/
                                        yes:function (index) {
//                                            location.reload(true);
                                            layer.close(index);
                                            console.log("审核");
                                            btable.get({
                                                mobileNumber:$('input[name=mobileNumber]').val(),
                                                realname:$('input[name=realname]').val(),
                                                hospitalName:$('#hospitalName').val(),
                                                reviewState:$('select[name=reviewState]').val()
                                            });
                                        },
                                        end:function (index) {
                                            console.log("审核");
                                            btable.get({
                                                mobileNumber:$('input[name=mobileNumber]').val(),
                                                realname:$('input[name=realname]').val(),
                                                hospitalName:$('#hospitalName').val(),
                                                reviewState:$('select[name=reviewState]').val()
                                            });
                                        }
                                    });
                                    break;
                                case 'view': //详情
                                    layer.open({
                                        title: '医生认证信息',
                                        type: 2,
                                        content: '<%=staticPath%>/doctor/toDoctorReview/'+id+"/"+state,
                                        area: ['800px', '500px'],
                                        shadeClose: true,
                                        btn:['关闭'],
                                        yes:function (index) {
//                                            location.reload(true);
                                            layer.close(index);
//                                            console.log("查看");
                                            btable.get({
                                                mobileNumber:$('input[name=mobileNumber]').val(),
                                                realname:$('input[name=realname]').val(),
                                                hospitalName:$('#hospitalName').val(),
                                                reviewState:$('select[name=reviewState]').val()
                                            });

                                        }
                                    });
                                    break;
                            }
                        });
                    });
                });
            }
        });
        btable.render();
        //监听搜索表单的提交事件
        form.on('submit(search)', function (data) {
            btable.get(data.field);
            return false;
        });
        $(window).on('resize', function (e) {
            var $that = $(this);
            $('#content').height($that.height() - 92);
        }).resize();
    $("#releaseAll").on("click",function () {
        $.ajax({
            url:'<%=staticPath%>/doctor/releaseTask',
            type:'post',
            dataType:'json',
//            data:{
//                operator:$("#currOpt").val()
//            },
            success:function (data) {
                if (data.code=='200'){

                    layui.layer.msg("释放成功");
                    location.reload(true);
                }
                else
                    layui.layer.msg("释放失败");

            },
            error:function (data) {
                console.log("释放失败");
            }
        });
    });
    });

</script>
</body>
</html>
