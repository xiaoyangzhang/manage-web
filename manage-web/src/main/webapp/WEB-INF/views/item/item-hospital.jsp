<%--
  Created by IntelliJ IDEA.
  User: zhangxiaoyang
  Date: 2017/8/7
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%
    String staticPath=request.getContextPath();
    String imgUrl = (String) request.getAttribute("imgUrl");
%>
<head>
    <title>创建商品-添加医院</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=staticPath%>/static/css/btable.css" />
    <link rel="stylesheet" href="<%=staticPath%>/static/css/global.css" />
</head>
<body>
<div style="margin:0px; background-color: white;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form" id="hospitalForm">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-lg">医院名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">省</label>
                <div class="layui-input-inline">
                    <select name="provinceCode" lay-filter="province">
                        <option value="">请选择省</option>
                        <c:forEach items="${provinces}" var="province">
                            <option value="${province.id}" >${province.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-sm">市</label>
                <div class="layui-input-inline">
                    <select name="cityCode" lay-filter="city">
                        <option value="">请选择市</option>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;height: 533px;"></div>
    <input type="button" id="getHos" style="display: none;">
</div>
<script type="text/html" id="cityTpl">
    {{# layui.each(d.list, function(index, item){ }}
        <option value="{{item.id}}">{{item.name}}</option>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script >

    var hospital = {};

    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','tab','layer','laytpl','jquery'],function () {
        var imgUrl="<%=imgUrl%>";
        var btable = layui.btable(),
                form = layui.form(),
                laytpl=layui.laytpl,
                layer=layui.layer,$=layui.jquery;
        btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            url: '<%=staticPath%>/hospital/hospitalList', //数据源地址
            pageSize: 20,//页大小
            type:'post',
            columns:[{
                fieldName:'医院名称',
                width:130,
                field:'name'
            },{
                fieldName:'省',
                width:50,
                field:'province'
            },{
                fieldName:'市',
                width:50,
                field:'city'
            },{
                fieldName:'级别',
                width:30,
                field:'level'
            }],
            even: true,//隔行变色
            field: 'id', //主键ID
            checkbox: true,//是否显示多选框
            paged: true, //是否显示分页
            singleSelect: true, //只允许选择一行，checkbox为true生效
            onSuccess:function ($elem) {
            }
        });
        btable.render();
        form.on('select(province)',function (data) {
            var parentId=data.value;
            $.ajax({
                url:'<%=staticPath%>/dictPage/cities/query/'+parentId,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('select[name=cityCode]').empty();
                    laytpl($('#cityTpl').html()).render(result,function (html) {
                        $('select[name=cityCode]').append('<option value="">请选择市</option>'+html);
                    });
                    form.render('select');
                },
                error:function (result) {

                }
            });
        });

        //监听搜索表单的提交事件
        form.on('submit(search)', function (data) {
            btable.get(data.field);
            return false;
        });
        $(window).on('resize', function (e) {
            var $that = $(this);
            $('#content').height($that.height() - 92);
        }).resize();

        $('#getHos').on('click',function () {
            $('#content').find('tr').each(function() {
                var $that = $(this);
                var $ele=$that.children('td').eq(0).children('div');
                if ($ele.hasClass('layui-form-checked')){
                    hospital={
                        id:$that.children('td').eq(0).children('input').attr('data-id'),
                        name:$that.children('td').eq(2).text()
                    };
                }
            });
        });
    });

</script>
</body>
</html>
