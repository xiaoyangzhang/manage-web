﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>用户消费明细</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<blockquote class="layui-elem-quote">
    <form class="layui-form">
        <div class="layui-form-item" style="margin: 0;">
            <label class="layui-form-label layui-form-label-md">用户名:</label>
            <div class="layui-input-inline">
                <input placeholder="请输入用户名" class="layui-input" id="testjquery" type="text"
                       name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-lg">提交时间:</label>
            <div class="layui-input-inline">
                <input class="layui-input" type="text" name="date"
                       id="dateutil1" lay-verify="date" placeholder="yyyy-mm-dd"
                       autocomplete="off" onclick="layui.laydate({elem: this})">
            </div>
            <div class="layui-input-inline">
                <input class="layui-input" type="text" name="date"
                       id="dateutil2" lay-verify="date" placeholder="yyyy-mm-dd"
                       autocomplete="off" onclick="layui.laydate({elem: this})">
            </div>
            <label class="layui-form-label layui-form-label-lg">订单编号:</label>
            <div class="layui-input-inline">
                <input placeholder="请输入订单编号" class="layui-input" id="serviceno" type="text"
                       name="name"/>
            </div>
            <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                <button lay-filter="search" class="layui-btn" onclick="testalert()" type="button" id="search">
                    <i class="fa fa-search" aria-hidden="true"></i>查询
                </button>
            </div>
        </div>
    </form>
</blockquote>
<div style="width: 100%;">
    <table class="site-table table-hover">
        <thead>
        <tr>
            <th width="30px;">序号</th>
            <th>用户名</th>
            <th>服务订单编号</th>
            <th>收支类型</th>
            <th>金额/元</th>
            <th>提交时间</th>
            <th>消费状态</th>
            <th>说明</th>
            <td width="35px">操作</td>
        </tr>
        </thead>
        <!--内容容器-->
        <tbody id="con">

        </tbody>
    </table>
    <!--分页容器-->
    <div id="paged" class="new-btable-paged"></div>
</div>
<!--模板-->
<script type="text/html" id="conTemp">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;"><input type="hidden" value='{{ item.id }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.orderNo }}</td>
        <td>{{ item.type }}</td>
        <td>{{ item.consumeAmount }}</td>
        <td>{{ item.updateTime }}</td>
        <td>{{ item.state }}</td>
        <td>{{ item.remark }}</td>
        <td>
            <button class="layui-btn layui-btn-mini viewBtn" onclick="detailpage(this)" type="button">查看</button>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();

    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();

        var temp = '';
        layui.jquery("#con").find("input:checked").each(function (i) {
            temp = temp + layui.jquery(this).next("input").val() + ',';
            //alert(layui.jquery(this).next("input").val());
        });
        window.location = '<%=path%>/index?id=/pages/order/servicecarddetailuser&backurl=/order/orderdetail&maindataid='+currentid;
    }


    //搜索
    <%--			$('#search').on('click', function() {
                    var $this = $(this);
                    var name = $this.prev('input[name=name]').val();
                    if(name === '' || name.length === 0) {
                        layer.msg('请输入关键字！');
                        return;
                    }
                    //调用get方法获取数据
                    paging.get({
                        t: Math.random(),
                        name: name //获取输入的关键字。
                    });
                });
            });--%>

    function testalert() {
        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code','jquery'], function () {
            layui.code();
            var $ = layui.jquery,
                paging = layui.paging();

            paging.init({
                openWait: true,
                url: '<%=path%>/orderdetail?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
                    begintime: layui.jquery("#dateutil1").val(),
                    endtime: layui.jquery("#dateutil2").val(),
                    serviceno: layui.jquery("#serviceno").val(),
                    //	token:'F8F5AE2137BFAEF77FF7408476AF6C64',
                    pageIndex: 1
                },
                //   	type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 5 //分页大小
                },
                success: function () { //渲染成功的回调
                    if(!window.parent.setPermissions($,"orderdetail:list:view")){
                        $('#con .viewBtn').css('display','none');
                    }
                },
                fail: function (msg) { //获取数据失败的回调
                    //	alert('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	alert('处理完成');
                    console.log(res);
                }
            });
        });

        initdatetool();
    }

    function initdatetool() {
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
        });
    }
</script>
</body>

</html>