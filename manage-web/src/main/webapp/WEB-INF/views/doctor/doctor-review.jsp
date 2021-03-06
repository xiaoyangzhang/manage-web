<%--
  Created by IntelliJ IDEA.
  User: zhangxiaoyang
  Date: 2017/8/14
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String contextPath=request.getContextPath();
    String imgUrl=(String) request.getAttribute("imgUrl");

%>
<html>
<head>
    <meta charset="utf-8">
    <title>医生审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=contextPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css/main.css" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css/global.css" />
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
    <style type="text/css">
        /*.clsImg{padding-top:300px;}*/
        /*.imgAttr{position:absolute; height:225px; width:300px; border:1px solid #ccc; margin-left:135px; display:none;}*/
    </style>
</head>
<body>
<div>
    <input type="hidden" value="${id}" id="reviewID" />
    <input type="hidden" value="${operator}" id="currOpt" />

    <blockquote class="layui-elem-quote">当前位置：医生信息审核<i class="layui-icon">&#xe602;</i>医生认证审核</blockquote>

    <div id="table1">
        <table class="layui-table admin-table">
            <tbody id="review">
            </tbody>
        </table>
    </div>
</div>
<c:if test="${state!='2' && state!='3'}">

<div id="buttonDiv">
<div class="" style="float: right;padding: 10px 30px">
    <button class="layui-btn layui-btn-danger" id="refuse">拒绝</button>
    <button class="layui-btn " id="agree">通过</button>
</div>
<div style="padding: 10px 30px;float: left">
    <button class="layui-btn layui-btn-normal" id="release">释放任务</button>
</div>
</div>
</c:if>
<div style="display: none" id="refuseDiv">
    <form class="layui-form layui-form-mid">
        <label class="layui-form-label layui-form-label-lg" >拒绝原因</label>
        <div class="layui-input-inline">
            <textarea class="layui-textarea" lay-verify="contact"  name="reason" style="width: 350px;height: 100px;resize: none;"></textarea>
        </div>
        <button lay-filter="refuse" lay-submit style="display: none;"></button>
    </form>
