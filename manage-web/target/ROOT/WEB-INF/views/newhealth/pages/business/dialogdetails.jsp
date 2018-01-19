<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>

<%
    String logid = request.getParameter("id1");
    String patientid = request.getParameter("id1").split(",")[0];
    String departmentid = request.getParameter("id1").split(",")[1];
    String username = request.getParameter("username");
//String id2=request.getParameter("id2");
    String backurl = request.getParameter("backurl");
%>
<html>
<head>
    <meta charset="utf-8">
    <title>对话内容</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<div class="layui-whole">
    <blockquote class="layui-elem-quote">当前位置:对话内容</blockquote>
    <table class="site-table table-hover">
        <thead>
        <tr>
            <th width="30px;">序号</th>
            <th><strong>医患</strong></th>
            <th><strong>用户</strong></th>
            <th><strong>聊天记录</strong></th>
            <th><strong>时间</strong></th>
        </tr>
        </thead>
        <!--内容容器-->
        <tbody id="con">

        </tbody>
    </table>
    <!--分页容器-->
    <div id="paged" class="new-btable-paged"></div>
    <div class="layui-fixed-btn">
        <div class="layui-form-item">
            <button onclick="information()" type="button" class="layui-btn layui-btn-normal">发消息</button>
            <button onclick="thatpage()" type="button" class="layui-btn layui-btn-normal" style="float: right;">返回</button>
        </div>
    </div>
</div>
<!--模板-->
<script type="text/html" id="conTemp">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;">{{ item.id }}</td>
        <td>{{index+1}}</td>
        <td>{{ item.doctororpatient }}</td>
        <td>{{ item.fromUserId }}</td>
        <td>{{ item.content }}</td>
        <td>{{ item.timeSend }}</td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();

    function thatpage() {
        window.location = '<%=path%>/index?id=/pages<%=backurl%>';
    }

    function detailpage() {
        window.location = '<%=path%>/index?id=/pages/business/dialoglist';
    }

    function information() {
        var con = '<div style="padding:10px;"><input type="text" id="title" name="title" required lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" style="margin-bottom: 10px;"><textarea id="blackreason" placeholder="请输入内容" class="layui-textarea"></textarea></div>';
        layui.layer.open({
            type: 1,
            title: '发送消息',
            content: con,
            btn: ['保存', '取消'],
            area: ['350px', '270px'],
            yes: function (index, layero) {
                //这是核心的代码。
                var params = {};
                params["id"] = <%=patientid%>;
                params["title"] = layui.jquery(layero).find("#title").val();
                params["reason"] = layui.jquery(layero).find('textarea').val();
                console.log(params)
                layui.jquery.ajax({
                    type: "get",
                    url: '<%=path%>/sendMsg?id1=' + Math.random(),
                    data: params,
                    async: true,
                    dataType: "text",
                    success: function (data) {
                        if (data == "success") {
                            layui.layer.msg("发送成功！")
                            location.reload();
                            testalert();
                        }
                        if (data == "fail") {
                            layer.alert("发送成功", {
                                title: '发送结果！'
                            })
                        }
                    },
                    error: function (data) {
                        layui.layer.msg('页面加载出错');
                        location.reload();
                    }
                });
            },
            shade: false,
            maxmin: true
        });
    }




    function testalert() {
        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code'], function () {
            layui.code();
            var $ = layui.jquery,
                    paging = layui.paging();
            paging.init({
                openWait: true,
                url: '<%=path%>/dialogdetaila?id1=' + '1', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: "1",
                    patientid:<%=patientid%>,
                    departmentid:<%=departmentid%>,
                    username:<%=username%>,
                    province: layui.jquery("#province").val(),
                    city: layui.jquery("#city").val(),
                    pageIndex: 1
                },
                //   	type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 5 //分页大小
                },
                success: function () { //渲染成功的回调
                    //	alert('渲染成功');
                },
                fail: function (msg) { //获取数据失败的回调
                    //	alert('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	alert('处理完成');
                    console.log(res);
                }
            });
        })
    }

</script>
</body>

</html>