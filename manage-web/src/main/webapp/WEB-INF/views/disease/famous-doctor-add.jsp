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
    <%--<script type="text/javascript" src="../../../static/plugins/laydate/laydate.js"></script>--%>
</head>
<body>
<div style="margin:0px; background-color: white;">
   <blockquote class="layui-elem-quote" style="margin:3px 3px;padding:3px 3px">
        <form class="layui-form" style="">
            <input type="hidden" name="diseaseId" id="diseaseId" value="${id}" />
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="realname" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>

                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>

        </form>
    </blockquote>

        <div class="layui-form">
            <table class="layui-table admin-table">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>姓名</th>
                    <th>用户名</th>
                    <th>职称</th>
                    <th>医院</th>
                    <th>科室</th>
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
    <tr data-id="{{item.doctorId}}">
        <td>{{index+1}}</td>
        <td>{{ item.realname }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.title }}</td>
        <td>{{ item.hospital }}</td>
        <td>{{ item.department }}</td>
        <td>
            {{# if(item.flag){ }}
            已添加
            {{# } else{ }}
            <a href="javascript:" data-id="1" data-opt="add" data-action="add"  class="layui-btn  layui-btn-mini">添加</a>
            {{# } }}
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

        paging.init({
            openWait: true,
            url: '<%=staticPath%>/doctor/disease/doctorList', //地址
            elem: '#content', //内容容器
            params: { //发送到服务端的参数
                realname: $('input[name="realname"]').val(),
                diseaseId:$('#diseaseId').val()
            },
            type: 'post',
            tempElem: '#tpl', //模块容器
            pageConfig: { //分页参数配置
                elem: '#paged', //分页容器
                pageSize: 20 //分页大小
            },
            success: function () { //渲染成功的回调
                //alert('渲染成功');
            },
            fail: function (msg) { //获取数据失败的回调
                //alert('获取数据失败')
            },
            complate: function () { //完成的回调
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
                $('#content').children('tr').each(function () {
                    var $that = $(this);
                    $that.children('td:last-child').children('a[data-opt=add]').on('click', function () {
//                        layer.msg($(this).data('name'));
//                        $that.parent("tr").addClass("selected");
                        var $this=$(this);
                        $.ajax({
                           type:'post',
                           dataType:'json',
                            url:'<%=staticPath%>/doctor/diseaseDoctor/addOne',
                           data:JSON.stringify({
                               diseaseId:$('#diseaseId').val(),
                               doctorId:$that.data("id")
                           } ),
                            contentType:'application/json',
                            success:function (result) {
                                if(result.code=='200') {
                                    layer.msg("添加成功",{icon:1});
                                    $this.unbind("click").text("已添加").parent().parent().addClass( "selected");
                                }
                                else if(result.code='10016')
                                    layer.msg("该医生已添加过",{icon:2});
                                else
                                    layer.msg("添加失败",{icon:2});
                            },
                            error:function (result) {
                                layer.msg("添加失败",{icon:2})
                            }
                        });
                    });

                });
//
//            }
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

//                $('#search').on('click', function () {
//                    parent.layer.alert('你点击了搜索按钮')
//                });
                //监听搜索表单的提交事件
                form.on('submit(search)', function (data) {
                    paging.get(data.field);
                    return false;
                });
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
                });*/

            }
    });
    });
    var getSelectedDoctors=function () {
            var diseaseDoctorArr=[];
        $('#content').children("tr").each(function () {
            var $that=$(this);
            var selected=$that.prop("class");
            if (selected) {
                var diseaseDoctor={
                    diseaseId:$('#diseaseId').val(),
                    doctorId:$that.data("id")
                };
                diseaseDoctorArr.push(diseaseDoctor);

            }
        });
        return diseaseDoctorArr;
    }
</script>
</body>
</html>
