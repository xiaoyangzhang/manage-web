<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
%>
<html>

<head>
    <meta charset="utf-8">
    <title>创建商品-添加科室</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <style type="text/css">
        .layui-btn {height: 30px;line-height: 30px;font-size: 12px;margin-bottom: 5px;margin-left: 3px;}
    </style>
</head>

<body>
<div class="departmentWrap" style="padding: 10px;">
    <c:forEach items="${deptCategories}" var="dept" begin="0">
        <input type="button" class="layui-btn" data-id="${dept.id}" value="${dept.name}" />
    </c:forEach>
</div>

<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="text/javascript">
    var department = {};
    layui.use(['form','laytpl'], function() {
        var form = layui.form(), laytpl = layui.laytpl;

        $(".departmentWrap").find("input[type=button]").on('click',function () {
            $(".departmentWrap").find("input[type=button]").removeClass('layui-btn-normal');
            $(this).addClass('layui-btn-normal');
            department = {
                id : $(this).attr('data-id'),
                title : $(this).val()
            }
        });
    });
</script>
</body>
</html>
