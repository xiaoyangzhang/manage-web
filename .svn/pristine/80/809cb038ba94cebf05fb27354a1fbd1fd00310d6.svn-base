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
    <title>黑名单列表</title>
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
        <form class="layui-form">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-lg">注册时间</label>
                <div class="layui-input-inline">
                    <input type="text" id="regiserTimeStart" placeholder="yyyy-mm-dd"  name="regiserTimeStart" autocomplete="off"   class="layui-input">
                </div>
                <div class="layui-input-inline">
                    <input type="text" id="registerTimeEnd" placeholder="yyyy-mm-dd"  name="registerTimeEnd" autocomplete="off"  class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-md">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="username" placeholder="支持模糊查询.." autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
            </div>
        </form>
    </blockquote>
    <div id="content" style="width: 100%;"></div>
</div>
<%-- 移除黑名单弹出层		--%>
<div style="display: none" id="blackDiv">
    <form id="form2" class="layui-form layui-form-mid">
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-sm">原因</label>
            <div class="layui-input-inline">
                <textarea  name="reason" lay-verify="contact" autocomplete="off" class="layui-textarea" style="width: 340px;height: 100px;resize: none;"></textarea>
            </div>
        </div>
        <button lay-filter="removeBlack" lay-submit style="display: none;"></button>
    </form>
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
         $("#regiserTimeStart").click(function () {
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
    }).use(['btable','form','tab','layer','element','jquery'],function () {
        var btable = layui.btable(),
            form = layui.form(),
            layer=layui.layer,
            element=layui.element(),$=layui.jquery;

        //自定义验证规则
        form.verify({
            contact: function(value){
                if(value.length < 5){
                    return '内容请输入至少5个字符';
                }
                if(value.length > 300){
                    return '内容不能多于300个字符';
                }
            }
        });

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
            url: '<%=staticPath%>/doctor/getBlacklist', //数据源地址
            pageSize: 5,//页大小
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
                    if (obj){
                        if (obj.sex==1)
                            return "男";
                        else if (obj.sex==2)
                            return "女";
                        else
                            return "其他";
                    }
                    return "";
                }
            },{
                fieldName:'年龄',
                field:'age',
                format:function (val,obj) {
                    if(obj==null || obj==undefined){
                        return "";
                    }else {

                        var now=new Date();
                        var birthday=obj.birthday;
                        var birthday=obj.birthday.replace("/-/g","/");
                        var result=now.getFullYear()-new Date(birthday).getFullYear()+1;
                        return result?result:"";
                    }
                }
            },{
                fieldName:'原因',
                field:'reason'
            },{
                fieldName:'时间',
                field:'operatorTime'
            },{
                fieldName:'处理人',
                field:'operator'
            }, {
                fieldName: '操作',
                width:35,
                field: 'id',
                format: function (val,obj) {
                    var html="";
                    if(obj==null || obj==undefined){
                        html = '<input type="button" value="移除" lay-filter="remove" data-action="remove" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    }else {
                        html = '<input type="button" data-type="'+obj.userType+'" value="移除" lay-filter="remove" data-action="remove" data-id="' + val + '" class="layui-btn layui-btn-mini" /> ';
                    }
                    if(window.parent.setPermissions($,"doctorblacklist:remove")){
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
                    $(this).children('td:last-child').children('input').each(function () {
                        var $that = $(this);
                        var action = $that.data('action');
                        var id = $that.data('id');
                        var type = $that.data('type');
                        var sysBlacklist={
                          userId:id,
                          userType:2
                        };
                        $that.on('click', function () {
                            /*$.ajax({
                                url:'<%=staticPath%>/doctor/blacklist/operate',
                                type:'post',
                                contentType:'application/json',
                                dataType:'json',
                                data:JSON.stringify({
                                    sysBlacklist:sysBlacklist,
                                    operateTpye:'remove'
                                }),
                                success:function (result) {
                                    if(result.code==200){
                                        layer.msg("移除成功");
                                        location.reload(true);
                                    }
                                    else {
                                        layer.msg("移除失败");
                                    }
                                },
                                error:function (result) {
                                    layer.msg("移除失败");
                                }
                            });*/
                            layer.open({
                                type:1,
                                title:'移除黑名单',
                                content:$('#blackDiv'),
                                area:['400px','250px'],
                                shadeClone:true,
                                btn:['确认','取消'],
                                yes:function (index,layero) {
                                    $('#form2').find('button[lay-filter=removeBlack]').click();
                                },
                                success:function (layero,index) {
                                    var form=layui.form();
                                    form.render();
                                    form.on('submit(removeBlack)',function (data) {
                                        sysBlacklist.reason=data.field.reason;
                                        $.ajax({
                                            type: 'post',
                                            url: '<%=staticPath%>/doctor/blacklist/operate',
                                            data: JSON.stringify({
                                                sysBlacklist: sysBlacklist,
                                                operateTpye: 'remove'
                                            }),
                                            dataType: 'json',
                                            contentType: 'application/json',
                                            success: function (data) {
                                                if (data.code == 200) {
                                                    layer.close(index);
                                                    layer.msg("移除黑名单成功",{icon:1});
                                                    location.reload(true);
                                                }
                                                else
                                                    layer.msg("移除黑名单失败",{icon:2})
                                            },
                                            error: function (data) {
                                                layer.msg("移除黑名单失败",{icon:2});
                                            }
                                        });
                                    });
                                },
                                end:function (index) {
                                  btable.get({
                                      regiserTimeStart:$("input[name=regiserTimeStart]").val(),
                                      registerTimeEnd:$("input[name=registerTimeEnd]").val(),
                                    uername:$("input[name=username]").val()
                                  });
                                },
                                cancel:function (index,layero) {
                                    layer.close(index);
                                }
                            });
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
