<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>诊后患者</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

</head>

<body>
<div style="margin:0;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin: 0;">
                <label class="layui-form-label layui-form-label-md">用户名</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入用户名" class="layui-input" id="testjquery" type="text" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-lg">求诊医院</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入求诊医院" class="layui-input" id="hospital" type="text" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-lg">求诊科室</label>
                <div class="layui-input-inline">
                    <input placeholder="请输入求诊科室" class="layui-input" id="department" type="text" name="name"/>
                </div>
                <label class="layui-form-label layui-form-label-sm">类型</label>
                <div class="layui-input-inline">
                    <select id="type" name="quiz1">
                        <option value="">请选择状态</option>
                        <option value="1">医生签到</option>
                        <option value="2">患者补签</option>
                        <option value="3">医生扫码</option>
                        <option value="4">患者扫码</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-lg">操作日期</label>
                <div class="layui-input-inline">
                    <input class="layui-input" type="text" name="date" id="dateutil1" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})">
                </div>
                <div class="layui-input-inline">
                    <input class="layui-input" type="text" name="date" id="dateutil2" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})">
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding: 0;">
                    <button class="layui-btn" onclick="testalert()" type="button">查询
                    </button>
                </div>
            </div>
        </form>
    </blockquote>
    <div style="width: 100%;">
        <table class="site-table table-hover" style="margin-bottom: 30px;">
            <thead>
            <tr>
                <th width="30px;">序号</th>
                <th>用户名</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>诊后求诊医院</th>
                <th>诊后求诊科室</th>
                <th>类型</th>
                <th>操作时间</th>
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
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;"><input type="hidden" value='{{ item.id }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.realname }}</td>
        <td>{{ item.sex }}</td>
        <td>{{ item.age }}</td>
        <td>{{ item.name1 }}</td>
        <td>{{ item.name2 }}</td>
        <td>{{ item.source }}</td>
        <td>{{ item.applytime }}</td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpagemes(this)" type="button">消息</button>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">详情</button>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();

    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/patientedit?id=/pages/patient/patientinfodetail&type=edit&backurl=/patient/patient&maindataid=' + currentid;
    }


    function detailpagemes(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();
        window.location = '<%=path%>/index?id=/pages/business/dialogdetail&backurl=/patient/patient&patientid=' + currentid;
    }


    function testalert() {
        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code'], function () {
            layui.code();
            var $ = layui.jquery,
                    paging = layui.paging();
            paging.init({
                openWait: true,
                url: '<%=path%>/dialogsign?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: layui.jquery("#testjquery").val(),
                    hospital: layui.jquery("#hospital").val(),
                    department: layui.jquery("#department").val(),
                    type: layui.jquery("#type").val(),
                    begintime: layui.jquery("#dateutil1").val(),
                    endtime: layui.jquery("#dateutil2").val(),
                    //	token:'F8F5AE2137BFAEF77FF7408476AF6C64',
                    pageIndex: 1
                },
                //   	type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 20 //分页大小
                },
                success: function () { //渲染成功的回调
                    $('.new-btable-paged').css("bottom","1");
                },
                fail: function (msg) { //获取数据失败的回调

                },
                complate: function (res) { //完成的回调

                },
            });
        })
        initdatetool();
    }


    function initdatetool() {
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
        });
    }
</script>
</body>

</html>