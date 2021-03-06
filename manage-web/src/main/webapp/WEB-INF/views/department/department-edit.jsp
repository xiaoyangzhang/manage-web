<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String staticPath=request.getContextPath();
    String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>

<head>
    <meta charset="utf-8">
    <title>编辑科室</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <style type="text/css">
        .layui-form-label{font-size: 12px;}
    </style>
</head>

<body>
<div style="padding: 10px;">
    <blockquote class="layui-elem-quote">
        <%--<a href="<%=staticPath%>/department/toDepartmentList/${dept.id}"  class="layui-btn layui-btn-normal">返回</a>--%>
        <a href="javascript:history.back(-1);"  class="layui-btn layui-btn-normal">返回</a>
    </blockquote>
    <form class="layui-form" action="" id="deptForm">
        <input type="hidden" value="${dept.id}" id="deptId"/>
        <div class="layui-form-item" >
            <label class="layui-form-label">科室名称:</label>
            <div class="layui-input-block">
                <input type="text" name="name" value="${dept.name}"  autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">科室分类:</label>
            <div class="layui-input-block" id="category">
                <input type="button" value="添加分类" class="layui-btn layui-btn-normal" id="addCat">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">科室图标:</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <c:choose >
                        <c:when test="${dept.logo!=null && dept.logo.length()>0}">
                    <img id="head" src="${dept.logo}" width="150px" height="150px">
                        </c:when>
                        <c:otherwise>
                    <img id="head" width="150px" height="150px">

                        </c:otherwise>
                    </c:choose>
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post"  value="上传图片" name="file" lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="logo" value="${dept.logo}" />
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">科室简介:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入简介" lay-verify="summary"   name="summary" class="layui-textarea">${dept.summary}</textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">科室介绍链接:</label>
            <div class="layui-input-block">
                <input type="text" name="exhibitUrl" value="${dept.exhibitUrl}"  autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">健康宣教链接:</label>
            <div class="layui-input-block">
                <input type="text" name="healthUrl" value="${dept.healthUrl}" autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">典型病例链接:</label>
            <div class="layui-input-block">
                <input type="text" name="typicalIllUrl" value="${dept.typicalIllUrl}"  autocomplete="off" class="layui-input">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">科室定制服务:</label>
            <div class="layui-input-block" id="service">
                <%--<input type="button" value="添加服务" class="layui-btn layui-btn-normal" id="addService">--%>
                <table class="layui-table">
                    <thead>
                        <th>序号</th>
                        <th>商品编号</th>
                        <th>商品名称</th>
                        <th>商品价格</th>
                        <th>商品分类</th>
                        <th>商品描述</th>
                        <th>创建人</th>
                        <th>上架/下架时间</th>
                        <th>发布时间</th>
                        <th>操作</th>
                    </thead>
                    <tbody >
                        <c:forEach items="${itemDepts}" var="item" varStatus="vs">
                            <tr itemid="${item.id}">
                                <td>${vs.index+1}</td>
                                <td>${item.code}</td>
                                <td>${item.name}</td>
                                <td>￥${item.price}</td>
                                <td>${item.categoryName}</td>
                                <td>${item.description}</td>
                                <td>${item.createOperator}</td>
                                <td>
                                    <c:if test="${item.state==2}">${item.onshelfDay}</c:if>
                                    <c:if test="${item.state==4}">${item.offshelfDay}</c:if>
                                </td>

                                <td>${item.onshelfDay}</td>
                                <td>
                                    <c:if test="${item.state==4 or item.state==1}">
                                        <input type="button" class="layui-btn-mini layui-btn" onclick="onOff('on')" value="上架" id="on" />
                                    </c:if>
                                    <c:if test="${item.state==2}">
                                        <input type="button" class="layui-btn-mini layui-btn" onclick="onOff('off')" value="下架" id="off" />
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <button lay-filter="submit" lay-submit class="layui-btn layui-btn-normal">保存</button>
    </form>
</div>
<%--<script type="text/html" id="deptTpl">

</script>--%>
<%--<div style="margin: 15px;display: none" id="deptCatDiv">
    <fieldset class="">
        <fieldset class="layui-elem-field">
            <legend>选择一级科室分类</legend>
            <div class="layui-box" id="first"></div>
            <c:forEach items="${list}" var="level1">
                <button class="layui-btn layui-btn-primary" name="level1" value="${level1.id}">${level1.parentName}</button>

            </c:forEach>
        </fieldset>
        <fieldset class="layui-elem-field">
            <legend>选择二级科室分类</legend>
            <div id="second"></div>
        </fieldset>
    </fieldset>

