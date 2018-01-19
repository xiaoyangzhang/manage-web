<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
    String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>

<head>
    <meta charset="utf-8">
    <title>添加医院</title>
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
<div style="padding: 10px 5px;">

    <form class="layui-form" action="" id="hospitalForm">
        <div class="layui-form-item">
            <label class="layui-form-label">医院名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="name"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所在地:</label>
            <div class="layui-input-inline">
                <select name="dictCityIdProvince" lay-filter="province">
                    <option value="">请选择省</option>
                    <c:forEach items="${provinces}" var="province">
                        <option value="${province.id}" >${province.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="dictCityIdCity" lay-filter="city">
                    <option value="">请选择市</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院级别:</label>
            <div class="layui-input-inline">
                <select name="dictHospitalLevelId" lay-filter="level">
                    <option value="">请选择医院级别</option>
                    <c:forEach items="${hospitalLevels}" var="level">
                        <option value="${level.id}" >${level.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院分类:</label>
            <div class="layui-input-inline">
                <select name="dictHospitalCategoryId" lay-filter="category">
                    <option value="">请选择医院分类</option>
                    <c:forEach items="${categories}" var="cat">
                        <option value="${cat.id}" >${cat.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">医院图标:</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img id="head"  width="150px" height="150px">
                    <div class="site-demo-upbar">
                        <input type="file" name="file" lay-method="post"  lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="logo" value="" />
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">医院简介:</label>
            <div class="layui-input-inline">
                <textarea placeholder="请输入简介" name="summary" class="layui-textarea" style="width: 300px;height: 100px;resize: none;"></textarea>
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
    layui.use(['form','laytpl','upload','layer'], function() {
        var form = layui.form(),
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象

            layer = layui.layer,laytpl=layui.laytpl,upload=layui.upload;
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
        //2.0版本
        /*upload.render({
            elem:'#upload',
            url:'/img/upload',
            ext:'jpg|png|jpeg|gif',
            done:function (res) {
                if(res.code==200) {

                    $("img").attr("src",'/'+res.entity);
                    $('input[name=headImage]').val(res.entity);
                }else{
                    layer.msg("上传失败");
                }
            },
            error:function (res) {
                layer.msg("上传失败");
            }

        });*/
        form.on('select(province)',function (data) {
            var parentId=data.value;
            $.ajax({
                url:'<%=staticPath%>/dictPage/cities/query/'+parentId,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('select[name=dictCityIdCity]').empty();
                    laytpl($('#cityTpl').html()).render(result,function (html) {
                        $('select[name=dictCityIdCity]').append('<option value="">请选择市</option>'+html);
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
            /*getImageWidthAndHeight('upload', function (obj) {
                console.log('width:'+obj.width+'-----height:'+obj.height);
            });*/
        });

        //自定义验证规则
//        form.verify({
//            title: function(value) {
//                if(value.length < 5) {
//                    return '标题至少得5个字符啊';
//                }
//            }
//        });

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