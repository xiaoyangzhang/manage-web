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
    <title>名医列表</title>
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

<div style="margin:0px; background-color: white;">
    <div class="layui-whole">
        <blockquote class="layui-elem-quote">
            <a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>
            <a href="javascript:location.href=location.href;" style="float: right" id="refresh" class="layui-btn layui-btn-normal">刷新</a>
            <a href="javascript:" class="layui-btn layui-btn-small" id="add" style="float: right;">
                <i class="layui-icon">&#xe608;</i> 添加名医
            </a>
            当前位置：编辑名医
        </blockquote>
        <div class="layui-whole-con">
            <input type="hidden" value="${id}" id="diseaseId" />
            <h2 class="layui-h2-title">疾病：${disease}</h2>
            <table class="layui-table" style="margin: 0;">
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>用户名</th>
                        <th>职称</th>
                        <th>医院</th>
                        <th>科室</th>
                        <th style="width: 130px;">操作</th>
                    </tr>
                </thead>
                <tbody id="content">
                </tbody>
            </table>
        </div>
        <div class="layui-fixed-btn">
            <div class="layui-form-item">
                <%--<a href="javascript:history.back(-1);" style="float: left" id="back" class="layui-btn layui-btn-normal">返回</a>--%>
                <button style="float: right" id="save" class="layui-btn layui-btn-normal">保存</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="doctorsTpl">
    {{# layui.each(d.list, function(index, item){ }}
    <tr data-id="{{item.doctorDiseaseId}}" id="tr{{index}}">
        <%--<td><input type="text" value="{{index+1}}" name="seq" style="width: 40px" class="layui-input" /></td>--%>
        <td>{{index+1}}</td>
        <td data-field="name">{{ item.realname }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.title }}</td>
        <td>{{item.hospitalName}}</td>
        <td>{{item.departmentName}}</td>
        <td>
            <a href="javascript:" data-opt="delete" class="layui-btn layui-btn-mini layui-btn-danger">删除</a>

            {{# if(d.list != null && d.list.length > 1){ }}
            {{# if(index > 0){ }}
            <a href="javascript:" data-opt="moveup" class="layui-btn layui-btn-mini">上移</a>
            <a href="javascript:" data-opt="movetop" class="layui-btn layui-btn-mini">置顶</a>
            <a href="javascript:" data-opt="movedown" style="display: none;" class="layui-btn layui-btn-mini">下移</a>
            {{# } else if(index ==0){ }}
            <a href="javascript:" data-opt="movedown"  class="layui-btn layui-btn-mini">下移</a>
            <a href="javascript:" data-opt="moveup" style="display: none;"  class="layui-btn layui-btn-mini">上移</a>
            <a href="javascript:" data-opt="movetop" style="display: none;"  class="layui-btn layui-btn-mini">置顶</a>
            {{# } }}
            {{# } }}

        </td>
    </tr>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script >
    layui.use(['layer', 'form','laytpl'], function() {
        var $ = layui.jquery,
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
            layer = layui.layer, //获取当前窗口的layer对象
            form = layui.form(),laytpl=layui.laytpl;
        $.ajax({
            url:'<%=staticPath%>/doctor/famousDoctor/query/'+$("#diseaseId").val(),
            type:'get',
            dataType:'json',
            success:function (data) {
                laytpl($('#doctorsTpl').html()).render(data,function (html) {
                    $('#content').html(html);
                });
                console.log("渲染成功");
        //绑定最后一列事件
       $('#content').children("tr").each(function (index) {
           var $that_tr=$(this);
           var diseaseDoctorId=$that_tr.data("id");
           $that_tr.children("td:last-child").children("a").each(function () {
               var $that_a=$(this);
               var action=$that_a.data("opt");
               $that_a.on('click',function (e) {
                   switch (action){
                       case 'delete':
                           var name = $that_a.parent('td').siblings('td[data-field=name]').text();
                           //询问框
                           layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
//                               $that.parent('td').parent('tr').remove();

//                               layerTips.msg('删除成功.');
                               $.ajax({
                                   url:'<%=staticPath%>/doctor/diseaseDoctor/delere/'+diseaseDoctorId,
                                   type:'get',
                                   dataType:'json',
                                   success:function (result) {
                                       if (result.code==200) {
                                           layer.msg("删除成功",{icon:1});
//                                            $that.parent('td').parent('tr').remove();
                                           layerTips.close(index);
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
                           },
                               function (index) {
                                   layer.close(index);
                               }
                           );
                           break;
                       case 'moveup':
                           console.log("上移");
                           var prev=$that_a.parents("tr").prev();
                           var prevIndex=$(prev).index('tr');
                           $that_a.parents("tr").insertBefore(prev);
//                           if($that_a.parents("tr").index('tr')==1){

                               if(prevIndex==1){
                                   $that_a/*.siblings("a[data-opt=moveup]")*/.prop("style","display:none");
                                   $that_a.siblings("a[data-opt=movetop]").prop("style","display:none");
                                   $that_a.siblings("a[data-opt=movedown]").prop('style','display:');
                                   $(prev).children("td:last-child").find("a[data-opt=movedown]").prop("style","display:none");
//                                   $(prev).children("td:last-child").append('<a href="javascript:" data-opt="moveup" class="layui-btn layui-btn-mini">上移</a>')
//                                       .append('<a href="javascript:" data-opt="movetop" class="layui-btn layui-btn-mini">置顶</a>');
                                    $(prev).children("td:last-child").find("a[data-opt=moveup]").prop("style","display:");
                                    $(prev).children("td:last-child").find("a[data-opt=movetop]").prop("style","display:");
                               }
//                               else {
//                                   $that_a.siblings("a[data-opt=moveup]").prop("style","display:none");
//                                   $that_a.siblings("a[data-opt=movetop]").prop("style","display:none");
//                                   $that_a.siblings("a[data-opt=movedown]").prop('style','display:');
//                               }
//                           }
//                           e.stopPropagation();
                           break;
                       case 'movetop':
                           console.log("置顶");
//                           var prev;
//                           while ($that_a.parents("tr").index('tr')!=1){
                               var first=$that_a.parents("tr").siblings("tr:first");
                               $that_a.parents("tr").insertBefore(first);
//                           }
//                           var last=prev;
                           $(first).children("td:last-child").find("a[data-opt=movedown]").prop("style","display:none");
//                           $(last).children("td:last-child").append('<a href="javascript:" data-opt="moveup" class="layui-btn layui-btn-mini">上移</a>')
//                               .append('<a href="javascript:" data-opt="movetop" class="layui-btn layui-btn-mini">置顶</a>');
                           $(first).children("td:last-child").find("a[data-opt=moveup]").prop("style","display:");
                           $(first).children("td:last-child").find("a[data-opt=movetop]").prop("style","display:");
                           $that_a.siblings("a[data-opt=moveup]").prop("style","display:none");
                           $that_a/*.siblings("a[data-opt=movetop]")*/.prop("style","display:none");
                           $that_a.siblings('a[data-opt=movedown]').prop("style","display:");
//                           e.stopPropagation();
                           break;
                       case 'movedown':
                           console.log("下移");
                           var next=$that_a.parents("tr").next();
//                           if ($that_a.parents("tr").index('tr')==1){
                               $that_a.parents("tr").insertAfter(next);
//                               $that_a.parent().append('<a href="javascript:" data-opt="moveup" class="layui-btn layui-btn-mini">上移</a>')
//                                   .append('<a href="javascript:" data-opt="movetop" class="layui-btn layui-btn-mini">置顶</a>');
                               $that_a.siblings("a[data-opt=moveup]").prop("style","display:");
                               $that_a.siblings("a[data-opt=movetop]").prop("style","display:");
                               $that_a/*.siblings("a[data-opt=movedown]")*/.prop("style","display:none");
                               $(next).children("td:last-child").find("a[data-opt=moveup]").prop("style","display:none");
                               $(next).children("td:last-child").find("a[data-opt=movetop]").prop("style","display:none");
                               $(next).children("td:last-child").find('a[data-opt=movedown]').prop("style","display:");

//                           }else {
//
//                               $that_a.parents("tr").insertAfter(next);
//                           }
//                           e.stopPropagation();
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
        //保存
        $("#save").on('click',function () {
            var params=[];
            $('#content').children("tr").each(function (index) {
                var $that=$(this);
                var diseaseDoctor={
                    id:$that.data("id"),
//                    seq:$that.children("td:first-child").children("input").val()
                    seq:index+1
                };
                params.push(diseaseDoctor);

            });
            $.ajax({
                url:'<%=staticPath%>/doctor/diseaseDoctorSeq/update',
                type:'post',
                dataType:'json',
                data:{
                    diseaseDoctorArr:JSON.stringify(params)
                },
//                        contentType:'application/json',
                success:function (data) {
                    if (data.code=='200') {
                        layer.msg("保存成功",{icon:1});
                        location.reload(true);
                    }
                    else
                        layer.msg("保存失败",{icon:2});

                },
                error:function (data) {
                    console.log("保存失败",{icon:2});
                }
            });
        });
        //添加名医
        $('#add').on('click',function () {
            layer.open({
                type:2,
                area:['800px','500px'],
                content:'<%=staticPath%>/doctor/toAddFamousDoctor/'+$('#diseaseId').val(),
                shadeClose:true,
                btn:['关闭'],
                title:'添加名医',
                /*yes:function (index,layero) {
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    var params=iframeWin.getSelectedDoctors();
//                params.id=id;
                    $.ajax({
                        url:'/doctor/diseaseDoctor/add',
                        type:'post',
                        dataType:'json',
                        data:{

                            doctorDiseaseArr:JSON.stringify(params)
                        },
//                        contentType:'application/json',
                        success:function (data) {
                            if (data.code=='200') {
                                layer.msg("添加成功");
                                layer.close(index);
                                location.reload(true);
                            }
                            else
                                layer.msg("添加失败");

                        },
                        error:function (data) {
                            console.log("添加失败");
                        }
                    });
                },*/
                cancel:function (index,layero) {
                    layer.close(index);
                },
                end:function (index) {
                    location.reload(true);
                }

            });
        });

        /*paging.init({
            openWait: true,
            elem: '#content', //内容容器
            params: { //发送到服务端的参数
                realname:$('input[name="realname"]').val(),
                state:2
            },
            type: 'post',
            tempElem: '#tpl', //模块容器
            pageConfig: { //分页参数配置
                elem: '#paged', //分页容器
                pageSize: 10 //分页大小
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
                form.render('checkbox');
                form.on('checkbox(allselector)', function(data) {
                    var elem = data.elem;

                    $('#content').children('tr').each(function() {
                        var $that = $(this);
                        //全选或反选
                        $that.children('td').eq(0).children('input[type=checkbox]')[0].checked = elem.checked;
                        form.render('checkbox');
                    });
                });



            },
        });*/


        $('#search').on('click', function() {
            parent.layer.alert('你点击了搜索按钮')
        });

        /* var addBoxIndex = -1;
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


    });


</script>
</body>
</html>