<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>服务卡管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<div style="width: 100%;">
    <table class="site-table table-hover">
        <thead>
        <tr>
            <th width="30px;">序号</th>
            <th>名称</th>
            <th>价格</th>
            <th>计费方式(次数)</th>
            <th>有效期</th>
            <th>科室分成比例</th>
            <th>适用类型</th>
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
        <td>{{ item.name }}</td>
        <td>{{ item.price }}</td>
        <td>{{ item.count }}次</td>
        <td>不限</td>
        <td>{{ item.incomeRate }}</td>

        <td>
            全平台通用
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();

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
    function testa() {

        //		alert(layui.jquery("#con").find("input:checked").parent("td").next("td").text());
        var params = {};
        //	params["id"] =layui.jquery("#con").find("input:checked").next("input").val();
        //	params["pageIndex"] = 1;
        var temp = '';
        layui.jquery("#con").find("input:checked").each(function (i) {
            temp = temp + layui.jquery(this).next("input").val() + ','
            //alert(layui.jquery(this).next("input").val());
        })

        if (null == temp || '' == temp) {
            alert("请勾选一条数据！");
        }
        params["id"] = temp;

        layui.jquery.ajax({
            type: "post",
            url: '<%=path%>/dictservicecardlist?id1=' + Math.random(),
            data: params,
            async: false,
            dataType: "text",
            success: function (data) {
                if (data == 'success') {

                    testalert();
                    alert("删除成功!")
                }
            },
            error: function (data) {
                alert('删除出错');
            }
        });


    }

    function testalert() {
        //	var $ = layui.jquery;
        //	alert($("#testjquery").val())

        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code'], function () {
            layui.code();
            var $ = layui.jquery,
                    paging = layui.paging();

            paging.init({
                openWait: true,
                url: '<%=path%>/dictservicecardlist?id1=' + '2', //地址
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
                },
            });
        })

    }
</script>
</body>

</html>