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
    <title>医院列表</title>
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
                <div style="float: right">
                    <a href="javascript:" class="layui-btn" id="add">
                        <i class="layui-icon">&#xe608;</i> 添加医院
                    </a>
                </div>
            </div>

        </form>
    </blockquote>
    <div id="content" style="width: 100%;height: 533px;"></div>
</div>
<script type="text/html" id="cityTpl">
    {{# layui.each(d.list, function(index, item){ }}

    <option value="{{item.id}}">{{item.name}}</option>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >

    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['btable','form','tab','layer','laytpl','jquery'],function () {
        var imgUrl="<%=imgUrl%>";
        var btable = layui.btable(),
            form = layui.form(),
            laytpl=layui.laytpl,
            layer=layui.layer,$=layui.jquery;

        if(!window.parent.setPermissions($,"hospital:list:add")){
            $('#add').css('display','none');
        }

       /* tab = layui.tab({
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
            url: '<%=staticPath%>/hospital/hospitalList', //数据源地址
            pageSize: 20,//页大小
            type:'post',
            columns:[{
                fieldName:'图标',
                width:30,
                field:'logo',
                format:function (val,obj) {
                    var html="";
                    if(obj && obj.logo!=null && obj.logo.length>0)
                        html= '<img height="15px" width="15px" src="'+obj.logo+'" />';
                    return html;
                }
            },{
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
            },{
                fieldName:'简介',
                field:'summary'
            },{
                fieldName:'医院信息',
                width:85,
                field:'id1',
                format: function (val,obj) {
                    var edit = detail = '';
                    if(window.parent.setPermissions($,"hospital:list:view")){
                        detail = '<input type="button" value="查看" lay-filter="view" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    }
                    if(window.parent.setPermissions($,"hospital:list:edit")){
                        edit = '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                    }
                    return detail+edit;
                }
            }, {
                fieldName: '签约科室',
                width:55,
                field: 'id2',
                format: function (val,obj) {
                    var html = '<input type="button" value="查看" lay-filter="view1" data-action="view1" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    if(window.parent.setPermissions($,"hospital:list:department")){
                        return html;
                    }else{
                        return "";
                    }
                }
            }],
            even: true,//隔行变色
            field: 'id', //主键ID
            //skin: 'row',
            checkbox: false,//是否显示多选框
            paged: true, //是否显示分页
            singleSelect: false, //只允许选择一行，checkbox为true生效
            onSuccess:function ($elem) {
                $elem.children('tr').each(function () {
                    $(this).children('td:last-child').prev().children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        $that.on('click', function () {
                            switch (action) {
                                case 'edit'://编辑
                                    console.log("编辑请求");
                                    layer.open({
                                        title: '编辑医院',
                                        type: 2,
                                        content: '<%=staticPath%>/hospital/hospital/get/'+id,
                                        area: ['800px', '500px'],
                                        shadeClose: true,
                                        btn:['保存','取消'],
                                        yes:function (index,layero) {
                                            var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                            var params=iframeWin.getParams();
                                            params.id=id;
                                            if(params.summary.length >255) {
                                                layer.msg('医院简介最多255个字符',{icon:5});
                                                return false;
                                            }
                                            $.ajax({
                                                url:'<%=staticPath%>/hospital/editHospital',
                                                type:'post',
                                                dataType:'json',
                                                data:JSON.stringify(params),
                                                contentType:'application/json',
                                                success:function (data) {
                                                    if (data.code == 200) {
                                                        layer.msg("修改医院成功",{icon:1});
                                                        layer.close(index);
//                                                        location.reload(true);
                                                        btable.get({
                                                            name:$('input[name=name]').val(),
                                                            provinceCode:$("select[name=provinceCode]").val(),
                                                            cityCode:$('select[name=cityCode]').val()
                                                        });
                                                    }
                                                    else
                                                        layer.msg("修改医院失败",{icon:2});

                                                },
                                                error:function (data) {
                                                    layer.msg("修改医院失败",{icon:2});
                                                }
                                            });
                                        },
                                        cancel:function (index,layero) {
                                            layer.close(index);
                                        }
                                    });
                                    break;
                                case 'view': //详情
                                    console.log("查看请求");
                                    layer.open({
                                        title: '查看医院',
                                        type: 2,
                                        content: '<%=staticPath%>/hospital/hospital/get/'+id,
                                        area: ['800px', '500px'],
                                        shadeClose: true,
                                        btn:['关闭']
                                    });
                                    break;
                            }
                        });
                    });
                });
                $elem.children('tr').each(function () {
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        $that.on('click', function () {
                                    console.log("触发查看");
                                    /*layer.open({
                                        title: '编辑用户',
                                        type: 2,
                                        area: ['800px', '500px'],
                                        shadeClose: true
                                    });*/
                                    location.href="<%=staticPath%>/department/toDepartmentList/"+id;
                        });
                    });
                });
            }
        });
        btable.render();
        form.on('select(province)',function (data) {
//            $("select[name=provinceCode]").prepend("<option value=''>请选择省</option>");
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

        $('#add').on('click',function () {
        layer.open({
            type:2,
            area:['800px','500px'],
            content:'<%=staticPath%>/hospital/toAddHospital',
            shadeClose:true,
            btn:['保存','取消'],
            title:'添加医院',
            yes:function (index,layero) {
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                var params=iframeWin.getParams();
//                params.id=id;
                if(params.summary.length >255) {
                    layer.msg('医院简介最多255个字符',{icon:5});
                    return false;
                }
                $.ajax({
                    url:'<%=staticPath%>/hospital/addHospital',
                    type:'post',
                    dataType:'json',
                    data:JSON.stringify(params),
                    contentType:'application/json',
                    success:function (data) {
                        if (data.code=='200') {
                            layer.msg("添加医院成功",{icon:1});
                            layer.close(index);
                            btable.get({
                                name:$('input[name=name]').val(),
                                provinceCode:$("select[name=provinceCode]").val(),
                                cityCode:$('select[name=cityCode]').val()
                            });
                        }
                        else
                            layer.msg("添加医院失败",{icon:2});

                    },
                    error:function (data) {
                        console.log("添加医院失败",{icon:2});
                    }
                });
            },
            cancel:function (index,layero) {
                layer.close(index);
            }

        });
    });
    });

</script>
</body>
</html>
