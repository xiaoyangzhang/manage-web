<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
%>
<html>

<head>
    <meta charset="utf-8">
    <title>商品分类</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <style type="text/css">
        .layui-btn {height: 30px;line-height: 30px;font-size: 12px;margin-bottom: 5px;margin-left: 3px;}
    </style>
</head>

<body>
<div class="sortWrap" style="padding: 10px;">
    <c:forEach items="${classifications}" var="pro" begin="0">
        <input type="button" class="layui-btn" data-id="${pro.id}" value="${pro.title}" />
    </c:forEach>
</div>

<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="text/javascript">

    var classification = {};

    layui.use(['form','laytpl'], function() {
        var form = layui.form(), laytpl = layui.laytpl;
        $(".sortWrap").find("input[type=button]").on('click',function () {
            $(this).siblings().removeClass('layui-btn-normal');
            $(this).addClass('layui-btn-normal');
            classification = {
                id : $(this).attr('data-id'),
                title : $(this).val()
            }
        });
    });
</script>
</body>
</html>
