<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
%>
<html>

<head>
    <meta charset="utf-8">
    <title>添加省份</title>
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
<%--<input type="hidden" value="${questionnaireId}" id="questionnaireId" />--%>
<div class="provinceWrap" style="padding: 10px;">
    <c:forEach items="${provinces}" var="pro" begin="1">
        <input type="button" class="layui-btn" data-id="${pro.id}" value="${pro.abbrName}" />
    </c:forEach>
</div>

<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form','laytpl'], function() {
        var form = layui.form(), laytpl = layui.laytpl;
        $(".provinceWrap").find("input[type=button]").on('click',function () {
            $(this).toggleClass("layui-btn-normal");
        });
        if(childArr.length>0){//选中已选择的二级科室
            for(var i=0;i<childArr.length;i++){
                for(var j=0;j<$('.provinceWrap').find(' input').length;j++){
                    if(childArr[i].dictCityFirstlevelId==$('.provinceWrap').find(' input').eq(j).data("id")){
                        $('.provinceWrap').find(' input').eq(j).addClass("layui-btn-normal");
                    }
                }
            }
        }

        $('.provinceWrap').find(' input').on('click',function () {
            var _this = $(this);
            if(_this.hasClass('layui-btn-normal')){
                childArr.push({
//                    questionnaireId:$("#questionnaireId").val()==undefined?0:$('#questionnaireId').val(),
                    dictCityFirstlevelId:_this.data("id"),
                    name:_this.val()
                });
            }else{
                for(var i=0;i<childArr.length;i++){
                    if(_this.data("id")==childArr[i].dictCityFirstlevelId){
                        childArr.splice(i,1)
                    }
                }
            }
        });
    });
    var childArr = [];
    if(window.parent.areaParams.length>0){
        childArr = window.parent.areaParams
    }else{
        if(window.parent.articleArea&&window.parent.articleArea.length>0){
            for(var i=0;i<window.parent.articleArea.length;i++){
                childArr.push({
//                    questionnaireId:$("#questionnaireId").val()==undefined?0:$('#questionnaireId').val(),
                    dictDepartmentId:window.parent.articleArea[i].dictCityFirstlevelId,
                    name:window.parent.articleArea[i].name
                });
            }
        }else{
            childArr = [];
        }
    }

    var getParams=function () {
        return childArr;
    }
</script>
</body>
</html>
