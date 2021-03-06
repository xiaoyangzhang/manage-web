<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>医略－参与课题审核列表</title>
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
                <label class="layui-form-label layui-form-label-md">标题</label>
                <div class="layui-input-inline">
                    <input type="text" name="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">状态</label>
                <div class="layui-input-inline">
                    <select id="type" name="state">
                        <option value="0">请选择状态</option>
                        <option value="1">待审核</option>
                        <option value="2">审核中</option>
                        <option value="3">待上架</option>
                        <option value="4">上架中</option>
                        <option value="5">已拒绝</option>
                        <option value="6">已下架</option>
                        <option value="7">已过期</option>
                    </select>
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
<div style="display: none" id="offDiv">
    <form class="layui-form layui-form-mid">
        <label class="layui-form-label layui-form-label-lg" >下架原因</label>
        <div class="layui-input-inline">
            <textarea class="layui-textarea" lay-verify="reason"  name="reason" style="width: 350px;height: 100px;resize: none;"></textarea>
        </div>
        <button lay-filter="off" lay-submit style="display: none;"></button>
    </form>
</div>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script type="application/javascript">
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
            url: '<%=staticPath%>/publish/article/list', //数据源地址
            pageSize: 20,//页大小
            params:{
                type:2
            },
            type:'post',
            columns:[
                {
                    fieldName:'标题',
                    field:'title'
                },
                {
                    fieldName:'发布对象',
                    field:'publishDept'
                },
                {
                    fieldName:'发布地区',
                    field:'publishArea'
                },
                {
                    fieldName:'置顶',
                    field:'isTop',
                    format:function (val,obj) {
                        if (obj){
                            if(obj.isTop==1) return "否";
                            else if(obj.isTop==2) return "是";
                        }
                        return "";
                    }
                },
                {
                    fieldName:'更新时间',
                    field:'updateTime'
                },
                {
                    fieldName:'审核通过时间',
                    field:'reviewTime'
                },
                {
                    fieldName:'上架时间',
                    field:'onlineDay'
                },
                {
                    fieldName:'下架时间',
                    field:'offlineDay'
                },
                {
                    fieldName:'点击量',
                    field:'clickCount',
                    format:function (val,obj) {
                        if(!obj||obj.clickCount.length==0){
                            return "0";
                        }
                    }
                },
                {
                    fieldName:'状态',
                    field:'state',
                    format:function (val,obj) {
                        if (obj){
                            if (obj.state==1) return "待审核";
                            else if(obj.state==2) return "审核中";
                            else if(obj.state==3) return "待上架";
                            else if(obj.state==4) return "上架中";
                            else if(obj.state==5) return "已拒绝";
                            else if(obj.state==6) return "已下架";
                            else if(obj.state==7) return "已过期";
                        }
                        return "";
                    }
                },
                {
                    fieldName: '操作',
                    width:85,
                    field: 'id',
                    format: function (val,obj) {
                        var html="";
                        if (obj){
                            if (obj.state==1)
                            html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> '+
                            '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini " />'+
                            '<input type="button" value="审核" lay-filter="review" data-action="review" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                             else if(obj.state==2)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> '+
                                    '<input type="button" value="审核" lay-filter="review" data-action="review" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                            else if(obj.state==3)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> '+
                                 '<input type="button" value="下架" lay-filter="off" data-action="off" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                            else if(obj.state==4)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> '+
                                 '<input type="button" value="下架" lay-filter="off" data-action="off" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                            else if(obj.state==5)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> '+
                                 '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                            else if(obj.state==6)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                            else if(obj.state==7)
                                html+= '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';

                        }
                        return html;
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
                                    location.href='<%=staticPath%>/publish/toEditArticle/'+id+'/'+action;

                                    break;
                                case 'view': //查看
                                    location.href='<%=staticPath%>/publish/toEditArticle/'+id+'/'+action;
                                    break;
                                case 'review': //审核
                                    location.href='<%=staticPath%>/publish/toEditArticle/'+id+'/'+action;
                                    break;
                                case 'off': //下架
                                    layer.open({
                                        type:1,
                                        area:['500px','300px'],
                                        content:$('#offDiv').html(),
                                        shadeClose:true,
                                        btn:['确认','取消'],
                                        title:'下架',
                                        yes:function (index,layero) {
                                            // $('#refuseDiv').find('button[lay-filter=refuse]').click();
                                                var reason=$(layero).find('textarea[name=reason]').val();
                                            if(reason == undefined ||reason ==null || reason.length == 0){
                                                layerTips.msg( '请输入拒绝原因。',{icon:5});
                                                return false;
                                            }
                                            if(reason.length > 255){
                                                layerTips.msg( '下架原因不能超过255字',{icon:5});
                                                return false;
                                            }
                                                $.ajax({
                                                    url:'<%=staticPath%>/publish/update/article/state',
                                                    type:'post',
                                                    dataType:'json',
                                                    contentType:'application/json',
                                                    data: JSON.stringify({
                                                        articleId:id,
                                                        reason:reason,
                                                        state:6
                                                    }),
                                                    success:function (data) {
                                                        if (data.code=='200'){

                                                            layer.close(index);
                                                            var index1 = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                                            parent.layer.close(index1); //再执行关闭
                                                            layerTips.msg("下架成功",{icon:1});
                                                        }else if(data.code==501) {
                                                            layerTips.msg(data.msg, {icon: 5});
                                                            // $("button .review").prop("style", "");
                                                        }
                                                        else
                                                            layerTips.msg("下架失败",{icon:2});

                                                    },
                                                    error:function (data) {
                                                        layerTips.msg("下架失败",{icon:2});
                                                    }
                                                });
                                        },
                                        success:function (layero,index) {
                                            // var form=layui.form();
                                            // form.render();
                                            // form.on('submit(off)',function (data) {
                                            // });
                                        },
                                        cancel:function (index,layero) {
                                            layui.layer.close(index);
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
