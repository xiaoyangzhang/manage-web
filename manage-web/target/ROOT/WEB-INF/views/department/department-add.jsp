<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
    String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>

<head>
    <meta charset="utf-8">
    <title>添加科室</title>
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
    body,html{font-size: 12px;}
    .layui-btn {height: 30px;line-height: 30px;font-size: 12px;  }
    </style>
</head>

<body>
<div style="padding: 10px;" id="deptDiv">
<blockquote class="layui-elem-quote">
    <a href="javascript:history.back(-1);"  class="layui-btn layui-btn-normal">返回</a>
</blockquote>
    <form class="layui-form" action="" id="departmentForm">
        <input type="hidden" id="hosId" value="${hospitalId}" />
        <div class="layui-form-item">
            <label class="layui-form-label">科室名称:</label>
            <div class="layui-input-block">
                <input type="text" name="name"  autocomplete="off" class="layui-input">

            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">科室分类:</label>
            <div class="layui-input-block" id="category">
                <input type="button" value="添加分类" class="layui-btn layui-btn-normal" id="addCat">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">科室图标:</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img id="head"  width="150px" height="150px">
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post"  name="file" lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="logo" value="" />
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">科室简介:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入简介" lay-verify="summary"  id="summary" name="summary" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">科室介绍链接:</label>
            <div class="layui-input-block">
                <input type="text" name="exhibitUrl"  autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">健康宣教链接:</label>
            <div class="layui-input-block">
                <input type="text" name="healthUrl"  autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">典型病例链接:</label>
            <div class="layui-input-block">
                <input type="text" name="typicalIllUrl"  autocomplete="off" class="layui-input">

            </div>
        </div>
    </form>
    <button lay-filter="submit" lay-submit  id="submit" class="layui-btn layui-btn-normal">保存</button>
</div>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    var params = [];//父子页面传递科室分类使用 type arr
    layui.use(['form', 'laydate','upload','layer'], function() {
        var form = layui.form(),
            layer = layui.layer,upload=layui.upload,
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象

            laydate = layui.laydate;
        layui.upload({
            elem:'#upload',
            url:'<%=staticPath%>/img/upload',
            ext:'jpg|png|jpeg|gif',
            method:'post',
            /*before:function (input) {
                if (input.files[0].size>3145728){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                    return false ;
                }
            },*/
            success:function (res) {
//                if(res.code==200){
//                    $("img").attr("src",res.entity);
//                    $('input[name=logo]').val(res.entity);
//                }else {
//                layer.msg("上传头像失败");
//
//                }
                if (res.code!=200){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                }else {
                    $("img").attr("src", res.entity);
                    $('input[name=logo]').val(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传头像失败",{icon:2});
            }

        });
        //添加科室分类
        $('#addCat').on('click',function () {
            layer.open({
                title:'添加科室分类',
                type:2,
                content:'<%=staticPath%>/department/toDeptCategory/0',
                shadeClose:false,
                btn:['保存','取消'],
                area:['600px','400px'],
                yes:function (index,layero) {
                    $('#category span').remove();
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    params=iframeWin.getCheckedOnes();
                    var html="";
                    for (var i=0;i<params.length;i++){
                        html+='<span><input type="hidden" data-level="2" value="'+params[i].dictDepartmentId+'"/>'+params[i].name+'<a  href="javascript:" >删除</a></span>';
                    }

                    $('#category').append(html);
                    $('#category').children("span").find("a").each(function () {
                        var $that=$(this);
                        $that.on('click',function () {
                            for(var i=0;i<params.length;i++){
                                if(Number($that.parent("span").find('input').val())==params[i].dictDepartmentId){
                                    params.splice(i,1)
                                }
                            }
                            $that.parent("span").remove();
                        })
                    });
                    layer.close(index);

                },
                success:function (layero) {},
                cancel:function (index) {
                    layer.close(index);
                }
            });
        });
        //自定义验证规则
        form.verify({
            summary: function(value) {
                if(value.length >1000) {
                    return '科室简介最多1000个字符';
                }
            }
        });
        //监听提交
        form.on('submit(submit)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            });
            /*if(data.field.summary.length >255) {
                layer.msg('科室简介最多255个字符',{icon:5});
                return false;
            }*/
            $("#deptDiv").find("button").prop("disabled","disabled");

            var deptDictDepts=[];
            $('#category').children("span").find("input[type=hidden]").each(function () {
                var $that=$(this);
                var deptDictDept={
//                    departmentId:$('#deptId').val(),
                    dictDepartmentLevel:$that.data("level"),
                    dictDepartmentId:$that.val()
                };
                deptDictDepts.push(deptDictDept);
            });
            data.field.deptDictDepts=deptDictDepts;
            var department={
//                id:$('#deptId').val(),
                hospitalId:$("#hosId").val(),
                name:$("input[name='name']").val(),
//                dictHospitalCategoryId:$("select[name='dictHospitalCategoryId']").val(),
                logo:$("input[name='logo']").val(),
                exhibitUrl:$("input[name='exhibitUrl']").val(),
                healthUrl:$("input[name='healthUrl']").val(),
                typicalIllUrl:$("input[name='typicalIllUrl']").val(),
                summary:$("textarea[name='summary']").val()
            };
            data.field.department=department;
            $.ajax({
                url:'<%=staticPath%>/department/addDepartment',
                type:'post',
                data:JSON.stringify(data.field),
                dataType:'json',
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200)
                        layer.msg("添加科室成功");
                    else {
                        $("#deptDiv").find("button").prop("disabled","");
                        layer.msg("添加科室失败");
                    }
                },
                error:function (result) {
                    $("#deptDiv").find("button").prop("disabled","");
                    layer.msg("添加科室失败");

                }
            });
            return false;
        });


        //监听提交
//        form.on('submit(editDoctor)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            });
//            return false;
//        });

    });

    var getParams=function () {
        var department={
            name:$("input[name='name']").val(),
            dictHospitalCategoryId:$("select[name='dictHospitalCategoryId']").val(),
            logo:$("input[name='logo']").val(),
            exhibitUrl:$("input[name='exhibitUrl']").val(),
            healthUrl:$("input[name='healthUrl']").val(),
            typicalIllUrl:$("input[name='typicalIllUrl']").val(),
            summary:$("textarea[name='summary']").val()
        };
        var departmentParams={
            department:department
        };
        return departmentParams;
    }
</script>
</body>

</html>