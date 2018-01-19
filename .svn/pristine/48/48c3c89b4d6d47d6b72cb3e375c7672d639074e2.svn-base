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
    out.clear();
    String staticPath=request.getContextPath();
%>
<head>
    <title></title>
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
    <style>
        .layui-form-item .layui-input-inline{margin-right: 0;}
        .layui-badge, .layui-badge-dot, .layui-badge-rim{
            position: relative;
            display: inline-block;
            padding: 0 6px;
            font-size: 12px;
            text-align: center;
            color: #fff;
            border-radius: 2px;
            height: 30px;
            float: left;
            line-height: 30px;
            margin: 0px 3px;
        }
        .layui-bg-red{background-color: #FF5722;}
    </style>
</head>
<body>
<div style="margin:0px; background-color: white;padding-bottom: 10px;">
    <blockquote class="layui-elem-quote">
        <form class="layui-form">
            <div class="layui-form-item" style="margin:0;">
                <label class="layui-form-label layui-form-label-md">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="patientName" id="patientName" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-lg">订单名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="orderName" id="orderName" placeholder="请输入订单名称" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label layui-form-label-sm">类型</label>
                <div class="layui-input-inline">
                    <select id="taskType" name="taskType">
                        <option value="0">请选择状态</option>
                        <option value="1">售前任务</option>
                        <option value="2">退款任务</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-sm">状态</label>
                <div class="layui-input-inline">
                    <select id="taskState" name="taskState">
                        <option value="0">请选择状态</option>
                        <option value="1">待跟进</option>
                        <option value="2">跟进中</option>
                        <option value="3">已处理</option>
                    </select>
                </div>
                <label class="layui-form-label layui-form-label-sm">时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="taskStartTime" id="taskStartTime" class="layui-input" placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})"/>
                </div>
                <div class="layui-input-inline">
                    <input type="text" name="taskEndTime" id="taskEndTime" class="layui-input" <%--lay-verify="date" --%>placeholder="yyyy-mm-dd" autocomplete="off" onclick="layui.laydate({elem: this})"/>
                </div>
                <div class="layui-form-mid layui-word-aux" style="padding:0;">
                    <button type="button" lay-filter="search" lay-submit class="layui-btn"><i class="fa fa-search" aria-hidden="true"></i>查询</button>
                </div>
            </div>

        </form>
    </blockquote>
    <blockquote class="layui-elem-quote none" style="display: none">
        <div class="layui-form-item" style="margin:0;">
            <label class="layui-form-label layui-form-label-md">任务数:</label>
            <span class="layui-badge layui-bg-red">待跟进:<span class="track1"></span></span>
            <span class="layui-badge layui-bg-orange">跟进中:<span class="track2"></span></span>
            <span class="layui-badge layui-bg-green">已处理:<span class="track3"></span></span>
            <a id="releaseAll" class="layui-btn layui-btn-normal" style="float: right">一键释放</a>
        </div>
    </blockquote>

    <div class="layui-field-box layui-form" style="padding: 0">
        <table class="layui-table admin-table" style="margin: 0;">
            <thead>
            <tr>
                <%--<th style="width: 30px;"><input type="checkbox" lay-filter="allselector" lay-skin="primary"></th>--%>
                <%--<th width="30px;">序号</th>--%>
                <th width="30px;">编号</th>
                <th>任务生成时间</th>
                <th>任务类型</th>
                <th>订单名称</th>
                <th>医疗机构</th>
                <th>患者姓名</th>
                <th>患者用户名</th>
                <th>付款时间</th>
                <th>退款时间</th>
                <th>任务状态</th>
                <th>跟进/处理人</th>
                <th width="50px">操作</th>
            </tr>
            </thead>
            <tbody id="content">
            </tbody>
        </table>
    </div>

    <div class="admin-table-page">
        <div id="paged" class="page"></div>
    </div>
