﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>患者列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<div style="margin:0px;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">

            <div class="layui-form-item" style="margin: 0;">
                <label class="layui-form-label layui-form-label-md">用户名</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入用户名" id="testjquery" type="text" class="layui-input" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-lg">注册日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="dateutil1" class="layui-input" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})"/>
                </div>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="dateutil2" class="layui-input" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})"/>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalert()" type="button" id="search"><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>

    <div style="width: 100%;">
        <table class="site-table table-hover" style="margin-bottom: 30px;">
            <thead>
            <tr>
                <th width="30px;">序号</th>
                <th>用户名</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>注册时间</th>
                <th width="120px">操作</th>
            </tr>
            </thead>
            <!--内容容器-->
            <tbody id="con">

            </tbody>
        </table>
        <!--分页容器-->
        <div id="paged" class="new-btable-paged"></div>
    </div>


</div>
<!--模板-->
<script type="text/html" id="conTemp">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;"><input type="hidden" value='{{ item.id }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.realname }}</td>
        <td>{{ item.sex }}</td>
        <td>{{ item.age }}</td>
        <td>{{ item.createTime }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpagemes(this)" type="button">消息</button>
            <button class="layui-btn layui-btn-mini" data-action="edit" data-id="{{item.id}}" id="edit" type="button">编辑</button>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">详情</button>
            <%--<button class="layui-btn layui-btn-mini" onclick="editPatient('{{item.id}}')" type="button">详情</button>--%>
        </td>
    </tr>
    {{# }); }}
</script>

<script type="text/javascript">
    testalert();

    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/patientedit?id=/pages/patient/patientinfodetail&type=edit&backurl=/patient/patient&maindataid=' + currentid;
    }


    function detailpagemes(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/index?id=/pages/business/dialogdetail&backurl=/patient/patient&patientid=' + currentid;
    }


    function testa() {
        layui.layer.msg(layui.jquery("#con").find("input:checked").parent("td").next("td").text());
        var params = {};
        params["id"] = "1";
        params["pageIndex"] = 1;
        layui.jquery.ajax({
            type: "post",
            url: '<%=path%>/patient?id1=' + Math.random(),
            data: params,
            async: false,
            dataType: "text",
            success: function (data) {
                layui.layer.msg(data);
            },
            error: function (data) {
                layui.layer.msg('页面加载出错');
            }
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
                url: '<%=path%>/patient?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
                    begintime: layui.jquery("#dateutil1").val(),
                    endtime: layui.jquery("#dateutil2").val()
                    // pageIndex: 1
                },
                //   	type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 20 //分页大小
                },
                success: function () { //渲染成功的回调
                    $('.new-btable-paged').css("bottom","1");
                    $('#con').children('tr').each(function () {
                        $(this).children('td:last-child').children('button').each(function () {
                            var $that = $(this);
                            var action = $that.data('action');
                            var id = $that.data('id');
                            $that.on('click', function () {
                                console.log(id);
                                switch (action) {
                                    case 'edit'://编辑
                                        layui.layer.open({
                                            title: '编辑患者',
                                            type: 2,
                                            content: '<%=path%>/patient/toEdit/'+id,
                                            area: ['800px', '500px'],
                                            shadeClose: true,
                                            btn:['保存','取消'],
                                            yes:function (index,layero) {
                                                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                                var params=iframeWin.getParams();
                                                params.id=id;
                                                $.ajax({
                                                    type:'post',
                                                    url:'<%=path%>/patient/edit',
                                                    data:JSON.stringify(params),
                                                    dataType:'json',
                                                    contentType:'application/json',
                                                    success:function (data) {
                                                        console.log(data);
                                                        if (data.code == 200){
                                                            layui.layer.msg("保存成功",{icon:1});
                                                            layui.layer.close(index);
                                                            // location.reload(true);
                                                            paging.get({
                                                                id: layui.jquery("#testjquery").val(),
                                                                begintime: layui.jquery("#dateutil1").val(),
                                                                endtime: layui.jquery("#dateutil2").val(),
                                                            });
                                                        }else
                                                            layui.layer.msg("保存失败",{icon:2})
                                                    },
                                                    error:function (data) {
                                                        layui.layer.msg("保存失败",{icon:2});
                                                    }
                                                });
                                            },
                                            cancel:function (index,layero) {
                                                layui.layer.close(index);
                                            },
                                            end:function (index) {
//                                            location.reload(true);
                                            }
                                        });
                                        break;
                                }
                            });
                        });
                    });
                },
                fail: function (msg) { //获取数据失败的回调

                },
                complate: function (res) { //完成的回调

                },
            });
        });
        initdatetool();
    }


    function initdatetool() {
        layui.use(['form', 'layedit', 'laydate','jquery'], function () {
            var form = layui.form(),
                    layer = layui.layer,
                    layedit = layui.layedit,
                    laydate = layui.laydate,
                    $ = layui.jquery;
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