<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<%
    String staticPath=request.getContextPath();
%>
<head>
    <meta charset="utf-8">
    <title>H5 new</title>
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

</head>
<body>
<div style="margin: 0;">
    <blockquote class="layui-elem-quote">
        <form>
            <div class="layui-form-item" style="margin: 0;">
                <label class="layui-form-label layui-form-label-lg">页面名称</label>
                <div class="layui-input-inline"><input class="layui-input" placeholder="请输入页面名称" id="testjquery"
                                                       type="text" name="name"/></div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button lay-filter="search" class="layui-btn" lay-submit><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
                </div>
                <%--<div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalertnew()" type="button">新增</button>
                </div>--%>
                <div style="float: right">
                    <a href="javascript:" class="layui-btn" id="add">
                        <i class="layui-icon">&#xe608;</i> 新增
                    </a>
                </div>
            </div>
        </form>
    </blockquote>
    <div style="width: 100%;">
        <table class="site-table table-hover">
            <thead>
            <tr>
                <th width="30px">序号</th>
                <th>页面名称</th>
                <th>CODE</th>
                <th>网址</th>
                <th width="75px">操作</th>
            </tr>
            </thead>
            <!--内容容器-->
            <tbody id="con">

            </tbody>
        </table>
        <!--分页容器-->
        <div id="paged" class="new-btable-paged"></div>
    </div>
