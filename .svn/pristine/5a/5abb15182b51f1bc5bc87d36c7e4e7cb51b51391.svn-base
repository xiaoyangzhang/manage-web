<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<%
    //id1
    String maindataid = request.getParameter("maindataid");

//id2
    String backurl = request.getParameter("backurl");


%>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑H5页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

</head>

<body>
<div class="layui-whole">
    <form class="layui-form" action="">
        <blockquote class="layui-elem-quote">当前位置:编辑H5页面</blockquote>
        <div class="layui-whole-con">
            <h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>编辑H5页面</h2>

            <div class="layui-form-item">
                <label class="layui-form-label">设备名称</label>
                <div class="layui-input-inline">
                    <input type="text" value="${userInfo.content }" id="equipment" name="title" lay-verify="required"
                           autocomplete="off" placeholder="请输入标题" class="layui-input layui-input-label-lg">
                    <input type="hidden" value="${userInfo.id }" id="equipid" name="title" lay-verify="required"
                           autocomplete="off" placeholder="请输入标题" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">CODE</label>
                <div class="layui-input-inline">
                    <input type="text" value="${userInfo.code }" id="equipname" name="username" lay-verify="required"
                           placeholder="请输入" autocomplete="off" class="layui-input layui-input-label-lg">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">网址</label>
                <div class="layui-input-inline">
                    <input type="tel" value="${userInfo.url }" id="equipurl" name="phone" lay-verify="required"
                           autocomplete="off" class="layui-input layui-input-label-lg">
                </div>
            </div>

        </div>
        <div class="layui-fixed-btn">
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="button" onclick='returnback()' class="layui-btn layui-btn-normal">取消</button>
            </div>
        </div>
    </form>
</div>


<script>

    function returnback() {
        window.location = '<%=path%>/index?id=/pages<%=backurl%>';
    }


    function subbmitt() {
        var params = {};

        params["equipid"] = layui.jquery("#equipid").val();
        params["equipment"] = layui.jquery("#equipment").val();
        params["equipname"] = layui.jquery("#equipname").val();
        params["equipurl"] = layui.jquery("#equipurl").val();
        layui.jquery.ajax({
            type: "get",
            url: '<%=path%>/updatenewH5?id1=' + Math.random(),
            data: params,
            async: true,
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    layui.layer.msg("修改成功！")
                    returnback();

                }
                if (data == "fail") {

                    layer.alert("修改失败", {
                        title: '修改结果！'
                    })

                }
            },
            error: function (data) {
                layui.layer.msg('页面加载出错');
            }
        });

    }


    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit,
                laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');
        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            content: function (value) {
                layedit.sync(editIndex);
            }
        });

        //监听提交
        form.on('submit(demo1)', function (data) {
            subbmitt();
            return false;
        });
    });
</script>
</body>

</html>