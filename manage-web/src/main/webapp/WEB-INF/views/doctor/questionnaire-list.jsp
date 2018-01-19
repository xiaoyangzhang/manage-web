<%--
  Created by IntelliJ IDEA.
  User: zhangxiaoyang
  Date: 2017/8/7
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <title>问卷列表</title>
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
        <form class="layui-form" id="">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-lg">搜索问卷</label>
                <div class="layui-input-inline">
                    <input type="text" name="title" placeholder="请输入问卷名称" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">一级科室</label>
                <div class="layui-input-inline">
                    <select name="levelOnedictDeptId" lay-filter="levelOneDept">
                        <option value="">请选择一级科室</option>
                        <c:forEach items="${list}" var="dept">

                            <option value="${dept.parentCode}" >${dept.parentName}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-lg">二级科室</label>
                <div class="layui-input-inline">
                    <select name="levelTwodictDeptId" lay-filter="levelTwoDept" class="">
                        <option value="">请选择二级科室</option>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
                <div>
                    <a class="layui-btn" id="add">
                        <i class="layui-icon">&#xe608;</i> 创建问卷
                    </a>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;">

    </div>
</div>
<script type="text/html" id="deptTpl">
    {{# layui.each(d.list, function(index, item){ }}

    <option value="{{item.id}}">{{item.childName}}</option>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >

    layui.config({
       base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','layer','element','jquery','laytpl'],function () {
        var btable = layui.btable(),
            form = layui.form(),
            layer=layui.layer,
            element = layui.element(),laytpl=layui.laytpl,
            $=layui.jquery;

        /*tab = layui.tab({
            elem: '.admin-nav-card', //设置选项卡容器
            contextMenu: true,
            onSwitch: function (data) {
                console.log(data.id); //当前Tab的Id
                console.log(data.index); //得到当前Tab的所在下标
                console.log(data.elem); //得到当前的Tab大容器

                console.log(tab.getCurrentTabId())
            },
            closeBefore: function (obj) { //tab 关闭之前触发的事件
                if (obj.title === 'BTable') {
                    layer.confirm('确定要关闭' + obj.title + '吗?', { icon: 3, title: '系统提示' }, function (index) {
                        //因为confirm是非阻塞的，所以这里关闭当前tab需要调用一下deleteTab方法
                        tab.deleteTab(obj.tabId);
                        layer.close(index);
                    });
                    //返回true会直接关闭当前tab
                    return false;
                }else if(obj.title==='表单'){
                    layer.confirm('未保存的数据可能会丢失哦，确定要关闭吗?', { icon: 3, title: '系统提示' }, function (index) {
                        tab.deleteTab(obj.tabId);
                        layer.close(index);
                    });
                    return false;
                }
                return true;
            }
        });*/


        btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            url: '<%=staticPath%>/questionnaire/query/list', //数据源地址
            pageSize: 20,//页大小
            type:'post',
            columns:[
                {fieldName:'标题', field:'title',width:'300',minWidth: 100},
                {fieldName:'所属科室', field:'deptName',minWidth: 100},
                {fieldName:'状态', field:'state',width:'80',minWidth: 80,
                    format:function (val,obj) {
                        if (obj){
                            if (obj.state == 2)
                                return "已发布";
                            else
                                return "未发布";
                        }
                        return "";
                    }
                },
                {fieldName:'创建时间', field:'updateTime',width:'140',minWidth: 140},
                {fieldName: '操作', width:140, field: 'id',minWidth: 140,
                    format: function (val,obj) {
                        var edit = down = dle = up = '';
                        if(window.parent.setPermissions($,"doctor:list:edit")){
                            edit = '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                        }
                        if(window.parent.setPermissions($,"doctor:list:view") && obj &&  obj.state==2){
                            down = '<input type="button" value="下架" lay-filter="down" data-action="down" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                        }
                       if(window.parent.setPermissions($,"doctor:list:view") && obj && (obj.state==1 || obj.state==3)){
                            up = '<input type="button" value="上架" lay-filter="up" data-action="up" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                        }
                        if(window.parent.setPermissions($,"doctor:list:view")){
                            dle = '<input type="button" value="删除" lay-filter="dle" data-action="dle" data-id="' + val + '" class="layui-btn layui-btn-mini layui-btn-danger" />';
                        }
                        return edit+down+up+dle;
                    }
                }
            ],
            even: true,//隔行变色
            field: 'id', //主键ID
            checkbox: false,//是否显示多选框
            singleSelect: false, //只允许选择一行，checkbox为true生效
            paged: true, //是否显示分页
            onSuccess:function ($elem) {
                $elem.children('tr').each(function () {
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        $that.on('click', function () {
                            switch (action) {
                                case 'edit'://编辑
                                    location.href='<%=staticPath%>/questionnaire/toEditQuestionnaire/'+id;
                                    break;
                                case 'down': //下架
                                    layer.confirm('真的要下架吗?', { icon: 3, title: '系统提示' },
                                        function (index, layero) {
                                            //触发表单的提交事件
                                            $.ajax({
                                                url: "<%=staticPath%>/questionnaire/update/state/"+id+"/3",
                                                dataType: 'json',
                                                type: 'get',
//                                                contentType: 'application/json',
                                                success: function (result) {
                                                    if (result.code == 200) {
                                                        layer.msg("下架成功", {icon: 1});
//                                                        location.reload(true);
                                                        btable.get({
                                                            title:$("input[name=title]").val(),
                                                            levelOnedictDeptId:$("select[name=levelOnedictDeptId]").val(),
                                                        levelTwodictDeptId:$("select[name=levelTwodictDeptId]").val()
                                                        });

                                                    } else
                                                        layer.msg("下架失败", {icon: 2});
                                                },
                                                error: function (result) {
                                                    layer.msg("下架失败", {icon: 2});

                                                }
                                            });
                                        }
                                    );
                                    break;
                               case 'up': //上架
                                    layer.confirm('真的要上架吗?', { icon: 3, title: '系统提示' },
                                        function (index, layero) {
                                            //触发表单的提交事件
                                            $.ajax({
                                                url: "<%=staticPath%>/questionnaire/update/state/"+id+"/2",
                                                dataType: 'json',
                                                type: 'get',
//                                                contentType: 'application/json',
                                                success: function (result) {
                                                    if (result.code == 200) {
                                                        layer.msg("上架成功", {icon: 1});
//                                                        location.reload(true);
                                                        btable.get({
                                                            title:$("input[name=title]").val(),
                                                            levelOnedictDeptId:$("select[name=levelOnedictDeptId]").val(),
                                                            levelTwodictDeptId:$("select[name=levelTwodictDeptId]").val()
                                                        });

                                                    } else if(result.code==500)
                                                        layer.msg("上架失败", {icon: 2});
                                                    else
                                                        layer.msg(result.msg, {icon: 2});
                                                },
                                                error: function (result) {
                                                    layer.msg("上架失败", {icon: 2});

                                                }
                                            });
                                        }
                                    );
                                    break;
                                case 'dle': //删除
                                    layer.confirm('真的删除行吗?', { icon: 3, title: '系统提示' },
                                        function (index, layero) {
                                            //触发表单的提交事件
                                            $.ajax({
                                                url: "<%=staticPath%>/questionnaire/update/state/"+id+"/4",
                                                dataType: 'json',
                                                type: 'get',
//                                                contentType: 'application/json',
                                                success: function (result) {
                                                    if (result.code == 200) {
                                                        layer.msg("删除成功", {icon: 1});
//                                                        location.reload(true);
                                                        btable.get({
                                                            title:$("input[name=title]").val(),
                                                            levelOnedictDeptId:$("select[name=levelOnedictDeptId]").val(),
                                                            levelTwodictDeptId:$("select[name=levelTwodictDeptId]").val()
                                                        });
                                                    } else
                                                        layer.msg("删除失败", {icon: 2});
                                                },
                                                error: function (result) {
                                                    layer.msg("删除失败", {icon: 2});

                                                }
                                            });
                                        }
                                    );
                                    break;
                            }
                        });
                    });
                });
            }
        });
        btable.render();
        form.on('select(levelOneDept)',function (data) {
            var parentCode=data.value;
            /*if (parentCode ==-1 || parentCode==0||parentCode==-2){
                $("select[name=levelTwodictDeptId]").toggleClass("layui-disabled");
            }*/
            $.ajax({
                url:'<%=staticPath%>/dictPage/deptCats/query/'+parentCode,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('select[name=levelTwodictDeptId]').empty();
                    laytpl($('#deptTpl').html()).render(result,function (html) {
                        $('select[name=levelTwodictDeptId]').append('<option value="">请选择二级科室</option>'+html);
                    });
                    form.render('select');
                },
                error:function (result) {

                }
            });
        });

        //创建问卷
        $('#add').on('click',function () {
            location.href="<%=staticPath%>/questionnaire/toAddQuestionnaire";
        });
        //监听搜索表单的提交事件
        form.on('submit(search)', function (data) {
            console.log(data);
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