﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title>对话管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body style="background-color: white; margin:0;">
<blockquote class="layui-elem-quote">
    <form class="layui-form">
        <div class="layui-form-item" style="margin: 0;">
            <label class="layui-form-label layui-form-label-md">用户名</label>
            <div class="layui-input-inline">
                <input placeholder="请输入用户名" class="layui-input" id="testjquery" type="text" name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-lg">医院名称</label>
            <div class="layui-input-inline">
                <input placeholder="请输入医院名称" class="layui-input" id="hospital" type="text" name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-lg">科室名称</label>
            <div class="layui-input-inline">
                <input placeholder="请输入科室名称" class="layui-input" id="department" type="text" name="name"/>
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
            <th>对话id</th>
            <th>用户</th>
            <th>用户居住地</th>
            <th>医疗机构</th>
            <th>对话更新时间</th>
            <th width="35px">操作</th>
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
        <td style="display: none;"><input type="hidden" value='{{ item.patientId }},{{ item.departmentId }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.id }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.residelocation }}</td>
        <td>{{ item.name }}</td>
        <td>{{ item.createTime }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">详情</button>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();

    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/index?id=/pages/business/dialogdetails&backurl=/business/dialoglist&id1=' + currentid;
    }



    function testalert() {
        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code','jquery'], function () {
            layui.code();
            var $ = layui.jquery,
                    paging = layui.paging();
            paging.init({
                openWait: true,
                url: '<%=path%>/dialog?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
                    hospital: layui.jquery("#hospital").val(),
                    department: layui.jquery("#department").val(),
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
                    if(!window.parent.setPermissions($,"dialoglist:view")){
                        $('#con table tr:last-child button').css('display','none')
                    }
                },
                fail: function (msg) { //获取数据失败的回调
                    //	alert('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	alert('处理完成');
                }
            });
        })
    }
</script>
</body>

</html>