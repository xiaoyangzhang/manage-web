<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
%>
<html>

<head>
    <meta charset="utf-8">
    <title>新增应用升级记录</title>
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
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote">
        <a href="javascript:history.back(-1);" id="back" class="layui-btn layui-btn-small">返回</a>
        <!--<a href="javascript:location.href=location.href;" style="float: right" id="refresh" class="layui-btn layui-btn-normal">刷新</a>-->
    </blockquote>
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">app类型</label>
            <div class="layui-input-inline">
                <select name="appType" lay-filter="appType">
                    <option value="">全部</option>
                    <option value="health" >新健康</option>
                    <option value="hh-doctor" >海虹新医疗</option>
                    <option value="hh-doctor-hd" >海虹新医疗HD</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">版本号</label>
            <div class="layui-input-inline">
                <input type="text" name="appVersion"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">版本名称</label>
            <div class="layui-input-inline">
                <input type="text" name="versionName" placeholder="比如4.2.0"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户端类型</label>
            <div class="layui-input-inline">
                <select name="clientType" lay-filter="clientType">
                    <option value="">全部</option>
                    <option value="1" >android</option>
                    <%--<option value="2" >android Pad</option>--%>
                    <option value="2" >ios</option>
                    <%--<option value="4" >iPad</option>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">下载链接</label>
                <div class="layui-input-inline">
                    <input type="text" name="downloadUrl" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">强制升级</label>
            <div class="layui-input-inline" >
                <input type="radio" name="isForce" value="2" title="是" checked="">
                <input type="radio" name="isForce" value="1" title="否">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">升级内容</label>
            <div class="layui-input-block" >
                <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_editor"></textarea>

            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="submit">立即提交</button>
            </div>
        </div>

    </form>
</div>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    layui.use(['form', 'laydate','laytpl','layedit'], function() {
        var form = layui.form(),
            layer = layui.layer,laytpl=layui.laytpl,layedit = layui.layedit,
            laydate = layui.laydate;
        //创建一个编辑器
        var editIndex = layedit.build('LAY_editor');
        form.verify({
            /*summary: function(value) {
                if(value.length >200) {
                    return '最多200个字符';
                }
            },
            strongpoint:function (value) {
                if(value.length >200) {
                    return '最多200个字符';
                }
            }*/
            content: function(value) {
                layedit.sync(editIndex);
            }
        });
        //监听提交
        form.on('submit(submit)', function(data) {
            $.ajax({
                url:'<%=staticPath%>/dictPage/upgrade/add',
                type:'post',
                dataType:'json',
                data:JSON.stringify(data.field),
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200) {
                        layer.msg("添加成功",{icon:1});
//                        layer.close(index);
                        location.reload();
                    }else if(result.code==201){
                        layer.msg(result.msg,{icon:5});
                    }
                    else{
                        layer.msg("添加失败",{icon:2});
                    }
                },
                error:function (result) {
                    layer.msg("添加失败",{icon:2});
                }
            });
            return false;
        });
    });

    var getParams=function () {
        var params={
            appVersion:$("input[name='appVersion']").val(),
            downloadUrl:$("input[name='downloadUrl']").val(),
            isForce:$("input[name='isForce']:checked").val(),
            appType:$("select[name='appType']").val(),
            clientType:$("select[name='clientType']").val(),
            content:$("textarea[name='content']").val(),

        };
        console.log(params);
        return params;
    }
</script>
</body>

</html>