<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String staticPath=request.getContextPath();
    String gateWay = (String) request.getAttribute("gateWay");
    String servicePath = gateWay+"/system-zxy";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>商品管理-添加商品</title>
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
<body style="padding: 10px;">
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">品牌名称</label>
        <div class="layui-input-block">
            <input type="text" name="brand" value="${ItemBodyReturnVo.brand}" autocomplete="off" class="layui-input" style="width: 450px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" value="${ItemBodyReturnVo.name}" lay-verify="required" autocomplete="off" class="layui-input" style="width: 450px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品分类</label><%--categoryDictId--%>
        <div class="layui-input-block ">
            定制服务包
            <input type="hidden" name="categoryDictId" value="1">
            <%--<input type="button" class="layui-btn layui-btn-small layui-btn-normal" id="selectSort" value="选择分类">--%>
            <%--<div class="classificationWrap" style="display: inline-block"></div>--%>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品价格</label>
        <div class="layui-input-block">
            <input type="text" name="price" value="${ItemBodyReturnVo.price}" lay-verify="required" autocomplete="off" class="layui-input" style="width: 450px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">分成比例</label>
        <div class="layui-input-block">
            <input type="text" name="ratio" value="${ItemBodyReturnVo.ratio}" autocomplete="off" class="layui-input" style="width: 150px;display: inline-block">％(填写为医院占比％)
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">有效期</label>
        <div class="layui-input-block">
            <input type="text" name="expireDate" value="${ItemBodyReturnVo.expireDate}" autocomplete="off" class="layui-input" style="width: 450px;display: inline-block">天
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布端</label>
        <div class="layui-input-block">
            <input type="radio" name="releaseClient" value="1"  title="新健康" checked>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布位置</label>
        <div class="layui-input-block" style="height: 30px;">
            <input type="checkbox" name="releasePlace" lay-skin="primary" value="1" checked title="科室主页">
            <%--<input type="radio" name="releasePlace" value="2" title="医生主页" >--%>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布医院</label>
        <div class="layui-input-block">
            <input type="button" class="layui-btn layui-btn-small layui-btn-normal" id="selectHos" value="选择医院">
            <div class="hospitalWrap" style="display: inline-block">${ItemBodyReturnVo.hospitalName}</div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布科室</label>
        <div class="layui-input-block">
            <input type="button" class="layui-btn layui-btn-small layui-btn-normal" id="selectDepart" value="选择科室">
            <div class="departmentWrap" style="display: inline-block">${ItemBodyReturnVo.departmentName}</div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">适用疾病</label>
        <div class="layui-input-block">
            <input type="button" class="layui-btn layui-btn-small layui-btn-normal" id="selectDisease" value="选择疾病">
            <div class="diaeaseWrap" style="display: inline-block"><%--'${ItemBodyReturnVo.dictDiseaseIds}'--%>
                <c:forEach items="${ItemBodyReturnVo.dictDiseaseIds}" var="pro" begin="0">
                    <span data-id="${pro.id}">${pro.name}</span>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">指定顺序</label>
        <div class="layui-input-block" style="width: 150px;">
            <select id="topOrder" name="topOrder">
                <option value="0">默认</option>
                <option value="1">顺序1</option>
                <option value="2">顺序2</option>
                <option value="3">顺序3</option>
            </select>
        </div>
    </div>
    <h2 style="padding: 0 37px;">商品内容</h2>
    <div class="content-item">
        <div class="layui-form-item">
            <label class="layui-form-label">商品描述</label>
            <div class="layui-input-block">
                <input type="text" name="description" value="${ItemBodyReturnVo.description}" autocomplete="off" placeholder="请输入标题，50字以内" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">商品列表图</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img width="150px" height="150px" class="itemListPic" src="${ItemBodyReturnVo.navigationPicUrl}">
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post" name="file" lay-title="请上传图片" lay-type="images" class="layui-upload-file" id="itemListPic">
                        <input type="hidden" name="navigationPicUrl" value="${ItemBodyReturnVo.navigationPicUrl}">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-label-lg">商品详情top图</label>
            <div class="layui-input-inline">
                <div class="site-demo-upload">
                    <img width="150px" height="150px" class="itemTopPic" src="${ItemBodyReturnVo.topPicUrl}">
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post" name="file" lay-title="请上传图片" lay-type="images" class="layui-upload-file" id="itemTopPic">
                        <input type="hidden" name="topPicUrl" value="${ItemBodyReturnVo.topPicUrl}">
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="content-item" id="detailCon">
        <p>内容详情图</p>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div class="site-demo-upload">
                    <div class="imgWrap">

                    </div>
                    <%--<img width="150px" height="150px" class="addImg">--%>
                    <div class="site-demo-upbar">
                        <input type="file" lay-method="post" name="file" lay-title="请上传小于200K的图片" lay-type="images" class="layui-upload-file" id="addImg">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-inline" style="display: block;">
            <label class="layui-form-label">上架时间</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="startDate" name="onshelfDay" value="${ItemBodyReturnVo.onshelfDay}" placeholder="yyyy-MM-dd" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})">
            </div>
            0点00:00
        </div>
        <div class="layui-inline" style="display: block;">
            <label class="layui-form-label">下架时间</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="endDate" name="offshelfDay" value="${ItemBodyReturnVo.offshelfDay}"  placeholder="yyyy-MM-dd" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})">
            </div>
            23点59:59
        </div>
    </div>
    <div class="" style="width: 100%;">
        <table class="layui-table">
            <thead>
            <th width="20%">时间</th>
            <th width="20%">操作人</th>
            <th width="60%">描述</th>
            </thead>
            <tbody>
            <c:forEach items="${ItemBodyReturnVo.itemLogs}" var="log">
                <tr>
                    <td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${log.operator}</td>
                    <td>${log.content}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div>
        <c:if test="${action=='edit'}">
            <input type="button" class="layui-btn btn-submit" lay-submit lay-filter="submit" value="保存">
        </c:if>
    </div>
