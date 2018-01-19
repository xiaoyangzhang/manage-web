<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title>H5 new</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<div style="margin: 0;">
    <blockquote class="layui-elem-quote">
        <form>
            <div class="layui-form-item" style="margin: 0;">
                <label class="layui-form-label layui-form-label-lg">页面名称</label>
                <div class="layui-input-inline"><input class="layui-input" placeholder="请输入页面名称" id="testjquery"
                                                       type="text" name="name"/></div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalert()" type="button">查询</button>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalertnew()" type="button">新增</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div style="width: 100%;">
        <table class="site-table table-hover" style="margin-bottom: 30px;">
            <thead>
            <tr>
                <th width="30px">序号</th>
                <th>页面名称</th>
                <th>CODE</th>
                <th>网址</th>
                <th width="75px">操作</th>
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
        <td>{{ item.content }}</td>
        <td>{{ item.code }}</td>
        <td>{{ item.url }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">编辑</button>
            <button class="layui-btn layui-btn-mini" onclick="detaildelete(this)" type="button">删除</button>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();


    function testalertnew() {
        window.location = '<%=path%>/index?id=/pages/patient/newH5&backurl=/patient/syslink';
    }


    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/syslinkedit?id=/pages/patient/editH5&type=edit&backurl=/patient/syslink&maindataid=' + currentid;
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
                url: '<%=path%>/syslink?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
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
                    //	alert('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	alert('处理完成');
                },
            });
        })
    }


    function detaildelete(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        var params = {};
        params["id"] = currentid;
        layui.layer.confirm('确定要移除', function () {
            layui.jquery.ajax({
                type: "post",
                url: '<%=path%>/h5delete?id1=' + Math.random(),
                data: params,
                async: false,
                dataType: "text",
                success: function (data) {
                    if (data == 'success') {
                        testalert();
                        layui.layer.msg("删除成功!")
                    }
                },
                error: function (data) {
                    layui.layer.msg('删除出错');
                }
            });
        })
    }
</script>
</body>

</html>