</div>
<script type="text/html" id="tpl">
    {{# layui.each(d.list, function(index, item){ }}
    <tr itemid="{{item.id}}">
        <td>{{index+1}}</td>
        <%--<td>{{ item.taskNo }}</td>--%>
        <td>{{ item.createTime}}</td>
        <td>{{# if(item.type==1){ }}
            服务包售前任务
            {{#}}}
        </td>
        <td>{{ item.name}}</td>
        <td>{{ item.hospital}}</td>
        <td>{{ item.patientRealName}}</td>
        <td>{{ item.patientUserName}}</td>
        <td>{{ item.payTime}}</td>
        <td>{{ item.refundTime }}</td>
        <td>{{# if(item.taskState==1){}}
                待跟进
            {{# } else if(item.taskState==2){}}
                跟进中
            {{# } else if(item.taskState==3 || item.taskState==4||item.taskState==5){}}
                已处理
            {{# }}}
        </td>
        <td>{{ item.operator}}</td>
        <td>
            {{#if(item.operator==null || item.operator.length==0){ }}
            <button class="layui-btn layui-btn-mini" itemid="{{item.id}}" onclick="tracker(this)" type="button">跟进</button>
            {{#} else {}}
            <button class="layui-btn layui-btn-mini" itemid="{{item.id}}" onclick="viewer(this)" type="button">查看</button>

            {{#}}}
        </td>
    </tr>
    {{# }); }}
</script>
<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>

<script>
    // initall();
    function tracker(k) {
        var taskId = $(k).parent("td").parent("tr").attr("itemid");
        $.ajax({
            url:'<%=staticPath%>/task/state/update',
            type:'get',
            dataType:'json',
            data:{
                id:taskId,
                state:2,//跟进中
                action:"track"
            },
//             contentType:'application/json',
            success:function (data) {
                if (data.code=='200'){
                    location.href='<%=staticPath%>/task/'+taskId;
                }
            },
            error:function (data) {
            }
        });
    }

    function viewer(k) {
        var taskId = $(k).parent("td").parent("tr").attr("itemid");
        location.href='<%=staticPath%>/task/'+taskId;
    }
    
    // function initall(){
    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['paging', 'form','laydate'], function() {
        var laydate = layui.laydate,
                paging = layui.paging(),
                layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
                layer = layui.layer, //获取当前窗口的layer对象
                form = layui.form();
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
                document.getElementById('taskStartTime').onclick = function(){
                    start.elem = this;
                    laydate(start);
                };
                document.getElementById('taskEndTime').onclick = function(){
                    end.elem = this;
                    laydate(end);
                };
        	  paging.init({
                  openWait: true,
                  url: '<%=staticPath%>/task/tasks', //地址
                  elem: '#content', //内容容器
                  type: 'post',
                  tempElem: '#tpl', //模块容器
                  params: { //发送到服务端的参数
                      patientName: $("#patientName").val(),
                      orderName: $("#orderName").val(),
                      taskType: $("#taskType").val(),
                      taskState: $("#taskState").val(),
                      taskStartTime: $("#taskStartTime").val(),
                      taskEndTime: $("#taskEndTime").val()
                  },
                  pageConfig: { //分页参数配置
                      elem: '#paged', //分页容器
                      pageSize: 25 //分页大小
                  },
                  success: function() { //渲染成功的回调
                      $.ajax({
                          url:'<%=staticPath%>/task/statistics',
                          type:'post',
                          dataType:'json',
                          data:JSON.stringify({
                              patientName: $("#patientName").val(),
                              orderName: $("#orderName").val(),
                              taskType: $("#taskType").val(),
                              taskState: $("#taskState").val(),
                              taskStartTime: $("#taskStartTime").val(),
                              taskEndTime: $("#taskEndTime").val()
                          }),
                          contentType:'application/json',
                          success:function (data) {
                              if (data.code=='200'){
                                  $(".track1").text(data.entity.noDealCount);
                                  $(".track2").text(data.entity.dealingCount);
                                  $(".track3").text(data.entity.dealedCount);
                              }
                          },
                          error:function (data) {
                          }
                      });
                  },
                  fail: function(msg) { //获取数据失败的回调

                  },
                  complate: function() { //完成的回调
                      setTimeout(function () {
                          $(".none").show();
                      },30)
                  },

              });
        //监听搜索表单的提交事件
        form.on('submit(search)', function (data) {
            paging.get(data.field);
            return false;
        });
        //一键释放
        $("#releaseAll").on("click",function () {
            $.ajax({
                url:'<%=staticPath%>/task/release',
                type:'post',
                dataType:'json',
                success:function (data) {
                    if (data.code=='200'){
                        layerTips.msg("释放成功",{icon:1});
                        location.reload(true);
                    }
                    else
                        layerTips.msg("释放失败",{icon:2});
                },
                error:function (data) {
                    layerTips.msg("释放失败",{icon:2});
                }
            });
        });

        });
    // }


</script>
</body>
</html>
