<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <%
    String staticPath=request.getContextPath();
%>
<html>
<head>
    <title>商品管理-商品列表</title>
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
<div style="background-color: white; margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-lg">商品编号</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" name="code" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">商品名称</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" name="name" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">所属机构</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" name="hospitalName" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">商品分类</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <select id="categoryId" name="categoryId">
                        <option value="0">全部</option>
                        <option value="1">待产包</option>
                        <option value="2">服务卡</option>
                        <option value="3">私人医生</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-lg">商品状态</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <select id="state" name="state">
                        <option value="0">全部</option>
                        <option value="1">已上架</option>
                        <option value="2">已下架</option>
                        <option value="3">待发布</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-lg">上下架时间</label>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" id="beginTime"  name="beginTime" autocomplete="off"   class="layui-input">
                </div>
                <div class="layui-input-inline" style="width: 80px;">
                    <input type="text" id="endTime" name="endTime" autocomplete="off"  class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;">
    </div>
</div>


<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="application/javascript">
    layui.use(['laydate','jquery'],function () {
        var laydate = layui.laydate,$=layui.jquery;
        var start={
            max: '2099-6-16 23:59:59',
            istoday:false,
            choose:function (datas) {
                end.min=datas;
                end.start=datas
            }
        };
        var end={
            max: '2099-6-16 23:59:59',
            istoday:false,
            choose:function (datas) {
                start.max=datas;
            }

        };
        $("#beginTime").click(function () {
            start.elem=this;
            laydate(start);
        });
        $("#endTime").click(function () {
            end.elem=this;
            laydate(end);
        });
    });
    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','tab','layer','element','laydate','jquery'],function () {
        var btable = layui.btable(),
                form = layui.form(),
                layer=layui.layer,
                layerTips = parent.layer === undefined ? layui.layer : parent.layer,//获取父窗口的layer对象
                element = layui.element(),$=layui.jquery;
        btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            url: "<%=staticPath%>/item/queryItemListPage/", //数据源地址
            pageSize: 20,//页大小
            type:'post',
            columns:[
                {
                    fieldName:'商品编号',
                    field:'code'
                },
                {
                    fieldName:'商品名称',
                    field:'name'
                },
                {
                    fieldName:'商品价格',
                    field:'price'
                },
                {
                    fieldName:'商品分类',
                    field:'categoryName'
                },
                {
                    fieldName:'所属机构',
                    field:'hostitalName'
                },
                {
                    fieldName:'商品描述',
                    field:'description'
                },
                {
                    fieldName:'置顶排序',
                    field:'topOrder'
                },
                {
                    fieldName:'商品状态',
                    field:'stateName'
                },
                {
                    fieldName:'创建人',
                    field:'createOperator'
                },
                {
                    fieldName:'上架／下架时间',
                    field:'onshelfDay'
                },
                {
                    fieldName:'创建时间',
                    field:'createTime'
                },
                {
                    fieldName: '操作',
                    width:130,
                    field: 'id',
                    format: function (val,obj) {
                        var edit = '', view ='', oper = '';
                        edit = '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                        view = '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                        if(obj.state=='1'||obj.state=='4'){
                            oper = '<input type="button" value="上架" lay-filter="oper" data-action="onShelf" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                            return view+edit+oper;
                        }else if(obj.state=='2'){
                            oper = '<input type="button" value="下架" lay-filter="oper" data-action="offShelf" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                            return view+oper;
                        }else{
                            return view;
                        }
                    }
                }
            ],
            even: true,//隔行变色
            field: 'id', //主键ID
            checkbox: false,//是否显示多选框
            paged: true, //是否显示分页
            singleSelect: false, //只允许选择一行，checkbox为true生效
            onSuccess:function ($elem) {
                $elem.children('tr').each(function () {
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        $that.on('click', function () {
                            switch (action) {
                                case 'edit'://编辑
                                    location.href='<%=staticPath%>/item/getItemMessage/'+id+'/'+action;
                                    break;
                                case 'view': //查看
                                    location.href='<%=staticPath%>/item/getItemMessage/'+id+'/'+action;
                                    break;
                                case 'onShelf': //上架
                                    $.ajax({
                                        url:'<%=staticPath%>/item/shelvesItem/'+id+'/'+2,
                                        type:'POST',
                                        dataType:'json',
                                        contentType:'application/json',
                                        success:function (result) {
                                            if (result.code==200){
                                                layerTips.msg("上架成功");
                                                location.reload();
                                            }
                                            else {
                                                layerTips.msg("上架失败");
                                            }
                                        },
                                        error:function (result) {
                                            layerTips.msg("上架失败");
                                        }
                                    });
                                    break;
                                case 'offShelf': //下架
                                    $.ajax({
                                        url:'<%=staticPath%>/item/offshelfItem/'+id+'/'+4,
                                        type:'POST',
                                        dataType:'json',
                                        contentType:'application/json',
                                        success:function (result) {
                                            if (result.code==200){
                                                layerTips.msg("下架成功");
                                                location.reload();
                                            }
                                            else {
                                                layerTips.msg("下架失败");
                                            }
                                        },
                                        error:function (result) {
                                            layerTips.msg("下架失败");
                                        }
                                    });
                                    break;
                            }
                        });
                    });
                });
            }
        });
        btable.render();

        //监听搜索表单的提交事件
        form.on('submit(search)', function (data) {
            btable.get(data.field);
            return false;
        });
        $(window).on('resize', function (e) {
            var $that = $(this);
            $('#content').height($that.height() - 92);
        }).resize();
    });
</script>
</body>
</html>
