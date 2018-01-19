<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/taglibs.jsp" %>
<%
    String maindataid = request.getParameter("maindataid");
    String backurl = request.getParameter("backurl");
    String startIndex = request.getParameter("startIndex");
     
    
%>
<html>
<head>
    <meta charset="utf-8">
    <title>服务卡消费详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
</head>
<body>
<div class="layui-whole">
    <blockquote class="layui-elem-quote">当前位置:服务卡消费详情</blockquote>
    <div class="layui-whole-con">
        <table class="site-table table-hover">
            <thead>
            <tr>
                <th width="30px;">序号</th>
                <th><strong>子服务订单编号</strong></th>
                <th><strong>价格/元</strong></th>
                <th><strong>状态</strong></th>
                <th><strong>医疗结构</strong></th>
                <th><strong>当前疾病</strong></th>
                <th><strong>描述</strong></th>
                <th style="width: 34px;"><strong>操作</strong></th>
            </tr>
            </thead>
            <!--内容容器-->
            <tbody id="con">

            </tbody>
        </table>
        <!--分页容器-->
        <div id="paged"></div>
    </div>
    <div class="layui-fixed-btn">
        <div class="layui-form-item" style="float: right;">
           <button onclick="refreshpage()" type="button" id="search" class="layui-btn layui-btn-normal" >刷新</button>
           <button onclick="thatpage()" type="button" id="search" class="layui-btn layui-btn-normal" >返回</button>
        </div>
    </div>
</div>

<!--模板-->
<script type="text/html" id="conTemp">
    {{# layui.each(d.list, function(index, item){ }}
    <tr>
        <td style="display: none;"><input type="hidden" value='{{ item.id }}'/></td>
        <td>{{index+1}}</td>
        <td>{{ item.orderNo }}</td>
        <td>{{ item.consumeAmount }}</td>
        <td>{{ item.type }}</td>
        <td>{{ item.name1 }}{{ item.name2 }}</td>
        <td>{{ item.maindiagnose }}</td>
        <td></td>
        <td>
            <button class="layui-btn layui-btn-mini" onclick="detailpage(this)" type="button">查看</button>
        </td>
    </tr>
    {{# }); }}
</script>
<script type="text/javascript">
    testalert();


    function refreshpage(){
    	
    	 location.reload();
    }
    
    function thatpage() {
        window.location = '<%=path%>/index?id=/pages/order/order&startIndex=<%=startIndex%>';
    }

    function detailpage(k) {
        var currentid = layui.jquery(k).parent("td").parent("tr").find("td:first").find("input:last").val();

        var temp = '';
        layui.jquery("#con").find("input:checked").each(function (i) {
            temp = temp + layui.jquery(this).next("input").val() + ',';
        });
        if (null == temp || '' == temp) {
            //layer.msg("请勾选一条数据！");
        }
        else {
            <%--			window.location='<%=path%>/index?id2=<%=id2%>&id=/pages/business/dialogdetail&id1='+layui.jquery("#con").find("input:checked").next("input").val();--%>
        }
        window.location = '<%=path%>/index?backurl=/order/servicecarddetail&maindataid=<%=maindataid%>&id=/pages/business/dialogdetail&id1=' + currentid;
        //	http://localhost:9090/newhealth/index?id=blacklist
    }
    //搜索
    <%--$('#search').on('click', function() {
            var $this = $(this);
            var name = $this.prev('input[name=name]').val();
            if(name === '' || name.length === 0) {
                layer.msg('请输入关键字！');
                return;
            }
            //调用get方法获取数据
            paging.get({
                t: Math.random(),
                name: name //获取输入的关键字。
            });
        });
    });--%>
    function testa() {
        //alert(layui.jquery("#con").find("input:checked").parent("td").next("td").text());
        var params = {};
        //	params["id"] =layui.jquery("#con").find("input:checked").next("input").val();
        //	params["pageIndex"] = 1;
        var temp = '';
        layui.jquery("#con").find("input:checked").each(function (i) {
            temp = temp + layui.jquery(this).next("input").val() + ',';
        });

        if (null == temp || '' == temp) {
            layui.layer.msg("请勾选一条数据！");
        }
        params["id"] = temp;
        layui.jquery.ajax({
            type: "post",
            url: '<%=path%>/blacklistdelete?id1=' + Math.random(),
            data: params,
            async: false,
            dataType: "text",
            success: function (data) {
                if (data == 'success') {
                    testalert();
                    layui.layer.msg("删除成功!")
                }
            },
            error: function (data) {
                layui.layer.msg('删除出错');
            }
        });
    }

    function testalert() {
        //	var $ = layui.jquery;
        //	alert($("#testjquery").val())
        layui.config({
            base: '/static/newhealth/js/'
        }).use(['paging', 'code'], function () {
            layui.code();
            var $ = layui.jquery,
                    paging = layui.paging();
            paging.init({
                openWait: true,
                url: '<%=path%>/servicecarddetail?id1=' + '2', //地址
                elem: '#con', //内容容器
                type: 'post',
                params: { //发送到服务端的参数
                    id: <%=maindataid%>,
                    username: layui.jquery("#username").val(),
                    department: layui.jquery("#department").val(),
                    province: layui.jquery("#province").val(),
                    city: layui.jquery("#city").val(),
                    pageIndex: 1
                },
                //type:'GET',
                tempElem: '#conTemp', //模块容器
                pageConfig: { //分页参数配置
                    elem: '#paged', //分页容器
                    pageSize: 5 //分页大小
                },
                success: function () { //渲染成功的回调
                    //	layui.layer.msg('渲染成功');
                },
                fail: function (msg) { //获取数据失败的回调
                    //	layui.layer.msg('获取数据失败')
                },
                complate: function (res) { //完成的回调
                    //	layui.layer.msg('处理完成');
                    console.log(res);
                }
            });
        })
    }
</script>
</body>

</html>