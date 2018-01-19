<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    String gateWay = (String) request.getAttribute("gateWay");
    System.out.println(gateWay);
    String servicePath = gateWay+"/system";
%>
<!DOCTYPE html>
<html>
<head>
    <title>创建商品-添加疾病</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="<%=contextPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=contextPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/static/css/btable.css" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css/global.css" />
</head>
<body>
<div style="margin: 0px; background-color: white;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin: 0;" id="diseaseQueryForm">
                <label class="layui-form-label layui-form-label-sm">编码</label>
                <div class="layui-input-inline">
                    <input type="text" name="code" autocomplete="off" class="layui-input layui-btn-small">
                </div>
                <label class="layui-form-label layui-form-label-sm">名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" autocomplete="off" class="layui-input layui-btn-small">
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit >
                        <i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div class="layui-form" id="diseaseList"></div>
    <input type="button" id="getDisease" style="display: none;">
</div>
<script  src="<%=contextPath%>/static/plugins/layui/layui.js"></script>
<script type="text/javascript">

    var diseaseArr = [];
    if(window.parent.diseaseArr.length>0){
        diseaseArr = window.parent.diseaseArr
    }
    layui.config({
        base: '<%=contextPath%>/static/js/'
    }).use(['btable','jquery','jquery_form','form'], function() {
        var $ = layui.jquery;
        var $ = layui.jquery_form($);
        var	btable = layui.btable(),
                layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
                layer = layui.layer, //获取当前窗口的layer对象
                form = layui.form();

        btable.set({
            openWait: true,
            url: '<%=servicePath%>/disease/page', //地址
            paged:true,
            elem: '#diseaseList', //内容容器
            even: true,//隔行变色
            field: 'id', //主键ID
            checkbox: true,//是否显示多选框
            type: 'POST',
            pageSize:15,
            columns:[{
                fieldName:'编码',
                field:'code'
            },{
                fieldName:'名称',
                field:'name'
            },{
                fieldName:'标签',
                field:'tags'
            },{
                fieldName:'全拼',
                field:'fullSpell'
            },{
                fieldName:'简拼',
                field:'abbrSpell'
            }],
            onSuccess: function ($elem) { //$elem当前窗口的jq对象
            },
            fail: function(msg) { //获取数据失败的回调
                layer.msg(msg, { icon: 2 });
            }
        });
        btable.render();

        form.on('submit(search)', function(data) {
            btable.get({
                code: data.field.code,
                name: data.field.name
            });
            return false;
        });

        $('#getDisease').on('click',function () {
            $('#diseaseList').find('tr').each(function() {
                var $that = $(this);
                var $ele=$that.children('td').eq(0).children('div');
                if ($ele.hasClass('layui-form-checked')){
                    var id = $that.children('td').eq(0).children('input').attr('data-id');
                    var num = 0;
                    for(x in diseaseArr){
                        if(id!=diseaseArr[x].id){
                            num++;
                        }
                    }
                    if(num==diseaseArr.length){
                        diseaseArr.push({
                            id:$that.children('td').eq(0).children('input').attr('data-id'),
                            name:$that.children('td').eq(3).text()
                        })
                    }
                }
            });
        });
    });
</script>
</body>

</html>