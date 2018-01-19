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
    <title>医生列表</title>
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
    <%--<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="../../../static/plugins/laydate/laydate.js"></script>--%>
</head>
<body>
<div style="background-color: white; margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <%--<input type="hidden" name="id" value="${id}" />--%>
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-md">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="username" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="realname" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">注册时间</label>
                <div class="layui-input-inline">
                    <input type="text" id="registerTimeStart" placeholder="yyyy-mm-dd"  name="registerTimeStart" autocomplete="off"   class="layui-input">
                </div>
                  <div class="layui-input-inline">
                      <input type="text" id="registerTimeEnd" placeholder="yyyy-mm-dd"  name="registerTimeEnd" autocomplete="off"  class="layui-input">
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

<script >
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
         $("#registerTimeStart").click(function () {
              start.elem=this;
              laydate(start);
         });
        $("#registerTimeEnd").click(function () {
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
            element = layui.element(),$=layui.jquery;

        tab = layui.tab({
            elem: '.admin-nav-card', //设置选项卡容器
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
            url: '<%=staticPath%>/doctor/doctorList', //数据源地址
            pageSize: 20,//页大小
//            params:params,
            type:'post',
            columns:[
                {
                   fieldName:'用户名',
                   field:'username'
                },
                {
                    fieldName:'姓名',
                    field:'realname'
                },
                {
                    fieldName:'性别',
                    field:'sex',
                    format:function (val,obj) {
                       if (obj){

                        if (obj.sex==1)
                            return "男";
                        else if (obj.sex==2)
                            return "女";
                       }
                        return "";
                    }
                },
                {
                    fieldName:'出生日期',
                    field:'birthday'
                },
                {
                    fieldName:'资格认证',
                    field:'state',
                    format:function (val,obj) {
                        if (obj){
                            if (obj.state == 1)
                            return "未认证";
                        if (obj.state==2)
                            return "已认证";
                        }
                        return "";
                    }
                },
                {
                    fieldName:'注册时间',
                    field:'createTime'
                },
                {
                    fieldName:'上次登录时间',
                    field:'lastTime'
                },
                {
                    fieldName: '操作',
                    width:85,
                    field: 'id',
                    format: function (val,obj) {
                        var edit = detail = '';
                        if(window.parent.setPermissions($,"doctor:list:edit")){
                            edit = '<input type="button" value="编辑" lay-filter="edit" data-action="edit" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                        }
                        if(window.parent.setPermissions($,"doctor:list:view")){
                            detail = '<input type="button" value="详情" lay-filter="detail" data-action="view" data-id="' + val + '" class="layui-btn layui-btn-mini " />';
                        }
                        return edit+detail;
                    }
                }
            ],
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
                                case 'edit'://编辑
                                    layer.open({
                                        title: '编辑用户',
                                        type: 2,
                                        content: '<%=staticPath%>/doctor/doctor/'+id,
                                        area: ['800px', '500px'],
                                        shadeClose: true,
                                        btn:['保存','取消'],
                                        yes:function (index,layero) {
                                            var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                            var params=iframeWin.getParams();
//                                            params+=("&id="+id);
                                            params.id=id;
                                            if(params.strongpoint.length >255) {
                                                layer.msg('医生擅长最多255个字符',{icon:5});
                                                return false;
                                            }
                                            if(params.summary.length >255) {
                                                layer.msg('医生简介最多255个字符',{icon:5});
                                                return false;
                                            }
                                            $.ajax({
                                                type:'post',
                                                url:'<%=staticPath%>/doctor/editDoctor',
//                                                data:{
//                                                    doctorStr:JSON.stringify(params)
//                                                },
                                                data:JSON.stringify(params),
                                                dataType:'json',
                                                contentType:'application/json',
                                                success:function (data) {
                                                    console.log(data);
                                                    if (data.code == 200){
                                                        layer.msg("保存成功");
                                                        layer.close(index);
                                                }else
                                                        layer.msg("保存失败")
                                                },
                                                error:function (data) {
                                                    layer.msg("保存失败");
                                                }
                                            });
                                        },
                                        cancel:function (index,layero) {
                                            layer.close(index);
                                        },
                                        end:function (index) {
//                                            location.reload(true);
                                            btable.get({
                                                username:$('input[name=username]').val(),
                                                realname:$('input[name=realname]').val(),
                                                registerTimeStart:$('#regiserTimeStart').val(),
                                                registerTimeEnd:$('#registerTimeEnd').val()
                                            });
                                        }
                                    });
                                    break;
                                case 'view': //详情
                                    location.href='<%=staticPath%>/doctor/toDoctorInfo/'+id;
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
