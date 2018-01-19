<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>医略－参与课题审核列表</title>
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
<div style="background-color: white; margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-md">标题</label>
                <div class="layui-input-inline">
                    <input type="text" name="username" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">状态</label>
                <div class="layui-input-inline">
                    <select id="type" name="quiz1">
                        <option value="">请选择状态</option>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;">
    </div>
</div>

<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="application/javascript">
    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','tab','layer','element','laydate','jquery'],function () {
        var btable = layui.btable(),
                form = layui.form(),
                layer=layui.layer,
                element = layui.element(),$=layui.jquery;

        btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            url: '', //数据源地址
            pageSize: 20,//页大小
            type:'post',
            columns:[
                {
                    fieldName:'标题',
                    field:''
                },
                {
                    fieldName:'发布对象',
                    field:''
                },
                {
                    fieldName:'发布地区',
                    field:''
                },
                {
                    fieldName:'置顶',
                    field:''
                },
                {
                    fieldName:'更新时间',
                    field:''
                },
                {
                    fieldName:'注册时间',
                    field:'createTime'
                },
                {
                    fieldName:'审核通过时间',
                    field:''
                },
                {
                    fieldName:'上架时间',
                    field:''
                },
                {
                    fieldName:'下架时间',
                    field:''
                },
                {
                    fieldName:'点击量',
                    field:''
                },
                {
                    fieldName:'状态',
                    field:''
                },
                {
                    fieldName: '操作',
                    width:85
                }
            ],
            even: true,//隔行变色
            field: 'id', //主键ID
            checkbox: false,//是否显示多选框
            paged: true, //是否显示分页
            singleSelect: false, //只允许选择一行，checkbox为true生效
            onSuccess:function ($elem) {
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
    });
</script>
</body>
</html>