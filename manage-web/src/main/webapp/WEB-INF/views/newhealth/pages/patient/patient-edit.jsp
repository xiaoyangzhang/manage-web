<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String staticPath=request.getContextPath();
//    String imgUrl=(String) request.getSession().getAttribute("imgUrl");
    String imgUrl=(String) request.getAttribute("imgUrl");
%>
<html>

<head>
    <meta charset="utf-8">
    <title>编辑患者用户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
</head>

<body>
<div style="margin: 10px 0;">

    <form class="layui-form" id="patientForm" action="">
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">手机号</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" value="${patient.username}" disabled>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">头像</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img id="head" <c:if test="${patient.headImage!=null && patient.headImage.length()>0}">src='${patient.headImage}'</c:if>  width="150px" height="150px">
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post" name="file" lay-title="请上传小于3M的图片" lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="headImage" value="${patient.headImage}" />
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="realname" value="${patient.realname}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="1" title="男" <c:if test="${patient.sex==1}"> checked="checked"</c:if>>
                <input type="radio" name="sex" value="2" title="女" <c:if test="${patient.sex==2}"> checked="checked"</c:if>>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label layui-form-label-lg">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" id="date" value='${patient.birthday}' lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">身份证号</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" value="${patient.idno}" name="idno">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    var depts='${departments}';
    layui.use(['form', 'laydate','layer','laytpl','upload'], function() {
        var form = layui.form(),
            laydate = layui.laydate,upload=layui.upload,
            layer=layui.layer,laytpl=layui.laytpl,
        layerTips = parent.layer === undefined ? layui.layer : parent.layer;//获取父窗口的layer对象

        layui.upload({
            elem:'#upload',
            url:'<%=staticPath%>/img/upload',
            ext:'jpg|png|jpeg|gif',
            method:"post",
            success:function (res) {
                if (res.code!=200){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                }else {
                    $("img").attr("src", res.entity);
                    $('input[name=headImage]').val(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传头像失败",{icon:2});
            }

        });
    });

    var getParams=function () {

        var params={
            realname:$("input[name='realname']").val(),
            sex:$("input[name='sex']:checked").val(),
            birthday:$("input[name='birthday']").val(),
            headImage:$("input[name='headImage']").val(),
            idno:$("input[name='idno']").val()
        };
        return params;
    }
</script>
</body>

</html>