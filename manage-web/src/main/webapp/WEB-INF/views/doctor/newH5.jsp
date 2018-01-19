<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
String staticPath=request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <title>新增H5页面</title>
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
<div class="layui-whole">
    <form class="layui-form" action="">
        <blockquote class="layui-elem-quote">当前位置:新增H5页面</blockquote>
        <div class="layui-whole-con">
            <h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>新增H5页面</h2>
            <div class="layui-form-item">
                <label class="layui-form-label">设备名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="equipment" name="content" autocomplete="off"
                           placeholder="请输入设备名称" class="layui-input layui-input-label-lg">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">CODE</label>
                <div class="layui-input-inline">
                    <input type="text" id="equipname" name="code" placeholder="请输入code"
                           autocomplete="off" class="layui-input layui-input-label-lg">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">网址</label>
                <div class="layui-input-inline">
                    <input type="text" id="equipurl" name="url" placeholder="请输入网址"
                           autocomplete="off" class="layui-input layui-input-label-lg">
                </div>
            </div>
        </div>
        <div class="layui-fixed-btn">
            <div class="layui-form-item">
                <%--<button lay-submit lay-filter="add" style="display: none;"></button>--%>
            </div>
        </div>
    </form>
</div>
<%--<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>--%>

<script>
//    layui.use(['form','jquery','layer'], function () {
//        var form = layui.form(),$=layui.jquery,
//                layer = layui.layer;


        //自定义验证规则
        /*form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            content: function (value) {
                layedit.sync(editIndex);
            }
        });*/

        //监听提交
        /*form.on('submit(submit)', function (data) {
            $.ajax({
                url:'/doctor/H5/add',
                dataType:'json',
                type:'post',
                contentType:'application/json',
                data:JSON.stringify(data.field),
                success:function (result) {
                    if (result.code==200){
                        layer.msg("添加成功",{icon:1});
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭
                    }else
                        layer.msg("添加失败",{icon:2});
                },
                error:function (result) {
                    layer.msg("添加失败",{icon:2});

                }
            });
            return false;
        });
        $('#cancel').on('click',function () {
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        })*/
//    });
var getParams=function () {
    var params={
        content:$("input[name='content']").val(),
        code:$("input[name='code']").val(),
        url:$("input[name='url']").val()
    };
//        var params=$.param($('#doctorForm').serializeArray());
    return params;
}
</script>
</body>

<%--</html>--%>