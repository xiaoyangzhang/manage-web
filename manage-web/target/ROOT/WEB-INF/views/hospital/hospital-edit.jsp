<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
    String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>

<head>
    <meta charset="utf-8">
    <title>编辑医院</title>
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
<div style="padding: 10px;">
    <form class="layui-form" action="" id="hospitalForm">
        <input type="hidden" id="hospitalId" value="${id}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">医院名称:</label>
            <div class="layui-input-block">
                <input type="text" name="name" value="${hospital.name}" autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所在地:</label>
            <div class="layui-input-inline">
                <select name="dictCityIdProvince" id="dictCityIdProvince" lay-filter="province">
                    <option value="">请选择省</option>
                    <c:forEach items="${provinces}" var="province">

                    <option value="${province.id}" <c:if test="${province.id==hospital.dictCityIdProvince}">selected</c:if>>${province.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="dictCityIdCity" id="dictCityIdCity" filter="city">
                    <option value="">请选择市</option>
                    <c:forEach items="${cities}" var="city">

                        <option value="${city.id}" <c:if test="${city.id==hospital.dictCityIdCity}">selected</c:if>>${city.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院级别:</label>
            <div class="layui-input-inline">
                <select name="dictHospitalLevelId" class="layui-form-select" >
                    <option value="">请选择医院级别</option>
                    <c:forEach items="${hospitalLevels}" var="level">

                        <option value="${level.id}" <c:if test="${level.id==hospital.dictHospitalLevelId}">selected</c:if>>${level.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院分类:</label>
            <div class="layui-input-inline">
                <select name="dictHospitalCategoryId" class="layui-form-select" >
                    <option value="">请选择医院分类</option>
                    <c:forEach items="${categories}" var="cat">

                        <option value="${cat.id}" <c:if test="${cat.id==hospital.dictHospitalCategoryId}">selected</c:if>>${cat.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院图标:</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <c:choose>
                        <c:when test="${hospital.logo!=null && hospital.logo.length()>0}">
                            <img id="head" src="${hospital.logo}"  width="150px" height="150px">
                        </c:when>
                        <c:otherwise>
                            <img id="head" src="../../../static/images/nopic.gif"  width="150px" height="150px">
                        </c:otherwise>
                    </c:choose>
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post"  name="file" lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="logo" value="${hospital.logo}" />
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">医院简介:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入简介" name="summary" class="layui-textarea">${hospital.summary}</textarea>
            </div>
        </div>
    </form>
</div>
<script type="text/html" id="cityTpl">
    {{# layui.each(d.list, function(index, item){ }}

        <option value="{{item.id}}">{{item.name}}</option>
    {{# }); }}
</script>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    layui.use(['laydate','laytpl','form','upload'], function() {
        var form = layui.form(),
            laydate = layui.laydate,
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象

            laytpl=layui.laytpl;
        layui.upload({
            elem:'#upload',
            url:'<%=staticPath%>/img/upload',
            ext:'jpg|png|jpeg|gif',
//            choose:function (obj) {
//                obj.preview(function (index,file,result) {
//                });
//            },
            /*before:function (input) {
                if (input.files[0].size>3145728){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                    return false ;
                }
            },*/
            success:function (res) {
//                getImageWidthAndHeight('upload', function (obj) {
//                    console.log('width:'+obj.width+'-----height:'+obj.height);
//                });
                if (res.code!=200){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                }else {
                    $("img").attr("src", res.entity);
                    $('input[name=logo]').val(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传头像失败");
            }

        });
        /*$.ajax({
           type:'get',
           dataType:'json',
           success:function (result) {
               var data=result.entity;
               laytpl($('#hospitalTpl').html()).render(data,function (html) {
                   $('#hospitalForm').html(html);
               });
           },
            error:function (result) {

            }
        });*/

        //自定义验证规则
//        form.verify({
//            title: function(value) {
//                if(value.length < 5) {
//                    return '标题至少得5个字符啊';
//                }
//            }
//        });

        //监听提交
//        form.on('submit(editDoctor)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            });
//            return false;
        //省市联动
        form.on('select(province)',function (data) {
           var parentId=data.value;
            $.ajax({
                url:'<%=staticPath%>/dictPage/cities/query/'+parentId,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('#dictCityIdCity').empty();
                    laytpl($('#cityTpl').html()).render(result,function (html) {
                        $('#dictCityIdCity').append('<option value="">请选择市</option>'+html);
                    });
                    form.render('select');
                   /* $('#dictCityIdCity').empty().append('<option value="">请选择市</option>');
                    var html="";
                    for (var i=0;i<result.list.length;i++){
                        html+='<option value="'+result.list[i].id+'">'+result.list[i].name+'</option>';
                    }
                    $('#dictCityIdCity').append(html);*/
                },
                error:function (result) {

                }
            });
        });

    });

    //获取input图片宽高和大小
    /*function getImageWidthAndHeight(id, callback) {
        var _URL = window.URL || window.webkitURL;
        $("#" + id).change(function (e) {
            var file, img;
            if ((file = this.files[0])) {
                img = new Image();
                img.onload = function () {
                    callback && callback({"width": this.width, "height": this.height, "filesize": file.size});
                };
                img.src = _URL.createObjectURL(file);
            }
        });
    }*/
    var getParams=function () {
        var params={
            name:$("input[name='name']").val(),
            dictCityIdProvince:$("select[name='dictCityIdProvince']").val(),
            dictCityIdCity:$("select[name='dictCityIdCity']").val(),
            dictHospitalLevelId:$("select[name='dictHospitalLevelId']").val(),
            dictHospitalCategoryId:$("select[name='dictHospitalCategoryId']").val(),
            logo:$("input[name='logo']").val(),
            summary:$("textarea[name='summary']").val()
        };
//        var params=$('#hospitalForm').serializeArray();
//        $.param(params);
        return params;
    }
</script>
</body>

</html>