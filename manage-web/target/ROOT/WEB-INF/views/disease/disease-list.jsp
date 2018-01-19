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
<!DOCTYPE html PUBLIC "-//W3C//DTDHTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>疾病列表</title>
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
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>

<div style="margin:0px; background-color: white;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form" style="">
            <input type="hidden" id="doctorId" value="${id}" />
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label">疾病名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>

                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search1" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>

        </form>
    </blockquote>
    <div id="diseaseList" style="width: 100%;height: 90%;"></div>
</div>


<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >

    layui.config({
       base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','tab','layer','element'],function () {
        var btable = layui.btable(),
            form = layui.form(),
            layer=layui.layer,
            element = layui.element();


        btable.set({
            openWait: true,//开启等待框
            elem: '#diseaseList',
            url: '<%=staticPath%>/department/diseaseList', //数据源地址
            pageSize: 20,//页大小
            params:{
                name:$('input[name="name"]').val(),
                doctorId:$("#doctorId").val()
            },
            type:'post',
            columns:[{
                fieldName:'疾病名',
                field:'name'
            }, {
                fieldName: '操作',
                width:40,
                field: 'id',//疾病 id
                format: function (val,obj) {
                    var html="";
                    if(obj==null || obj==undefined)
                        return "";
                    else if(!obj.flag)
                        html = '<input type="button" value="添加" lay-filter="add" data-action="add" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    else
//                        html = '<input type="button" vyialue="添加" lay-filter="add" data-action="add" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                        html+="已添加";
                    return html;
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
                        $that.on('click', function () {
                            var isExist=window.parent.document.getElementById('addedFrame').contentWindow.isExistDeptDiseaseId(id);
                            if (!isExist)
                                layer.msg("该疾病已存在添加列表中，不能重复添加");
                            else {
                                $.ajax({
                                    url: '<%=staticPath%>/doctor/addDisease2Doctor/' + id + '/' + $("#doctorId").val(),
                                    type: "get",
                                    dataType: 'json',
//                                contentType:'application/json',
                                    success: function (result) {
                                        if (result.code == 200) {
                                            layer.msg("添加成功");
                                            $that.unbind("click").removeClass("layui-btn-mini").removeClass("layui-btn").val("已添加");
                                            window.parent.document.getElementById('addedFrame').contentWindow.refreshAdded();

                                        }
                                        else
                                            layer.msg("添加失败")
                                    },
                                    error: function (result) {
                                        layer.msg("添加失败")
                                    }
                                });
                            }
                        });
                    });
                });
            }
        });
        btable.render();

        //监听搜索表单的提交事件
        form.on('submit(search1)', function (data) {
            data.field.doctorId=$("#doctorId").val();
            btable.get(data.field);
            return false;
        });
        $(window).on('resize', function (e) {
            var $that = $(this);
            $('#content').height($that.height() - 92);
        }).resize();


    });
    function refreshAdded() {
        window.location.reload();
    }
</script>
</body>
</html>

