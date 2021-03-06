<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<%
    //id1
    String maindataid = request.getParameter("maindataid");

//id2
    String backurl = request.getParameter("backurl");


%>
<html>
<head>
    <meta charset="utf-8">
    <title>诊后签到信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>

<body>


<div class="layui-whole">
    <blockquote class="layui-elem-quote">当前位置:诊后签到信息</blockquote>
    <div class="layui-whole-con">
        <h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>诊后签到信息</h2>
        <table class="layui-table" style="margin:0 0 10px 0;">
            <colgroup>
                <col width="100px">
                <col>
                <col width="100px">
                <col>
                <col width="100px">
                <col>
                <col width="100px">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>姓名</th>
                <td>${userInfo.realname}</td>
                <th>性别</th>
                <td>
                    <c:if test="${userInfo.sex==1}">男</c:if>
                    <c:if test="${userInfo.sex==2}">女</c:if>
                </td>
                <th>年龄</th>
                <td>${userInfo.age}</td>
                <th>手机号</th>
                <td>${userInfo.username}</td>
            </tr>
            <tr>
                <th>证件类型</th>
                <td>身份证</td>
                <th>证件号码</th>
                <td>${userInfo.idno}</td>
                <th>就诊医院</th>
                <td>${userInfo.name1}</td>
                <th>就诊科室</th>
                <td>${userInfo.name2}</td>
            </tr>
            <tr>
                <th>就诊日期</th>
                <td>${userInfo.createTime }</td>
                <th>初/复诊</th>
                <td>${userInfo.isrepeat }</td>
                <th>诊断结果</th>
                <td>${userInfo.diagnoseresult }</td>
                <th>审核人</th>
                <td>${userInfo.operatorId }</td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" value="${userInfo.id }" id="equipid" name="title" lay-verify="required" autocomplete="off"
               class="layui-input">
        <input type="hidden" value="${userInfo.departmentId }" id="departmentId" name="title" lay-verify="required" autocomplete="off"
               class="layui-input">
        <h2 class="layui-h2-title"><i class="layui-icon">&#xe62d;</i>审核人</h2>
        <table class="layui-table" style="margin:0 0 10px 0;">
            <colgroup>
                <col width="100px">
                <col width="150px">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th style="text-align: center">审核状态</th>
                <th style="text-align: center">审核时间</th>
                <th style="text-align: center">拒绝原因</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <c:if test="${userInfo.state==1}">待审核</c:if>
                    <c:if test="${userInfo.state==2}">审核中</c:if>
                    <c:if test="${userInfo.state==3}">审核通过</c:if>
                    <c:if test="${userInfo.state==4}">拒绝</c:if>
                </td>
                <td>${userInfo.reviewtime}</td>
                <td>${userInfo.refusereason}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="layui-fixed-btn">
        <div class="layui-form-item">
            <!-- 		<button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
            <c:if test="${userInfo.state==1}">
                <button id="ss1" type="button" class="layui-btn layui-btn-normal">拒绝</button>
                <button type="button" onclick='submitsuccess()' class="layui-btn layui-btn-normal">通过</button>
                <%--	<button type="button" onclick='releasetask()' class="layui-btn layui-btn-normal">释放任务</button>--%>
            </c:if>
            <button type="button" onclick='returnback()' class="layui-btn layui-btn-normal" style="float: right;">返回
            </button>
           <button type="button" onclick='refreshpage()' class="layui-btn layui-btn-normal" style="float: right;">刷新
            </button>
        </div>
    </div>
</div>

<script>
    function releasetask() {
        submitbytype('', '1');

    }
    
    function refreshpage(){
    	
    	 location.reload();
    }

    function submitbytype(reason, type) {
        var params = {};
        params["equipid"] = layui.jquery("#equipid").val();
        params["reason"] = reason;
        params["type"] = type;
        params["departmentId"] = layui.jquery("#departmentId").val();
        layui.jquery.ajax({
            type: "get",
            url: '<%=path%>/submitbytype?id1=' + Math.random(),
            data: params,
            async: true,
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    layui.layer.msg("处理成功！")
                    if (type != '1') {
                        returnback();
                    }
                }
                if (data == "fail") {
                    layer.alert("处理成功", {
                        title: '处理结果！'
                    })

                }
            },
            error: function (data) {
                layui.layer.msg('页面加载出错');
            }
        });

    }

    function submitsuccess() {
        submitbytype('', '2')
    }


    function returnback() {
        window.location = '<%=path%>/index?id=/pages<%=backurl%>';
    }

    function subbmitt() {
        var params = {};
        params["equipid"] = layui.jquery("#equipid").val();
        params["equipment"] = layui.jquery("#equipment").val();
        params["equipname"] = layui.jquery("#equipname").val();
        params["equipurl"] = layui.jquery("#equipurl").val();
        layui.jquery.ajax({
            type: "get",
            url: '<%=path%>/updatenewH5?id1=' + Math.random(),
            data: params,
            async: true,
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    layui.layer.msg("修改成功！")
                    returnback();

                }
                if (data == "fail") {

                    layer.alert("修改失败", {
                        title: '修改结果！'
                    })
                }
            },
            error: function (data) {
                layui.layer.msg('页面加载出错');
            }
        });

    }


    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit,
                laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');
        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            content: function (value) {
                layedit.sync(editIndex);
            }
        });

        //监听提交
        form.on('submit(demo1)', function (data) {
            subbmitt();
            return false;
        });


        layui.jquery('#ss1').on('click', function () {
            var con = '<div style="padding:10px;"><input type="text" class="layui-input" style="margin-bottom:5px;" name="url" placeholder="拒绝原因" /></div>';
            layer.open({
                type: 1,
                title: '请输入拒绝原因',
                content: con,
                btn: ['确认', '取消'],
                area: ['350px', '250px'],
                yes: function (index, layero) {
                    //这是核心的代码。

                    submitbytype(layui.jquery(layero).find('input').val(), '3')
                    parent.tab.tabAdd({
                        href: $(layero).find('input[name=url]').val(), //地址
                        icon: $(layero).find('input[name=icon]').val(),
                        title: $(layero).find('input[name=title]').val()
                    });
                },
                shade: false,
                maxmin: true
            });

        });


    });


</script>
</body>

</html>