</div>
<script type="text/html" id="reviewTpl">
    <tr>
        <th >姓名</th>
        <td>{{d.realname}}</td>
        <th >性别</th>
        <td>{{d.sex==1?'男':'女'}}</td>
        <th >年龄</th>
        <td>{{# if(d.birthday!=null){}}
            {{# var fn=function(){
            var now=new Date();
            var birthday=d.birthday;
            var birthday=d.birthday.replace("/-/g","/");
            var result=now.getFullYear()-new Date(birthday).getFullYear()+1;
            return result?result:"";
            }; }}
            {{fn()}}
            {{#}}}</td>
        <th >手机号</th>
        <td >{{d.mobileNumber}}</td>
    </tr>
    <tr>
        <th >职称</th>
        <td>{{d.title}}</td>
        <th >申请时间</th>
        <td>{{d.applyTime}}</td>
        <th >医院</th>
        <td>{{d.hospitalName}}</td>
        <th >科室</th>
        <td>{{d.departmentName}}</td>
    </tr>
    <tr>
        <th >简介</th>
        <td colspan="7">{{d.summary}}</td>
    </tr>
    <tr>
        <th >擅长</th>
        <td colspan="7">{{d.strongpoint}}</td>
    </tr>
    <tr>
        <td>医师执业证:
            <div class="gallerys">
                {{# if(d.practiceCertificate!=null && d.practiceCertificate.length>0) {}}
                <img class="gallery-pic" width="100px" height="100px" src="{{d.practiceCertificate}}" onclick="$.openPhotoGallery(this)">
                {{# } else { }}
                <img width="100px" height="100px" >
                {{# }}}
            </div>
        </td>
        <td>资格证:
            <div class="gallerys">
                {{# if(d.qualificationCertificate!=null && d.qualificationCertificate.length>0) {}}
                <img class="gallery-pic" width="100px" height="100px" src="{{d.qualificationCertificate}}" onclick="$.openPhotoGallery(this)">
                {{# }else { }}
                <img width="100px" height="100px" >
                {{# }}}
        </div></td>
    </tr>
</script>
<script type="text/javascript" src="<%=contextPath%>/static/plugins/layui/layui.js"></script>
<script type="text/javascript" src="<%= contextPath%>/static/plugins/jquery-photo-gallery/jquery.js"></script>
<script type="text/javascript" src="<%= contextPath%>/static/plugins/jquery-photo-gallery/jquery.photo.gallery.js"></script>
<script>
    layui.use(['laytpl','form','layer'],function () {
        var laytpl = layui.laytpl,form = layui.form(),layer=layui.layer;
        $.ajax({
            url:'<%=contextPath%>/doctor/DoctorReviewInfo/'+$("#reviewID").val(),
            type:'get',
            dataType:'json',
            success:function (data) {
                data = data.entity;
                laytpl($('#reviewTpl').html()).render(data,function (html) {
                    $('#review').html(html);
//                    if(data.state==2 || data.state==3){
//                        $("#buttonDiv").prop("style","display:none");
//                    }
                    if (data.operator != $('#currOpt').val()) {
                        $("#buttonDiv").prop("style","display:none");
                        var h='<div><table class="layui-table admin-table" ><tbody>' +
                            '<tr><td>审核人</td><td colspan="7">'+data.operator+'</td></tr>' +
                            '<tr><td>审核状态</td><td colspan="7">'+getState(data.state)+'</td></tr>' +
                            '<tr><td>审核时间</td><td colspan="7">'+data.reviewTime+'</td></tr>' +
                            '<tr><td>拒绝原因</td><td colspan="7">'+data.reason+'</td></tr>' +
                            '</tbody></table></div>';
                        $('#table1').append(h);
                    }
                });
            },
            error:function (data) {
            }
        });

        //自定义验证规则
        /*form.verify({
            contact: function(value){
                if(value.length == 0||value == undefined){
                    return '请输入拒绝原因，500字以内。';
                }
                if(value.length > 500){
                    return '拒绝原因不能超过500字';
                }
            }
        });*/

        //状态解析
        function getState(state) {
             if (state==2)
                return "审核通过";
            else if (state==3)
                return "审核拒绝";
            else
                return "审核中";
        }

        $('#refuse').on('click',function () {
        layer.open({
           type:1,
           area:['500px','300px'],
           content:$('#refuseDiv').html(),
            shadeClose:true,
            btn:['确认','取消'],
            title:'审核拒绝',
            yes:function (index,layero) {
                $('#refuseDiv').find('button[lay-filter=refuse]').click();
            },
            success:function (layero,index) {
                var form=layui.form();
                form.render();
                form.on('submit(refuse)',function (data) {
                var reason=$(layero).find('textarea[name=reason]').val();
//                    var reason=data.field.reason;
                    if(reason.length == 0||reason == undefined){
                        return '请输入拒绝原因，500字以内。';
                    }
                    if(reason.length > 500){
                        return '拒绝原因不能超过500字';
                    }
                    $.ajax({
                    url:'<%=contextPath%>/doctor/refuseApply',
                    type:'post',
                    dataType:'json',
                    contentType:'application/json',
                    data: JSON.stringify({
                                id:$("#reviewID").val(),
                                reason:reason,
                                state:3
                            }),
                    success:function (data) {
                        if (data.code=='200'){

                            layer.close(index);
                            var index1 = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index1); //再执行关闭
                            layer.msg("审核成功",{icon:1});
                        }
                        else
                            layer.msg("审核失败",{icon:2});

                    },
                    error:function (data) {
                        layer.msg("审核失败",{icon:2});
                    }
                });
                });
            },
            cancel:function (index,layero) {
                layui.layer.close(index);
            }

        });
    });

    $('#agree').on('click',function () {
        $.ajax({
            url:'<%=contextPath%>/doctor/agreeApply/'+$("#reviewID").val(),
            type:'get',
            dataType:'json',
            success:function (data) {
                if (data.code=='200'){

                    //假设这是iframe页
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭
                    layer.msg("审核成功",{icon:1});

                }
                else
                    layer.msg("审核失败",{icon:2});
            },
            error:function (data) {
                layer.msg("审核失败",{icon:2});
            }
        });
    });

    $('#release').on('click',function () {
        $.ajax({
            url:'<%=contextPath%>/doctor/changeLockStateReview',
            type:'post',
            dataType:'json',
            contentType:'application/json',

            data:JSON.stringify({
                    id:$("#reviewID").val(),
                    isLock:0,
                    state:1
                }),
            success:function (data) {
                if (data.code=='200'){

                    layui.layer.msg("释放成功",{icon:1});
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭

                }

                else
                    layui.layer.msg("释放失败",{icon:2});

            },
            error:function (data) {
                layer.msg("释放失败",{icon:2});
            }
        });
    });
    });
</script>
</body>
</html>
