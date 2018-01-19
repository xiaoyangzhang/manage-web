<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
%>
<html>

<head>
    <meta charset="utf-8">
    <title>添加科室分类</title>
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
<div style="padding: 10px;">
    <input type="hidden" value="${id}" id="deptId" />
        <div class="" style="margin-bottom: 10px;">
            <h2><b>选择一级科室分类</b></h2>
            <div class="layui-box" id="first">
                <c:forEach items="${list}" var="level1">
                    <input type="button" class="layui-btn layui-btn-normal" data-id="${level1.id}" name="level1" data-code="${level1.parentCode}" value="${level1.parentName}"/>
                </c:forEach>
            </div>
        </div>
        <div>
            <h2><b>选择二级科室分类</b></h2>
            <div id="second"></div>
        </div>
</div>
<%--<script type="text/html" id="firstTpl">
    {{# layui.each(d.blacklistList, function(index, item){ }}

    {{# }); }}
</script>--%>
<script type="text/html" id="secondTpl">
    {{# layui.each(d.list, function(index, item){ }}
    <input type="checkbox" lay-skin="primary" value="{{item.id}}"><span>{{item.childName}}</span>
    {{# }); }}
</script>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    layui.use(['form','laytpl'], function() {
        var form = layui.form(),laytpl=layui.laytpl;
        $('#first').children("input[type=button]").each(function (index) {
           var $that=$(this);
           $that.on('click',function () {
           var parentCode=$that.data("code");
           $that.addClass("selected").siblings().removeClass("selected");
            $.ajax({
                url:'<%=staticPath%>/dictPage/deptCats/query/'+parentCode,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('#second').empty();
                    laytpl($('#secondTpl').html()).render(result,function (html) {
                        $('#second').html(html);
                    });

                    if(childArr.length>0){//选中已选择的二级科室
                        for(var i=0;i<childArr.length;i++){
                            for(var j=0;j<$('#second input').length;j++){
                                if(childArr[i].dictDepartmentId==$('#second input').eq(j).val()){
                                    $('#second input').eq(j).prop('checked',true);
                                }
                            }
                        }
                    }

                    $('#second input').on('click',function () {
                        var _this = $(this);
                        if(_this.prop('checked')){
                            childArr.push({
                                departmentId:$('#deptId').val()==undefined?0:$('#deptId').val(),
                                dictDepartmentLevel:2,
                                dictDepartmentId:Number(_this.val()),
                                name:_this.next("span").text()
                            });
                        }else{
                            for(var i=0;i<childArr.length;i++){
                                if(Number(_this.val())==childArr[i].dictDepartmentId){
                                    childArr.splice(i,1)
                                }
                            }
                        }
                    })
                }
            });
           });
        });

    });

    var childArr = [];
    if(window.parent.params.length>0){
        childArr = window.parent.params
    }else{
        if(window.parent.dictDepts&&window.parent.dictDepts.length>0){
            for(var i=0;i<window.parent.dictDepts.length;i++){
                childArr.push({
                    departmentId:$('#deptId').val()==undefined?0:$('#deptId').val(),
                    dictDepartmentLevel:2,
                    dictDepartmentId:window.parent.dictDepts[i].id,
                    name:window.parent.dictDepts[i].childName
                });
            }
        }else{
            childArr = [];
        }
    }

    var getCheckedOnes=function () {

        return childArr;
    }
</script>
</body>

</html>