</div>
<!--模板-->
<script type="text/html" id="conTemp">
    {{# if(d.list!=null && d.list.length>0){}}
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;"><input type="hidden" value='{{ item.id }}'/></td>
        <td>{{index+1}}</td>
        <td data-field='content'>{{ item.content }}</td>
        <td>{{ item.code }}</td>
        <td>{{ item.url }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" data-action="edit" data-id="{{item.id}}" id="edit" type="button">编辑</button>
            <button class="layui-btn layui-btn-mini layui-btn-danger" data-action="delete" data-id="{{item.id}}" id="delete" type="button">删除</button>
        </td>
    </tr>
    {{# }); }}
    {{#}}}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script type="text/javascript">
        layui.config({
            base: '<%=staticPath%>/static/js/'
        }).use(['paging','laytpl','form','layer','element'], function () {
            var laytpl=layui.laytpl,form=layui.form(),layer=layui.layer,
                element = layui.element(),$=layui.jquery,
                    paging = layui.paging();

            paging.init({
                openWait: true,
                url: '<%=staticPath%>/doctor/H5List/get', //地址
                elem: '#con', //内容容器
                type: 'post',
//                params: { //发送到服务端的参数
//                    id: layui.jquery("#testjquery").val(),
                    //	token:'F8F5AE2137BFAEF77FF7408476AF6C64',
//                    pageIndex: 1
//                },
                paged:true,
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 10 //分页大小
                },
                success: function () { //渲染成功的回调
                    $('#con').children('tr').each(function () {
                        $(this).children('td:last-child').children('button').each(function () {
                            var $that = $(this);
                            var action = $that.data('action');
                            var id = $that.data('id');
                            $that.on('click', function () {
                                switch (action) {
                                    case 'edit'://编辑
                                        layer.open({
                                            title: '编辑H5',
                                            type: 2,
                                            content: '<%=staticPath%>/doctor/toEditH5/'+id,
                                            area: ['800px', '500px'],
                                            shadeClose: true,
                                            btn:['保存','取消'],
                                            yes: function(index,layero) {
                                                //触发表单的提交事件
//                                                $('form.layui-form').find('button[lay-filter=edit]').click();
                                                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                                                var params=iframeWin.getParams();
                                                $.ajax({
                                                    url:'<%=staticPath%>/doctor/H5/add',
                                                    dataType:'json',
                                                    type:'post',
                                                    contentType:'application/json',
                                                    data:JSON.stringify(params),
                                                    success:function (result) {
                                                        if (result.code==200){
                                                            layer.msg("添加成功",{icon:1});
//                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
//                                parent.layer.close(index); //再执行关闭
                                                            layer.close(index);

                                                        }else
                                                            layer.msg("添加失败",{icon:2});
                                                    },
                                                    error:function (result) {
                                                        layer.msg("添加失败",{icon:2});

                                                    }
                                                });
                                            },
//
                                            success:function (layero,index) {
                                                console.log("编辑");

                                               /* var form = layui.form();
                                                form.render();

                                                form.on('submit(edit)',function (data) {
                                                    data.field.id=id;
                                                    $.ajax({
                                                        url:'<%=staticPath%>/doctor/H5/add',
                                                        dataType:'json',
                                                        type:'post',
                                                        contentType:'application/json',
                                                        data:JSON.stringify(data.field),
                                                        success:function (result) {
                                                            if (result.code==200){
                                                                layer.msg("修改成功",{icon:1});
//                                                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
//                                                                parent.layer.close(index); //再执行关闭
                                                                layer.close(index);
                                                            }else
                                                                layer.msg("修改失败",{icon:2});
                                                        },
                                                        error:function (result) {
                                                            layer.msg("修改失败",{icon:2});

                                                        }
                                                    });
                                                    return false;
                                                });*/
                                            },
                                            cancel:function (index,layero) {
                                                layer.close(index);
                                            },
                                            end:function (index) {
                                                location.reload(true);
                                            }
                                        });
                                        break;
                                    case 'delete': //删除
                                        var name = $that.parent('td').siblings('td[data-field=content]').text();
                                        layer.confirm('确定要删除页面[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' },
                                            function (index, layero) {
                                                //触发表单的提交事件
//                                                $('form.layui-form').find('button[lay-filter=edit]').click();
                                                $.ajax({
                                                    url: '<%=staticPath%>/doctor/H5/delete/'+id,
                                                    dataType: 'json',
                                                    type: 'get',
                                                    contentType: 'application/json',
                                                    success: function (result) {
                                                        if (result.code == 200) {
                                                            layer.msg("删除成功", {icon: 1});
//                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
//                                parent.layer.close(index); //再执行关闭
                                                            location.reload(true);
                                                        } else
                                                            layer.msg("删除失败", {icon: 2});
                                                    },
                                                    error: function (result) {
                                                        layer.msg("删除失败", {icon: 2});

                                                    }
                                                });
                                            },
//
                                            function (index) {
                                                location.reload(true);
                                            }
                                        );
                                        break;
                                }
                            });
                        });
                    });
                },
                fail: function (msg) { //获取数据失败的回调
                    //	alert('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	alert('处理完成');
                },
            });

            //监听搜索表单的提交事件
            form.on('submit(search)', function (data) {
                paging.get({
                    name:$('input[name=name]').val()
                });
                return false;
            });
    $('#add').on('click',function() {
        layer.open({
            title:'添加H5',
           type:2,
           content:'<%=staticPath%>/doctor/toAddH5',
            area: ['800px', '500px'],
            shadeClose: true,
            btn:['保存','取消'],
            yes: function(index,layero) {
                //触发表单的提交事件
//                $('form.layui-form').find('button[lay-filter=add]').click();
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                var params=iframeWin.getParams();
                $.ajax({
                    url:'<%=staticPath%>/doctor/H5/add',
                    dataType:'json',
                    type:'post',
                    contentType:'application/json',
                    data:JSON.stringify(params),
                    success:function (result) {
                        if (result.code==200){
                            layer.msg("添加成功",{icon:1});
//                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
//                                parent.layer.close(index); //再执行关闭
                            layer.close(index);

                        }else
                            layer.msg("添加失败",{icon:2});
                    },
                    error:function (result) {
                        layer.msg("添加失败",{icon:2});

                    }
                });
            },
            success:function (index) {
                var form = layui.form();
                form.render();

                /*form.on('submit(add)', function (data) {
               console.log("添加");

                    return false;
                });*/
            },
            cancel:function (index) {
                layer.close(index);
            }
        });
    });
        })


</script>
</body>

</html>