</form>

<script type="text/javascript" src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>
    //保存疾病
    var diseaseArr = [], diseaseIdArr = [],diseaseNameArr = [];

    layui.use(['form', 'layedit', 'laydate','jquery','upload','layer'], function(){
        var form = layui.form(),
                laydate = layui.laydate,
                upload=layui.upload,
                laytpl=layui.laytpl,
                layedit = layui.layedit,
                layerTips = parent.layer === undefined ? layui.layer : parent.layer;//获取父窗口的layer对象
        //日期控制
        var start = {
            min: laydate.now()
            ,max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        var end = {
            min: laydate.now()
            ,max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        document.getElementById('startDate').onclick = function(){
            start.elem = this;
            laydate(start);
        };
        document.getElementById('endDate').onclick = function(){
            end.elem = this;
            laydate(end);
        };

        //指定顺序默认选中
        var topOrder = '${ItemBodyReturnVo.topOrder}';
        $('#topOrder').val(topOrder);
        form.render('select');

        //选择商品分类
        <%--var selectSort = $('#selectSort');--%>
        <%--var classificationId = '';--%>
        <%--selectSort.on('click',function () {--%>
        <%--layer.open({--%>
        <%--type:2,--%>
        <%--title:'商品分类',--%>
        <%--content:"<%=staticPath%>/item/getItemClassification",--%>
        <%--area:['400px','250px'],--%>
        <%--offset: ['50px', '40%'],--%>
        <%--shadeClone:true,--%>
        <%--btn:['确认','取消'],--%>
        <%--yes:function (index,layero) {--%>
        <%--var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：--%>
        <%--classificationId=iframeWin.classification.id;--%>
        <%--$('.classificationWrap').empty().append('<span>'+iframeWin.classification.title+'</span>');--%>
        <%--layer.close(index);--%>
        <%--},--%>
        <%--cancel:function (index,layero) {--%>
        <%--layer.close(index);--%>
        <%--}--%>
        <%--});--%>
        <%--});--%>

        //选择医院
        var selectHos = $('#selectHos');
        var hospitalId = '${ItemBodyReturnVo.hospitalId}';
        selectHos.on('click',function () {
            layer.open({
                type:2,
                title:'选择医院',
                content:"<%=staticPath%>/item/itemHospital",
                area:['800px','500px'],
                offset: ['50px', '15%'],
                shadeClone:true,
                btn:['确认','取消'],
                yes:function (index,layero) {
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    var body = layer.getChildFrame('body', index);
                    body.find('#getHos').click();
                    hospitalId=iframeWin.hospital.id;
                    $('.hospitalWrap').empty().append('<span>'+iframeWin.hospital.name+'</span>');
                    layer.close(index);
                },
                cancel:function (index,layero) {
                    layer.close(index);
                }
            });
        });

        //选择科室
        var selectDepart = $('#selectDepart');
        var departId = '${ItemBodyReturnVo.departmentId}';
        selectDepart.on('click',function () {
            if(hospitalId==''){
                layerTips.msg("请先选择医院",{icon:2});
            }else{
                layer.open({
                    type:2,
                    title:'选择科室',
                    content:"<%=staticPath%>/item/itemDepartment/"+hospitalId,
                    area:['500px','300px'],
                    offset: ['50px', '15%'],
                    shadeClone:true,
                    btn:['确认','取消'],
                    yes:function (index,layero) {
                        var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                        departId=iframeWin.department.id;
                        $('.departmentWrap').empty().append('<span>'+iframeWin.department.title+'</span>');
                        layer.close(index);
                    },
                    cancel:function (index,layero) {
                        layer.close(index);
                    }
                });
            }
        });

        //选择疾病
        var selectDisease = $('#selectDisease');
        var diaeaseWrap = $('.diaeaseWrap');

        var diaeases = diaeaseWrap.find('span');
        if(diaeases.length>0){
            for(var i=0;i<diaeases.length;i++){
                diseaseArr.push({
                    id:$(diaeases[i]).data('id'),
                    name:$(diaeases[i]).html()
                });
                diseaseIdArr.push($(diaeases[i]).data('id'));
                diseaseNameArr.push($(diaeases[i]).html());
            }
        }
        selectDisease.on('click',function () {
            layer.open({
                type:2,
                title:'选择疾病',
                content:"<%=staticPath%>/item/itemDisease",
                area:['800px','500px'],
                offset: ['50px', '15%'],
                shadeClone:true,
                btn:['确认','取消'],
                yes:function (index,layero) {
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    var body = layer.getChildFrame('body', index);
                    diseaseIdArr = [];diseaseNameArr = [];
                    body.find('#getDisease').click();
                    diseaseArr = iframeWin.diseaseArr;
                    $('.diaeaseWrap').empty();
                    for(x in diseaseArr){
                        diseaseIdArr.push(diseaseArr[x].id);
                        diseaseNameArr.push(diseaseArr[x].name);
                        $('.diaeaseWrap').append('<span data-id='+diseaseArr[x].id+'>'+diseaseArr[x].name+'<b style="margin: 0 10px 0 3px;cursor: pointer;">X</b></span>');
                    }
                    //$('.diaeaseWrap').empty().append('<span>'+diseaseNameArr+'</span>');
                    layer.close(index);
                },
                cancel:function (index,layero) {
                    layer.close(index);
                }
            });
        });

        //点击删除已选择的疾病
        $('.diaeaseWrap').on('click','b',function () {
            var id = $(this).parent().data('id');
            for(x in diseaseArr){
                if(id == diseaseArr[x].id){
                    $(this).parent().remove();
                    diseaseArr.splice(x,1)
                }
            }
            console.log(diseaseArr)
        });

        //商品列表图
        layui.upload({
            elem:'#itemListPic',
            url:'<%=staticPath%>/img/uploadImgUtil',
            ext:'jpg|png|jpeg|gif',
            method:"post",
            success:function (res) {
                if (res.code==200){
                    $("img.itemListPic").attr("src", res.entity);
                    $('input[name=navigationPicUrl]').val(res.entity);
                }else {
                    layerTips.msg("上传导图失败",{icon:2});
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传导图失败",{icon:2});
            }
        });

        //商品详情top图
        layui.upload({
            elem:'#itemTopPic',
            url:'<%=staticPath%>/img/uploadImgUtil',
            ext:'jpg|png|jpeg|gif',
            method:"post",
            success:function (res) {
                if (res.code==200){
                    $("img.itemTopPic").attr("src", res.entity);
                    $('input[name=topPicUrl]').val(res.entity);
                }else {
                    layerTips.msg("上传导图失败",{icon:2});
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传导图失败",{icon:2});
            }
        });

        var contentDetailsPicture = '${ItemBodyReturnVo.contentDetailsPicture}';
        var urlArr = contentDetailsPicture.slice(1,contentDetailsPicture.length-1).split(',');
        var imageArr = [];
        for(var i=0;i<urlArr.length;i++){
            imageArr.push(urlArr[i].trim().slice(2));
            $('.imgWrap').append("<img width='150px' height='150px' class='addImg' style='margin-right: 10px;' src="+urlArr[i].trim().slice(2)+">");
        }
        //上传内容详情图
        layui.upload({
            elem:'#addImg',
            url:'<%=staticPath%>/img/uploadImgUtil',
            ext:'jpg|png|jpeg|gif',
            method:"post",
            success:function (res) {
                if (res.code!=200){
                    layerTips.msg("请上传小于100k的图片",{icon:5});
                }else {
                    $('.imgWrap').append("<img width='150px' height='150px' style='margin-right: 10px;' src='+res.entity+' class='addImg'>");
                    imageArr.push(res.entity);
                }
            },
            error:function (index,upload) {
                layerTips.msg("上传导图失败",{icon:2});
            }
        });

        $('.imgWrap').on('click','img.addImg',function () {
            var src = $(this).attr('src');
            $(this).remove();
            for(var i=0; i<imageArr.length; i++) {
                if(imageArr[i] == src) {
                    imageArr.splice(i, 1);
                    break;
                }
            }
        });

        var itemId = '${ItemBodyReturnVo.id}',onlineBtn = $('#onlineBtn');

        form.on('submit(submit)', function(data) {
//            if(classificationId){
//                data.field.categoryDictId = classificationId;
//            }else{
//                layerTips.msg("请选择商品分类",{icon:5});
//                return false;
//            }
            data.field.hospitalId = hospitalId;
            data.field.departmentId = departId;
            data.field.dictDiseaseIds = diseaseIdArr;
            data.field.contentDetailsPicture = imageArr;

            data.field.count = 1;
            data.field.state = 1;
            data.field.id = itemId;
            $.ajax({
                url:'<%=staticPath%>/item/addItem',
                type:'POST',
                data:JSON.stringify(data.field),
                dataType:'json',
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200){
                        layerTips.msg("创建成功！");
                        itemId = result.entity;
                    }
                    else {
                        layerTips.msg("创建内容失败");
                    }
                },
                error:function (result) {
                    layerTips.msg("创建内容失败");
                }
            });
        });
    });
</script>
</body>
</html>