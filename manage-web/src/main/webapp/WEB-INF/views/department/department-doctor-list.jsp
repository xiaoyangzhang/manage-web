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
    <title>科室成员</title>
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
    <div class="layui-whole">
        <blockquote class="layui-elem-quote">当前位置:科室成员</blockquote>
        <blockquote class="layui-elem-quote">
            <a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>
            <a href="javascript:location.href=location.href;" style="float: right" id="refresh" class="layui-btn layui-btn-normal">刷新</a>
        </blockquote>
        <div class="layui-whole-con">
            <div id="content" style="width: 100%;height: 100%;">
                <input type="hidden" value="${id}" id="deptId" />
                <table class="layui-table">
                    <thead class="">
                        <th>序号</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>职务</th>
                        <th>职称</th>
                        <th>加入时间</th>
                        <th>是否管理员</th>
                        <th>操作</th>
                    </thead>
                    <tbody id="dept-doctor"></tbody>
                </table>
            </div>
        </div>
        <div class="layui-fixed-btn">
            <div class="layui-form-item">
                <button id="create"  class="layui-btn layui-btn-normal" >新建成员</button>
                <button id="add"  class="layui-btn layui-btn-normal" >添加成员</button>
                <%--<a href="javascript:history.back(-1);" style="float: right" class="layui-btn layui-btn-normal">返回</a>--%>
            </div>
        </div>
    </div>

