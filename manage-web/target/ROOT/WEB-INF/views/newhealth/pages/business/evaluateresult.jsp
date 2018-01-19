<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>评价结果</title>
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
            <label class="layui-form-label layui-form-label-lg">医院名称</label>
            <div class="layui-input-inline">
                <input placeholder="请输入医院名称" class="layui-input" id="username" type="text" name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-lg">科室名称</label>
            <div class="layui-input-inline">
                <input placeholder="请输入科室名称" class="layui-input" id="department" type="text" name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-sm">省</label>
            <div class="layui-input-inline">
                <input placeholder="请输入省" class="layui-input" id="province" type="text" name="name"/>
            </div>
            <label class="layui-form-label layui-form-label-sm">市</label>
            <div class="layui-input-inline">
                <input placeholder="请输入市" class="layui-input" id="city" type="text" name="name"/>
            </div>
            <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                <button lay-filter="search" class="layui-btn" onclick="testalert()" type="button" id="search"><i
                        class="fa fa-search" aria-hidden="true"></i>查询
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
            <th>医院名称</th>
            <th>科室名称</th>
            <th>省</th>
            <th>市</th>
            <th>平均回复速度</th>
            <th>平均医生态度</th>
            <th>平均医生满意度</th>
            <th width="50px">评价历史</th>
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
        <td>{{ item.name1 }}</td>
        <td>{{ item.name2 }}</td>
        <td>{{ item.name3 }}</td>
        <td>{{ item.name4 }}</td>
        <td>{{ item.avgSpeed }}</td>
        <td>{{ item.avgAttitude }}</td>
        <td>{{ item.avgSatisfy }}</td>
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
        window.location = '<%=path%>/index?id=/pages/business/evaluatelog&id2=/business/evaluateresult&id1=' + currentid;
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
                url: '<%=path%>/evaluateresult?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    //	id: layui.jquery("#testjquery").val(),
                    username: layui.jquery("#username").val(),
                    department: layui.jquery("#department").val(),
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
                    if(!window.parent.setPermissions($,"evaluate:list:detail")){
                        $('#con table tr:last-child button').css('display','none');
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
        })
    }
</script>
</body>

</html>