</div>
<script type="text/html" id="firstTpl">
    {{# layui.each(d.blacklistList, function(index, item){ }}

    {{# }); }}
</script>
<script type="text/html" id="secondTpl">
    {{# layui.each(d.list, function(index, item){ }}
    <input type="checkbox" lay-skin="primary" value="{{item.id}}"><span>{{item.childName}}</span>
    {{# }); }}
</script>--%>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    var dictDepts='${dictDepts}';//获取科室分类 type arr
    var params = [];//父子页面传递科室分类使用 type arr
    layui.use(['form','laytpl','layer','upload'], function() {
        var form = layui.form(),layer=layui.layer,
            upload=layui.upload,
            layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象

            laytpl=layui.laytpl;
        layui.upload({
            elem:'#upload',
            url:'<%=staticPath%>/img/upload',
            ext:'jpg|png|jpeg|gif',
            method:'post',
//            choose:function (obj) {
//                obj.preview(function (index,file,result) {
//                });
//            },
            /*before:function (input) {
                if (input.files[0].size>3145728){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                    return false ;
                }
            },*/
            success:function (res) {
                if (res.code!=200){
                    layerTips.msg("请上传小于3M的图片",{icon:5});
                }else {
                    $("img").attr("src", res.entity);
                    $('input[name=logo]').val(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传头像失败",{icon:2});
            }

        });

        function getDeptCategories() {
            var html="";
            if(dictDepts != null && dictDepts.length>0) {
                dictDepts = JSON.parse(dictDepts);
                for (var i = 0; i < dictDepts.length; i++) {
                    html += '<span><input type="hidden" data-level="2" value="' + dictDepts[i].id + '"/>' + dictDepts[i].childName + '<a  href="javascript:" >删除</a></span>';
                }
            }
            $("#category").append(html);
        }
        getDeptCategories();


        //添加科室分类
        $('#addCat').on('click',function () {
            layer.open({
               title:'添加科室分类',
               type:2,
               content:'<%=staticPath%>/department/toDeptCategory/'+$('#deptId').val(),
               shadeClose:false,
               btn:['保存','取消'],
                area:['600px','400px'],
               yes:function (index,layero) {
                   $('#category span').remove();
                   var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                        params=iframeWin.getCheckedOnes();
                   var html="";
                   for (var i=0;i<params.length;i++){
                       html+='<span><input type="hidden" data-level="2" value="'+params[i].dictDepartmentId+'"/>'+params[i].name+'<a  href="javascript:" >删除</a></span>';
                   }

                   $('#category').append(html);
                   $('#category').children("span").find("a").each(function () {
                       var $that=$(this);
                       $that.on('click',function () {
                           for(var i=0;i<params.length;i++){
                               if(Number($that.parent("span").find('input').val())==params[i].dictDepartmentId){
                                   params.splice(i,1)
                               }
                           }
                           $that.parent("span").remove();
                       })
                   });
                   layer.close(index);

                },
                success:function (layero) {},
                cancel:function (index) {
                    layer.close(index);
                }
            });
        });
        //自定义验证规则
//        form.verify({
//            title: function(value) {
//                if(value.length < 5) {
//                    return '标题至少得5个字符啊';
//                }
//            }
//        });
//自定义验证规则
        form.verify({
            summary: function(value) {
                if(value.length >1000) {
                    return '科室简介最多1000个字符';
                }
            }
        });
        //监听提交
        form.on('submit(submit)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            });
//            if(data.field.summary.length >255) {
//                layer.msg('科室简介最多255个字符',{icon:5});
//                return false;
//            }
            var deptDictDepts=[];
            $('#category').children("span").each(function () {
                var $that=$($(this).find("input[type=hidden]"));
                var deptDictDept={
                    dictDepartmentLevel:$that.data("level"),
                    dictDepartmentId:$that.val()
                };
                deptDictDepts.push(deptDictDept);
            });
            data.field.deptDictDepts=deptDictDepts;
            var department={
            id:$('#deptId').val(),
                name:$("input[name='name']").val(),
                logo:$("input[name='logo']").val(),
                exhibitUrl:$("input[name='exhibitUrl']").val(),
                healthUrl:$("input[name='healthUrl']").val(),
                typicalIllUrl:$("input[name='typicalIllUrl']").val(),
                summary:$("textarea[name='summary']").val()
            };
            data.field.department=department;
            //定制服务
            // var itemDTOs=[];
            // $("#service").find("table tbody").children("tr").each(function () {
            //     // var $this=$(this);
            //     var itemDTO={
            //         id:$(this).attr("itemid"),
            //         state:$(this).find("td:last-child").find("input").hasClass("on")?2:4
            //     }
            //     itemDTOs.push(itemDTO);
            // })
            // data.field.itemDTOs=itemDTOs;
            $.ajax({
                       url:'<%=staticPath%>/department/editDepartment',
                       type:'post',
                       data:JSON.stringify(data.field),
                       dataType:'json',
                        contentType:'application/json',
                       success:function (result) {
                           if (result.code==200)
                               layer.msg("修改成功",{icon:1});
                           else
                               layer.msg("修改失败",{icon:2});
                       },
                       error:function (result) {
                               layer.msg("修改失败",{icon:2});
                       }
                   });
            return false;
        });
    });
        //上/下架
        function onOff(id) {
            var msg="";
            if ("on"==id){
                msg="上架";
                // $("#"+id).val("下架");
            }else if("off"==id){
                msg="下架";
                // $("#"+id).val("上架");
            }
            $.ajax({
                url:'<%=staticPath%>/product/state/update',
                type:'post',
                data:JSON.stringify({
                    id:$("#"+id).parent("td").parent("tr").attr("itemid"),
                    state:id=="on"?2:4
                }),
                dataType:'json',
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200){
                        layer.msg( msg+"成功",{icon:1});
                        if ("on"==id){
                            // msg="上架";
                            $("#"+id).val("下架");
                        }else if("off"==id){
                            // msg="下架";
                            $("#"+id).val("上架");
                        }
                        location.reload(true);
                    }
                    else if(result.code=="501"){
                        layer.msg(result.msg,{icon:5});

                    }
                    else
                        layer.msg(msg+"失败",{icon:2});
                },
                error:function (result) {
                    layer.msg(msg+"失败",{icon:2});
                }
            });

        }

    var getParams=function () {
        var params={
            name:$("input[name='name']").val(),
            dictHospitalCategoryId:$("select[name='dictHospitalCategoryId']").val(),
            logo:$("input[name='logo']").val(),
            exhibitUrl:$("input[name='exhibitUrl']").val(),
            healthUrl:$("input[name='healthUrl']").val(),
            typicalIllUrl:$("input[name='typicalIllUrl']").val(),
            summary:$("textarea[name='summary']").val()
        };
        return params;
    }
</script>
</body>

</html>