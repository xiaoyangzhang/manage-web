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
    <title>新增H5页面</title>
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
        <blockquote class="layui-elem-quote">当前位置:新增H5页面</blockquote>
        <div class="layui-whole-con">
            <h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>新增H5页面</h2>
            <div class="layui-form-item">
                <label class="layui-form-label">设备名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="equipment" name="title" lay-verify="required" autocomplete="off"
                           placeholder="请输入设备名称" class="layui-input layui-input-label-lg">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">CODE</label>
                <div class="layui-input-inline">
                    <input type="text" id="equipname" name="username" lay-verify="required" placeholder="请输入code"
                           autocomplete="off" class="layui-input layui-input-label-lg">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">网址</label>
                <div class="layui-input-inline">
                    <input type="tel" id="equipurl" name="phone" lay-verify="required" placeholder="请输入网址"
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
        params["equipment"] = layui.jquery("#equipment").val();
        params["equipname"] = layui.jquery("#equipname").val();
        params["equipurl"] = layui.jquery("#equipurl").val();
        layui.jquery.ajax({
            type: "get",
            url: '<%=path%>/addnewH5?id1=' + Math.random(),
            data: params,
            async: true,
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    layui.layer.msg("添加成功！")
                    returnback();

                }
                if (data == "fail") {

                    layer.alert("添加失败", {
                        title: '处理结果！'
                    })

                }
            },
            error: function (data) {
                layui.layer.msg('code长度最大为4位');


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

            //		alert(layui.jquery("#con").find("input:checked").parent("td").next("td").text());


            <%--		layer.alert(JSON.stringify(data.field), {
                        title: '最终的提交信息'
                    })
                    return false;--%>
        });
    });
</script>
</body>

</html>