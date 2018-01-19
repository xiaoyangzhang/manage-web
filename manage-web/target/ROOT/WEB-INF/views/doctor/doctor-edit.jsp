<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String staticPath=request.getContextPath();
//    String imgUrl=(String) request.getSession().getAttribute("imgUrl");
    String imgUrl=(String) request.getAttribute("imgUrl");
%>
<html>

<head>
    <meta charset="utf-8">
    <title>编辑用户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>

    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
</head>

<body>
<div style="margin: 10px 0;">

    <form class="layui-form" id="doctorForm" action="">
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">手机号</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" value="${doctorVO.mobileNumber}" disabled>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">头像</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img id="head" <c:if test="${doctorVO.headImage!=null && doctorVO.headImage.length()>0}">src='${doctorVO.headImage}'</c:if>  width="150px" height="150px">
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post" name="file" lay-title="请上传小于3M的图片" lay-type="images" class="layui-upload-file" id="upload">
                    </div>
                </div>
                <input type="hidden" name="headImage" value="${doctorVO.headImage}" />
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="realname" value="${doctorVO.realname}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="1" title="男" <c:if test="${doctorVO.sex==1}"> checked="checked"</c:if>>
                <input type="radio" name="sex" value="2" title="女" <c:if test="${doctorVO.sex==2}"> checked="checked"</c:if>>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label layui-form-label-lg">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" id="date" value='<fmt:formatDate pattern="yyyy-MM-dd"
            value="${doctorVO.birthday}" />' lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">医院名称</label>
            <div class="layui-input-inline">
                <%--<input type="text"  readonly="readonly" value="${doctorVO.hospital}" autocomplete="off" class="layui-input">--%>
                    <select name="hospitalId" lay-filter="hospital" id="hos">
                    <option value="">请选择医院</option>
                        <c:forEach items="${hospitals}" var="hos">
                            <option value="${hos.id}" <c:if test="${hos.id==doctorVO.hospitalId}">selected</c:if>>${hos.name}</option>
                        </c:forEach>
                    </select>
            </div>
            <label class="layui-form-label layui-form-label-lg">科室名称</label>
            <div class="layui-input-inline">
                    <select name="departmentId" lay-filter="department" id="dept">
                        <option value="">请选择科室</option>

                        <c:if test="${departments!=null && fn:length(departments)>0 }">

                        <c:forEach items="${departments}" var="dept">
                            <option value="${dept.id}" <c:if test="${dept.id==doctorVO.departmentId}">selected</c:if>>${dept.name}</option>
                        </c:forEach>
                        </c:if>
                    </select>

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">职称</label>
            <div class="layui-input-inline">
                <select name="title" lay-filter="title">
                    <option value="">请选择职称</option>
                    <c:forEach items="${titles}" var="title">
                    <option value="${title.itemName}" <c:if test="${title.itemName==doctorVO.title}">selected</c:if>>${title.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">职务</label>
            <div class="layui-input-inline">
                <select name="duty" lay-filter="duty">
                    <option value="">请选择职务</option>
                    <c:forEach items="${duties}" var="duty">
                        <option value="${duty.itemName}" <c:if test="${duty.itemName==doctorVO.duty}">selected</c:if>>${duty.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">学历</label>
            <div class="layui-input-inline">
                <select name="education" lay-filter="education">
                    <option value="">请选择学历</option>

                    <c:forEach items="${educations}" var="education">
                        <option value="${education.itemName}" <c:if test="${education.itemName==doctorVO.education}">selected</c:if>>${education.itemName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label layui-form-label-lg">简介</label>
            <div class="layui-input-inline">
                <textarea placeholder="请输入简介" name="summary"  lay-verify="summary" class="layui-textarea" style="resize: none;width: 300px;">${doctorVO.summary}</textarea>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label layui-form-label-lg">擅长</label>
            <div class="layui-input-inline">
                <textarea placeholder="请输入擅长" name="strongpoint" lay-verify="strongpoint" class="layui-textarea" style="resize: none;width: 300px;">${doctorVO.strongpoint}</textarea>
            </div>
        </div>

       <%-- <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="editDoctor">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>--%>
    </form>
</div><script type="text/html" id="deptTpl">
    {{# layui.each(d.list, function(index, item){ }}

    <option value="{{item.id}}">{{item.name}}</option>
    {{# }); }}
</script>
<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    var depts='${departments}';
    layui.use(['form', 'laydate','layer','laytpl','upload'], function() {
        var form = layui.form(),
            laydate = layui.laydate,upload=layui.upload,
            layer=layui.layer,laytpl=layui.laytpl,
        layerTips = parent.layer === undefined ? layui.layer : parent.layer;//获取父窗口的layer对象

        layui.upload({
            elem:'#upload',
            url:'<%=staticPath%>/img/upload',
            ext:'jpg|png|jpeg|gif',
            method:"post",
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
                    $('input[name=headImage]').val(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传头像失败",{icon:2});
            }

        });
        /*form.verify({
            summary: function(value) {
                if(value.length >100) {
                    return '最多100个字符';
                }
            },
            strongpoint:function (value) {
                if(value.length >50) {
                    return '最多50个字符';
                }
            }
        });*/
        //医院科室联动
        form.on('select(hospital)',function (data) {
            var parentId=data.value;
            $.ajax({
                url:'<%=staticPath%>/department/departmentList/'+parentId,
                type:'get',
                dataType:'json',
                success:function (result) {
                    $('#dept').empty();
                    laytpl($('#deptTpl').html()).render(result,function (html) {
                        $('#dept').append('<option value="">请选择科室</option>'+html);
                    });
                    form.render('select');
                },
                error:function (result) {

                }
            });
        });
        for (var i=0;i<depts.length;i++){
            console.log(depts[i].name);
        }

        //自定义验证规则
//        form.verify({
//            title: function(value) {
//                if(value.length < 5) {
//                    return '标题至少得5个字符啊';
//                }
//            }
//        });

        //监听提交
//        form.on('submit(editDoctor)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            });
//            return false;
//        });
    });

    var getParams=function () {

        var params={
            realname:$("input[name='realname']").val(),
            sex:$("input[name='sex']:checked").val(),
            birthday:$("input[name='birthday']").val(),
            headImage:$("input[name='headImage']").val(),
            title:$("select[name='title']").val(),
            duty:$("select[name='duty']").val(),
            education:$("select[name='education']").val(),
            strongpoint:$("textarea[name='strongpoint']").val(),
            summary:$("textarea[name='summary']").val(),
            departmentId:$("select[name=departmentId]").val()
        };
//        var params=$.param($('#doctorForm').serializeArray());
        return params;
    }
</script>
</body>

</html>