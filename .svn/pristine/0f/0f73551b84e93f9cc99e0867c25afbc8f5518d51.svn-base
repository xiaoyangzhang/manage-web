<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>诊后签到审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

</head>

<body>
<div style="margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin: 0;">
                <label class="layui-form-label layui-form-label-md">手机号</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入手机号" class="layui-input" id="testjquery" type="text" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-sm">姓名</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入姓名" class="layui-input" id="name1" type="text" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-lg">签到状态</label>
                <div class="layui-input-inline">
                    <select id="state" name="quiz1">
                        <option value="">请选择状态</option>
                        <option value="1">未签到</option>
                        <option value="2">已签到</option>
                        <option value="3">已拒绝</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-lg">医院名称</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入医院名称" class="layui-input" id="hospital" type="text" name="name"/>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalert()" type="button">查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div style="width: 100%;">
        <table class="site-table table-hover" style="margin-bottom: 30px;">
            <thead>
            <tr>
                <th width="30px">序号</th>
                <th>申请时间</th>
                <th>手机号</th>
                <th>姓名</th>
                <th>签到医院名称</th>
                <th>签到状态</th>
                <th>审核员</th>
                <th width="60px">操作</th>
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
        <td style="display: none;"><input type="hidden" value='{{ item.dialogSignReviewId }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.applytime }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.realname }}</td>
        <td>{{ item.name1 }}</td>
        <td>{{ item.state }}</td>
        <td>{{ item.operatorid1 }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">审核查看</button>
        </td>

    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();


    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/dialogsignreviewedit?id=/pages/patient/dialogsignreviewdetail&type=edit&backurl=/patient/dialogsignreview&maindataid=' + currentid;
    }


    function testa() {

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
                url: '<%=path%>/dialogsignreview?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
                    name1: layui.jquery("#name1").val(),
                    hospital: layui.jquery("#hospital").val(),
                    state: layui.jquery("#state").val(),
                    //	token:'F8F5AE2137BFAEF77FF7408476AF6C64',
                    pageIndex: 1
                },
                //   	type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 20 //分页大小
                },
                success: function () { //渲染成功的回调
                    $('.new-btable-paged').css("bottom","1");
                },
                fail: function (msg) { //获取数据失败的回调

                },
                complate: function (res) { //完成的回调

                },
            });
        })
        initdatetool();
    }


    function initdatetool() {
        layui.use(['form'], function () {
            var form = layui.form(),
                    layer = layui.layer;
        });
    }
</script>
</body>

</html>