<script type="text/html" id="dept-doctor-tpl">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td>{{index+1}}</td>
        <td>{{ item.username }}</td>
        <td data-field="name">{{ item.realname }}</td>
        <td>{{ item.sex==1?'男':'女' }}</td>
        <td>{{ item.duty }}</td>
        <td>{{ item.title }}</td>
        <td>{{ item.createTime }}</td>
        <td>{{ item.isAdmin==1?'否':'是' }}</td>
        <td>
            <a href="javascript:" data-action="delete"  data-opt="delete" data-id="{{item.departDoctorId}}" class="layui-btn layui-btn-mini layui-btn-danger">删除</a>
            {{# if(item.isAdmin==2){}}
            <a href="javascript:" data-action="dismiss"   data-opt="dismiss" data-id="{{item.departDoctorId}}" class="layui-btn layui-btn-mini">取消管理员</a>
            {{# } else if(item.isAdmin==1){}}
            <a href="javascript:" data-action="appoint"   data-opt="appoint" data-id="{{item.departDoctorId}}" class="layui-btn layui-btn-mini">指定管理员</a>
            {{# };}}
        </td>
    </tr>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >

    layui.config({
       base:'<%=staticPath%>/static/js/'
    }).use(['form','tab','layer','element','laytpl'],function () {
            var form = layui.form(),
            layer=layui.layer,
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象

            element = layui.element();
            laytpl=layui.laytpl;
            $.ajax({
            url:'<%=staticPath%>/department/deptDoctors/get/'+$("#deptId").val(),
            type:'get',
            dataType:'json',
            success:function (data) {
                laytpl($('#dept-doctor-tpl').html()).render(data,function (html) {
                    $('#dept-doctor').html(html);
                });
                //绑定每条记录事件
                $('#dept-doctor').children('tr').each(function () {
                    $(this).children('td:last-child').children('a').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        var name = $that.parent('td').siblings('td[data-field=name]').text();

                        $that.on('click', function () {
                            switch (action) {
                                case 'delete':
                                    layer.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
                                        $.ajax({
                                            url:'<%=staticPath%>/doctor/deptDoctor/delete/'+id,
                                            type:'get',
                                            dataType:'json',
                                            success:function (result) {
                                                if (result.code==200) {
                                                    layer.msg("删除成功",{icon:1});
                                                    location.reload();
                                                }
                                                else
                                                    layer.msg("删除失败",{icon:2});
                                            },
                                            error:function (result) {
                                                layer.msg("删除失败",{icon:2});
                                            }
                                        });
                                        layer.close(index);
                                    });
                                    break;
                                case 'dismiss':
                                    $.ajax({
                                        url:'<%=staticPath%>/doctor/dismissAdmin/'+id,
                                        type:'get',
                                        dataType:'json',
                                        success:function (result) {
                                            if (result.code==200) {
                                                layer.msg("撤销成功",{icon:1});
                                                location.reload();
                                            }
                                            else
                                                layer.msg("撤销失败",{icon:2});
                                        },
                                        error:function (result) {
                                            layer.msg("撤销失败",{icon:2});
                                        }
                                    });
                                    break;
                                case 'appoint':
                                    $.ajax({
                                        url:'<%=staticPath%>/doctor/appointAdmin/'+id,
                                        type:'get',
                                        dataType:'json',
                                        success:function (result) {
                                            if (result.code==200) {
                                                layer.msg("指定成功",{icon:1});
                                                location.reload();
                                            }
                                            else
                                                layer.msg("指定失败",{icon:2});
                                        },
                                        error:function (result) {
                                            layer.msg("指定失败",{icon:2});
                                        }
                                    });
                                    break;
                            }
                        });
                    });
                });
            },
            error:function (data) {
                console.log("渲染失败");
            }
        });
            //创建成员
            $('#create').on('click',function () {
                layer.open({
                    type:2,
                    content:'<%=staticPath%>/doctor/toAddDoctor/'+$("#deptId").val(),
                    shadeClose:true,
                    btn:['保存','取消'],
                    title:'新建科室成员',
                    area:['600','400'],
                    yes:function (index,layero) {
                       var iframeWin = window[layero.find('iframe')[0]['name']];
                       var params=iframeWin.getParams();
                        if(params.strongpoint.length >255) {
                            layer.msg('医生擅长最多255个字符',{icon:5});
                            return false;
                        }
                        if(params.strongpoint.length >255) {
                            layer.msg('医生简介最多255个字符',{icon:5});
                            return false;
                        }
                       $.ajax({
                           url:'<%=staticPath%>/doctor/doctor/add',
                           type:'post',
                           dataType:'json',
                           data:JSON.stringify(params),
                           contentType:'application/json',
                           success:function (result) {
                               if (result.code==200) {
                                   layer.msg("创建成功",{icon:1});
                                   layer.close(index);
                                   location.reload();
                               }else if(result.code==201){
                                   layer.msg(result.msg,{icon:5});
                               }
                               else{
                                   layer.msg("创建失败",{icon:2});
                               }
                           },
                           error:function (result) {
                               layer.msg("创建失败",{icon:2});
                           }
                       });
                    } ,
                    cancel:function (index) {
                        layer.close(index);
                    }
                });
            });
            //添加成员
            $('#add').on('click',function () {
                layer.open({
                    type:2,
                    content:'<%=staticPath%>/doctor/toDeptDoctorList/'+$("#deptId").val(),
                    shadeClose:true,
                    btn:['保存','取消'],
                    title:'添加成员（已认证医生）',
                    area:['600','400'],
                    offset:'b',
                    yes:function (index,layero) {
                        var iframeWin = window[layero.find('iframe')[0]['name']];
                        var deptDoctorArr=iframeWin.getSelectedDoctors();
                        $.ajax({
                            url:'<%=staticPath%>/department/deptDoctor/add',
                            type:'post',
                            dataType:'json',
                            data: {
                                deptDoctorArr:JSON.stringify(deptDoctorArr)
                            },
//                           contentType:'application/json',
                            success:function (result) {
                                if (result.code==200){
                                    layer.msg("添加成功",{icon:1});
                                    layer.close(index);
                                    location.reload(true);
                                }
                                else
                                    layer.msg("添加失败",{icon:2});
                                },
                            error:function (result) {
                                layer.msg("添加失败",{icon:2});
                            }
                        });
                    } ,
                    cancel:function (index) {
                        layer.close(index);
                    }
                });
            });
        /*var params={
            username:$("input[name='username']").val(),
            realname:$("input[name='realname']").val(),
            registerTimeStart:$("#registerTimeStart").val(),
            registerTimeEnd:$("#registerTimeEnd").val()
        };
        tab = layui.tab({
            elem: '.admin-nav-card' //设置选项卡容器
            ,
            //maxSetting: {
            //	max: 5,
            //	tipMsg: '只能开5个哇，不能再开了。真的。'
            //},
            contextMenu: true,
            onSwitch: function (data) {
                console.log(data.id); //当前Tab的Id
                console.log(data.index); //得到当前Tab的所在下标
                console.log(data.elem); //得到当前的Tab大容器

                console.log(tab.getCurrentTabId())
            },
            closeBefore: function (obj) { //tab 关闭之前触发的事件
                console.log(obj);
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
        });

            btable.set({
            openWait: true,//开启等待框
            elem: '#content',
            pageSize: 5,//页大小
            params:params,
            type:'post',
            columns:[{
                fieldName:'用户名',
                field:'username'
            },{
                fieldName:'姓名',
                field:'realname'
            },{
                fieldName:'性别',
                field:'sex',
                format:function (val,obj) {
                    if (obj.sex==1)
                        return "男";
                    else if (obj.sex==2)
                        return "女";
                    else
                        return "其他";
                }
            },{
                fieldName:'职务',
                field:'duty'
            },{
                fieldName:'职称',
                field:'title'
            },{
                fieldName:'加入时间',
                field:'createTime'
//                format:function (val,obj) {
                    <%--var html='<fmt:formatDate value="'+obj.createTime+'" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>';--%>
//                    return html;
//                }
            },{
                fieldName:'是否为管理员',
                field:'isAdmin',
                format:function (val,obj) {
                    if (obj.isAdmin==1)
                        return "否";
                    else if (obj.isAdmin==2)
                        return "是";
                }
            }, {
                fieldName: '操作',
                field: 'departDoctorId',
                format: function (val,obj) {
                    var html = '<input type="button" value="删除" lay-filter="delete" data-action="delete" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ' +
                        '<input type="button" value="取消管理员" lay-filter="revert" data-action="revert" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                    return html;
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
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        $that.on('click', function () {
                            switch (action) {
                                case 'delete'://编辑
                                    console.log("触发查看");
                                    var name = $that.parent('td').siblings('td[data-field=name]').text();
                                    //询问框
                                    layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
                                        $that.parent('td').parent('tr').remove();
                                        layer.open({
                                            title: '编辑用户',
                                            type: 2,
                                            content: '<%=staticPath%>/doctor/doctor/'+id,
                                            area: ['800px', '500px'],
                                            shadeClose: true,
                                            btn:['确认','取消'],
                                            yes:function (index,layero) {
                                                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                                var params=iframeWin.getParams();
                                                params.id=id;
                                                $.ajax({
                                                    type:'post',
                                                    url:'<%=staticPath%>/doctor/editDoctor',
                                                    data:{
                                                        doctorStr:JSON.stringify(params)
                                                    },
                                                    dataType:'json',
                                                    success:function (data) {
                                                        if (data.code=200)
                                                            layerTips.msg('删除成功.');
                                                        else
                                                            layerTips.msg("删除失败")
                                                    },
                                                    error:function (data) {
                                                        layerTips.msg("删除失败");
                                                    }
                                                });
                                            },
                                            cancel:function (index,layero) {
                                                layer.close(index);
                                            }
                                        });
                                    });
                                    break;
                                case 'revert': //详情
                                    console.log("点击详情");

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
*/

    });
</script>
</body>
</html>
