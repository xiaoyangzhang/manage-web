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
<!DOCTYPE html PUBLIC "-//W3C//DTDHTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>添加名医</title>
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
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
<div style=" background-color: white; margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form" style="">
            <%--<input type="hidden" id="doctorId" value="${id}" />--%>
            <div class="layui-form-item" style="margin:0;">
                        <a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>
                <label class="layui-form-label layui-form-label-sm">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="realname" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>

                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <a href="javascript:" class="layui-btn layui-btn-small" id="search">
                        <i class="layui-icon">&#xe615;</i> 搜索
                    </a>
                </div>
            </div>

        </form>
    </blockquote>
    <%--<legend>当前位置：按医生添加</legend>--%>
    <div class="layui-form">
        <table class="layui-table">
            <thead>
            <tr>
                <%--<th style="width: 30px;"><input type="checkbox" lay-filter="allselector" lay-skin="primary"></th>--%>
                <th>序号</th>
                <th>姓名</th>
                <th>用户名</th>
                <th>医院</th>
                <th>科室</th>
                <th>关联疾病</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="content">
            </tbody>
        </table>
    </div>
    <div class="admin-table-page">
        <div id="paged" class="page">
        </div>
    </div>
</div>
<script type="text/html" id="tpl">
    {{# layui.each(d.list, function(index, item){ }}
    <tr data-id="{{item.id}}">
        <%--<td><input type="checkbox" lay-skin="primary"></td>--%>
        <td>{{index+1}}</td>
        <td>{{ item.realname }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.hospitalName }}</td>
        <td>{{ item.departmentName }}</td>
        <td>{{ item.diseases }}</td>
        <td>
            <a href="javascript:" data-id="1" data-opt="add" class="layui-btn  layui-btn-mini">添加疾病</a>
        </td>
    </tr>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >

    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['paging', 'form'], function() {
        var $ = layui.jquery,
            paging = layui.paging(),
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
            layer = layui.layer, //获取当前窗口的layer对象
            form = layui.form();

        var options={
            openWait: true,
            url: '<%=staticPath%>/doctor/famousDoctorDiseases', //地址
            elem: '#content', //内容容器
            params: { //发送到服务端的参数
                realname:$('input[name="realname"]').val()
            },
            type: 'post',
            tempElem: '#tpl', //模块容器
            pageConfig: { //分页参数配置
                elem: '#paged', //分页容器
                pageSize: 20 //分页大小
            },
            success: function() { //渲染成功的回调
                //alert('渲染成功');
            },
            fail: function(msg) { //获取数据失败的回调
                //alert('获取数据失败')
            },
            complate: function() { //完成的回调
                //alert('处理完成');
                //重新渲染复选框
                /*form.render('checkbox');
                form.on('checkbox(allselector)', function(data) {
                    var elem = data.elem;

                    $('#content').children('tr').each(function() {
                        var $that = $(this);
                        //全选或反选
                        $that.children('td').eq(0).children('input[type=checkbox]')[0].checked = elem.checked;
                        form.render('checkbox');
                    });
                });*/

                //绑定所有编辑按钮事件
                $('#content').children('tr').each(function() {
                    var $that = $(this);
                    var id=$that.data("id");
                    $that.children('td:last-child').children('a[data-opt=add]').on('click', function() {
//                        layer.msg($(this).data('name'));
                        location.href="<%=staticPath%>/doctor/toDiseaseDoctor/"+id;
                    /*    addBoxIndex = layer.open({
                            type: 1,
                            title: '添加表单',
                            content: form,
                            btn: ['保存', '取消'],
                            shade: false,
                            offset: ['100px', '30%'],
                            area: ['600px', '400px'],
                            zIndex: 19950924,
                            maxmin: true,
                            yes: function(index) {
                                //触发表单的提交事件
                                $('form.layui-form').find('button[lay-filter=edit]').click();
                            },
                            full: function(elem) {
                                var win = window.top === window.self ? window : parent.window;
                                $(win).on('resize', function() {
                                    var $this = $(this);
                                    elem.width($this.width()).height($this.height()).css({
                                        top: 0,
                                        left: 0
                                    });
                                    elem.children('div.layui-layer-content').height($this.height() - 95);
                                });
                            },
                            success: function(layero, index) {
                                //弹出窗口成功后渲染表单
                                var form = layui.form();
                                form.render();
                                form.on('submit(edit)', function(data) {
                                    console.log(data.elem); //被执行事件的元素DOM对象，一般为button对象
                                    console.log(data.form); //被执行提交的form对象，一般在存在form标签时才会返回
                                    console.log(data.field); //当前容器的全部表单字段，名值对形式：{name: value}
                                    //调用父窗口的layer对象
                                    layerTips.open({
                                        title: '这里面是表单的信息',
                                        type: 1,
                                        content: JSON.stringify(data.field),
                                        area: ['500px', '300px'],
                                        btn: ['关闭并刷新', '关闭'],
                                        yes: function(index, layero) {
                                            layerTips.msg('你点击了关闭并刷新');
                                            layerTips.close(index);
                                            location.reload(); //刷新
                                        }

                                    });
                                    //这里可以写ajax方法提交表单
                                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                                });
                                //console.log(layero, index);
                            },
                            end: function() {
                                addBoxIndex = -1;
                            }
                        });*/
                    });

                });

            },
        };
        paging.init(options);
        //获取所有选择的列
        /*$('#getSelected').on('click', function() {
            var names = '';
            $('#content').children('tr').each(function() {
                var $that = $(this);
                var $cbx = $that.children('td').eq(0).children('input[type=checkbox]')[0].checked;
                if($cbx) {
                    var n = $that.children('td:last-child').children('a[data-opt=edit]').data('name');
                    names += n + ',';
                }
            });
            layer.msg('你选择的名称有：' + names);
        });*/

        $('#search').on('click', function() {
            var params={
                realname:$('input[name="realname"]').val()
            };
            $.extend(options,params);
            paging.get(options);
        });
        //监听搜索表单的提交事件
//        form.on('submit(search)', function (data) {
//            btable.get(data.field);
//            return false;
//        });
        /*var addBoxIndex = -1;
        $('#add').on('click', function() {
            if(addBoxIndex !== -1)
                return;
            //本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
            $.get('temp/edit-form.html', null, function(form) {
                addBoxIndex = layer.open({
                    type: 1,
                    title: '添加表单',
                    content: form,
                    btn: ['保存', '取消'],
                    shade: false,
                    offset: ['100px', '30%'],
                    area: ['600px', '400px'],
                    zIndex: 19950924,
                    maxmin: true,
                    yes: function(index) {
                        //触发表单的提交事件
                        $('form.layui-form').find('button[lay-filter=edit]').click();
                    },
                    full: function(elem) {
                        var win = window.top === window.self ? window : parent.window;
                        $(win).on('resize', function() {
                            var $this = $(this);
                            elem.width($this.width()).height($this.height()).css({
                                top: 0,
                                left: 0
                            });
                            elem.children('div.layui-layer-content').height($this.height() - 95);
                        });
                    },
                    success: function(layero, index) {
                        //弹出窗口成功后渲染表单
                        var form = layui.form();
                        form.render();
                        form.on('submit(edit)', function(data) {
                            console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                            console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                            console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                            //调用父窗口的layer对象
                            layerTips.open({
                                title: '这里面是表单的信息',
                                type: 1,
                                content: JSON.stringify(data.field),
                                area: ['500px', '300px'],
                                btn: ['关闭并刷新', '关闭'],
                                yes: function(index, layero) {
                                    layerTips.msg('你点击了关闭并刷新');
                                    layerTips.close(index);
                                    location.reload(); //刷新
                                }

                            });
                            //这里可以写ajax方法提交表单
                            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                        });
                        //console.log(layero, index);
                    },
                    end: function() {
                        addBoxIndex = -1;
                    }
                });
            });
        });

        $('#import').on('click', function() {
            var that = this;
            var index = layer.tips('只想提示地精准些', that, { tips: [1, 'white'] });
            $('#layui-layer' + index).children('div.layui-layer-content').css('color', '#000000');
        });
        $('#refresh').on('click',function(){

            document.getElementById('frame2').location.href="http://www.baidu.com";
        });*/
    });
</script>
</body>
</html>