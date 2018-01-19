<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String staticPath=request.getContextPath();
    String gateWay = (String) request.getAttribute("gateWay");
    String servicePath = gateWay+"/system";

%>
<html>
<head>
    <meta charset="utf-8">
    <title>创建问卷</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=staticPath%>/static/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=staticPath%>/static/css/btable.css" />
    <%--<link rel="stylesheet" href="<%=staticPath%>/static/css/global.css" />--%>
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="<%=staticPath%>/static/js/jquery.tmpl.min.js"></script>

    <style>
        .btable .btable-paged{bottom: 57px;}
    </style>
</head>

<body>
<blockquote class="layui-elem-quote" style="padding: 10px 15px;line-height: 30px;">当前位置:创建问卷<a href="javascript:history.back(-1);" style="float: right;height: 30px;line-height: 30px;" class="layui-btn layui-btn-normal">返回</a></blockquote>
<form class="layui-form layui-form-pane" action="">
    <input type="hidden"  id="questionnaireId"  />

    <!--标题-->
    <div class="layui-whole-title" style="padding:0 15px;">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">副标题</label>
            <div class="layui-input-block">
                <input type="text" name="subTitle" lay-verify="subtitle" placeholder="请输入副标题" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <!--标题 end-->
    <!--题目内容-->
    <div class="layui-whole-content" style="padding:0 15px;">
        <div class="content-subject">

        </div>
        <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
            <legend>添加题型按钮</legend>
            <div class="content-btn" style="margin: 20px 30px 10px;">
                <a class="layui-btn" id="radioBtn">单选题</a>
                <a class="layui-btn" id="multipleBtn">多选题</a>
                <a class="layui-btn" id="textBtn">简答题</a>
                <a class="layui-btn" id="sliderBtn">滑块题</a>
                <a class="layui-btn" id="annexBtn">上传图片题</a>
            </div>
        </fieldset>
    </div>
    <!--题目内容 end-->
    <!--科室选择-->
    <div class="layui-whole-department" style="padding:0 15px;">
        <table class="layui-table" lay-size="lg">
            <colgroup>
                <col width="30%">
                <col width="35%">
                <col width="35%">
            </colgroup>
            <thead>
            <tr>
                <th>结束语</th>
                <%--<th>添加科室标签<a class="layui-btn layui-btn-normal" id="deptList" style="float: right">添加科室</a></th>--%>
                <%--<th>添加疾病标签<a class="layui-btn layui-btn-normal" id="diseaseList" style="float: right">添加疾病</a></th>--%>
                <th>添加科室标签<a class="layui-btn layui-btn-normal addDepartment" style="float: right">添加科室</a></th>
                <th>添加疾病标签<a class="layui-btn layui-btn-normal addDisease" style="float: right">添加疾病</a></th>
            </tr>
            </thead>
            <tbody class="tags">
            <tr>
                <td><textarea placeholder="请输入内容" lay-verify="comment"  name="comment" class="layui-textarea"></textarea></td>
                <td class="deptTags"><%--<a class="layui-btn layui-btn-danger layui-btn-xs delDepartment">--%></td>
                <td class="diseaseTags"><%--<a class="layui-btn layui-btn-danger delDisease">疾病test<i class="layui-icon">&#xe640;</i></a>--%></td>
            </tr>
            </tbody>
        </table>
    </div>
    <!--科室选择 end-->
    <div class="layui-whole-submit" style="padding:0 15px;text-align: center;margin-bottom: 10px;">
        <button class="layui-btn saveBtn" lay-submit="" lay-filter="storage">保存</button>
        <a class="layui-btn preview">预览</a>
        <button class="layui-btn" lay-submit lay-filter="publish">发布</button>
    </div>
</form>

<%--添加科室table--%>
<div id="addDepartmentTable" style="display:none;"></div>

<%--添加疾病table--%>
<div id="addDiseaseTable" style="display:none;"></div>

<%--选项模板--%>
<script id="answerTemplate" type="text/x-jquery-tmpl">
    <div class="layui-form-item answer-item">
        <label class="layui-form-label">A</label>
        <div class="layui-input-inline">
            <input type="text" lay-verify="optiontitle" placeholder="请输入选项" autocomplete="off" class="layui-input">
        </div>
        <a class="layui-btn layui-btn-danger" onclick=deleteAnswer(this)>删除</a>
    </div>
</script>

<%--单选题模板--%>
<script id="radioTemplate" type="text/x-jquery-tmpl">
    <fieldset class="layui-elem-field site-demo-button">
        <legend>题目X</legend>
        <div class="questions-mar10 questions-radio">
            <div class="questions-operation">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">(单选)</label>
                        <div class="layui-input-inline">
                            <input type="text" name="desc" data-type="1" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                            <input type="checkbox" name="isNecessary" title="非必填题">
                            <a class="layui-btn layui-btn-danger" onclick=deleteItem(this)>删除</a>
                            <a class="layui-btn layui-btn-warm" onclick=addAnswer(this)>添加选项</a>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</script>

<%--多选题模板--%>
<script id="multipleTemplate" type="text/x-jquery-tmpl">
    <fieldset class="layui-elem-field site-demo-button">
        <legend>题目X</legend>
        <div class="questions-mar10 questions-checkbox">
            <div class="questions-operation">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">(多选)</label>
                        <div class="layui-input-inline">
                            <input type="text" name="desc" data-type="2" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <input type="checkbox" name="isNecessary" title="非必填题">
                        <a class="layui-btn layui-btn-danger" onclick=deleteItem(this)>删除</a>
                        <a class="layui-btn layui-btn-warm" onclick=addAnswer(this)>添加选项</a>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</script>

<%--简单题模板--%>
<script id="textTemplate" type="text/x-jquery-tmpl">
    <fieldset class="layui-elem-field site-demo-button">
        <legend>题目X</legend>
        <div class="questions-mar10 questions-textarea">
            <div class="questions-operation">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">(简答题)</label>
                        <div class="layui-input-inline">
                            <input type="text" name="desc" data-type="3" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">非必填题</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="isNecessary" style="float: right">
                            <a class="layui-btn layui-btn-danger" onclick=deleteItem(this)><i class="layui-icon">&#xe640;</i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</script>

<%--滑块题模板--%>
<script id="sliderTemplate" type="text/x-jquery-tmpl">
    <fieldset class="layui-elem-field site-demo-button">
        <legend>题目X</legend>
        <div class="questions-mar10 questions-slider">
            <div class="questions-operation">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">(滑块题)</label>
                        <div class="layui-input-inline">
                            <input type="text" name="desc" data-type="4" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">非必填题</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="isNecessary" style="float: right">
                            <a class="layui-btn layui-btn-danger" onclick=deleteItem(this)><i class="layui-icon">&#xe640;</i></a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">范围</label>
                        <div class="layui-input-inline" style="width: 100px;">
                            <input type="text" name="minDescription" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-input-inline" style="width: 100px;"><input min="0" max="10" type="number" name="ratioScope" value="10" class="layui-input"></div>
                        <div class="layui-input-inline" style="width: 100px;">
                            <input type="text" name="maxDescription" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</script>

<%--上传附件题模板--%>
<script id="annexTemplate" type="text/x-jquery-tmpl">
    <fieldset class="layui-elem-field site-demo-button">
        <legend>题目X</legend>
        <div class="questions-mar10 questions-file">
            <div class="questions-operation">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">(上传图片)</label>
                        <div class="layui-input-inline">
                            <input type="text" name="desc" data-type="5" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">非必填题</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="isNecessary" style="float: right">
                            <a class="layui-btn layui-btn-danger" onclick=deleteItem(this)><i class="layui-icon">&#xe640;</i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</script>

<script  src="<%=staticPath%>/static/plugins/layui/layui.js"></script>
<script>

    var params=[];
    var params2=[];
    //删除题目
    function deleteItem(ele) {
        $(ele).parents('.layui-elem-field').remove();
        addIndex();
    }

    //为每道题目添加序号
    function addIndex() {
        var item = $('.content-subject').find('.layui-elem-field');
        for(var i=0;i<item.length;i++){
            item.eq(i).find('legend').text('题目'+(i+1));
        }
    }

    //单选、多选添加选项
    function addAnswer(ele) {
        var answerItems = $(ele).parents('.questions-operation').find('.answer-item');
        if (answerItems.length>5){
            layerTips.msg("选择题最多只能添加六个选项",{offset: '100px',icon:5});
            return false;
        }
        $('#answerTemplate').tmpl('').appendTo($(ele).parents('.questions-operation'));
        changeIndex(ele);
    }

    //1234转化ABCD
    function changeIndex(ele) {
        var answerItems = $(ele).parents('.questions-operation').find('.answer-item');
        for(var i=0;i<answerItems.length;i++){
            answerItems.eq(i).find('.layui-form-label').text(String.fromCharCode(i+65));
        }
    }

    //单选、多选删除选项
    function deleteAnswer(ele) {
        var answerItemsParent = $(ele).parents('.questions-operation');
        $(ele).parents('.answer-item').remove();
        var answerItems = answerItemsParent.find('.answer-item');
        for(var i=0;i<answerItems.length;i++){
            answerItems.eq(i).find('.layui-form-label').text(String.fromCharCode(i+65));
        }
    }

    layui.config({
        base:'<%=staticPath%>/static/js/'
    }).use(['btable','form', 'layedit', 'laydate','jquery'], function(){
        var form = layui.form()
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate
                ,btable = layui.btable();
        layerTips = parent.layer === undefined ? layui.layer : parent.layer//获取父窗口的layer对象

            ,$=layui.jquery;
        //自定义验证规则
        form.verify({
            title: function(value) {
                if(value.length<=0){
                    return '请先为问卷填写标题';
                }else if(value.length >20) {
                    return '最多输入20字';
                }
            },
            subtitle: function(value) {
                // if(value.length<=0){
                //     return '请先为问卷填写副标题';
                 if(value.length >50) {
                    return '最多输入50字';
                }
            },
            optiontitle: function(value) {
                if(value.length<=0){
                    return '请输入题目描述';
                }else if(value.length >100) {
                    return '最多输入100字';
                }
            },
            comment: function(value) {
                if(value.length>100){
                    return '结语最多输入100字';
                }//else if(value.length >50) {
//                    return '最多输入50字';
//                }
            }
        });
        function checkQuestionItems(item) {
            var count=0;
            if (item.answerA)
                count++;
            if (item.answerB)
                count++;
            if (item.answerC)
                count++;
            if (item.answerD)
                count++;
            if (item.answerE)
                count++;
            if (item.answerF)
                count++;

            return count;
        }
        var questionnaireItems=[];
        //组织问卷数据
        function getQuestionnaireItems() {
            $("div .content-subject").children("fieldset").each(function () {
                var $this = $(this);
                var answerItmes = $this.find(".questions-operation").find(" .answer-item");
                var questionnaireItem = {
                    type: $this.find("input[name=desc]").data("type"),
                    title: $this.find("input[name=desc]").val(),
                    isNecessary: $this.find("input[name=isNecessary]")[0].checked ? 1 : 2,
                    answerA: $(answerItmes[0]).find("input[type=text]").val(),
                    answerB: $(answerItmes[1]).find("input[type=text]").val(),
                    answerC: $(answerItmes[2]).find("input[type=text]").val(),
                    answerD: $(answerItmes[3]).find("input[type=text]").val(),
                    answerE: $(answerItmes[4]).find("input[type=text]").val(),
                    answerF: $(answerItmes[5]).find("input[type=text]").val(),
                    minDescription: $this.find("input[name=minDescription]").val(),
                    maxDescription: $this.find("input[name=maxDescription]").val(),
                    ratioScope: $this.find("input[name=ratioScope]").val()
                };
                questionnaireItems.push(questionnaireItem);
            });
        }
        //科室标签
        var questionnaireDepts=[];
        function getQuestionnaireDepts() {
            $('table  .tags').find('.deptTags').children("span").each(function () {
                var $this=$(this);
                var questionnaireDept={
                    dictDepartmentId:$this.find("input[type=hidden]").val()
                };
                questionnaireDepts.push(questionnaireDept);
            })
//            params=questionnaireDepts;
        }
        //疾病标签
        var questionnaireDiseases=[];
        function getQuestionnaireDiseases() {
            $('table  .tags').find('.diseaseTags').children("span").each(function () {
                var $this=$(this);
                var questionnaireDisease={
                    dictDiseaseId:$this.find("input[type=hidden]").val()
                };
                questionnaireDiseases.push(questionnaireDisease);
            })
        }
        var questionnaire={};

        $('body').on('keydown',function (e) {
           var e = event||window.event;
            if(e.keyCode ==13){
                $("input,textarea").blur();
                $('.saveBtn').click();
            }
        });




        //保存
        form.on("submit(storage)",function(data){
            getQuestionnaireItems();
            getQuestionnaireDepts();
            getQuestionnaireDiseases();
            questionnaire={
                title:data.field.title,
                subTitle:data.field.subTitle,
                state:3,
                comment:$("form table").find("textarea").val()
            };
            data.field.questionnaire=questionnaire;
            data.field.questionnaireItems=questionnaireItems;
            data.field.questionnaireDiseases=questionnaireDiseases;
            data.field.questionnaireDepts=questionnaireDepts;

            $.ajax({
                url:'<%=staticPath%>/questionnaire/add',
                type:'post',
                data:JSON.stringify(data.field),
                dataType:'json',
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200){
                        layerTips.msg("保存问卷成功",{offset: '100px',icon:1});
                        $("#questionnaireId").val(result.entity);
                        window.history.back(-1);
                    }
                    else {
//                        $("#deptDiv").find("button").prop("disabled","");
                        layerTips.msg("保存问卷失败",{offset: '100px',icon:2});
                    }
                },
                error:function (result) {
//                    $("#deptDiv").find("button").prop("disabled","");
                    layerTips.msg("保存问卷失败",{offset: '100px',icon:2});

                }
            });
            questionnaireDepts=[];
            questionnaireItems=[];
            questionnaireDiseases=[];
            return false;
        });



        //发布
        form.on("submit(publish)",function(data){
            getQuestionnaireItems();
            getQuestionnaireDepts();
            getQuestionnaireDiseases();
            questionnaire={
                title:data.field.title,
                subTitle:data.field.subTitle,
                state:2,
                comment:$("form table").find("textarea").val()

            };
            data.field.questionnaire=questionnaire;
            data.field.questionnaireItems=questionnaireItems;
            data.field.questionnaireDiseases=questionnaireDiseases;
            data.field.questionnaireDepts=questionnaireDepts;
    //            var radio=0,checkbox=0,uploadImg=0,range=0,simpleAnswer=0;
            var item=0;
            for(var i=0;i<questionnaireItems.length;i++) {
                if (questionnaireItems[i].type == 1 || questionnaireItems[i].type == 2 || questionnaireItems[i].type == 3||questionnaireItems[i].type == 4
                ||questionnaireItems[i].type == 5)
                    item++;
                /*else if (questionnaireItems[i].type == 2)
                    item++;
                else if (questionnaireItems[i].type == 3)
                    item++;
                else if (questionnaireItems[i].type == 4)
                    item++;
                else if (questionnaireItems[i].type == 5)
                    item++;*/
                if (questionnaireItems[i].type == 4 && (questionnaireItems[i].minDescription.length <= 0 || questionnaireItems[i].maxDescription.length <= 0)) {
                    layerTips.msg("请完善题目内容", {offset: '100px',icon: 5});
                    questionnaireDepts=[];
                    questionnaireItems=[];
                    questionnaireDiseases=[];
                    return false;
                }
                if (questionnaireItems[i].type == 4 && (questionnaireItems[i].minDescription.length >20 || questionnaireItems[i].maxDescription.length >20)) {
                    layerTips.msg("最多输入20字", {offset: '100px',icon: 5});
                    questionnaireDepts=[];
                    questionnaireItems=[];
                    questionnaireDiseases=[];
                    return false;
                }
                if ((questionnaireItems[i].type == 1 || questionnaireItems[i].type == 2) && checkQuestionItems(questionnaireItems[i]) < 2) {
                    layerTips.msg("选择题至少两个选项，请完善题目内容", {offset: '100px',icon: 5});
                    questionnaireDepts=[];
                    questionnaireItems=[];
                    questionnaireDiseases=[];
                    return false;
                }

                if (questionnaireItems[i].title.length <= 0){
                    layerTips.msg("请添加题目", {offset: '100px',icon: 5});
                    questionnaireDepts=[];
                    questionnaireItems=[];
                    questionnaireDiseases=[];
                    return false;
                }
                if (questionnaireItems[i].title.length >100){
                    layerTips.msg("题干内容最多只能输入100个字符", {offset: '100px',icon: 5});
                    questionnaireDepts=[];
                    questionnaireItems=[];
                    questionnaireDiseases=[];
                    return false;
                }
            }
            if (item<1){
                layerTips.msg("请添加题目", {offset: '100px',icon: 5});
                questionnaireDepts=[];
                questionnaireItems=[];
                questionnaireDiseases=[];
                return false;

            }

            if (questionnaireDepts.length<1){
                layerTips.msg("请添加科室标签",{offset: '100px',icon:5});
                questionnaireDepts=[];
                questionnaireItems=[];
                questionnaireDiseases=[];
                return false;
            }
            $.ajax({
                url:'<%=staticPath%>/questionnaire/add',
                type:'post',
                data:JSON.stringify(data.field),
                dataType:'json',
                contentType:'application/json',
                success:function (result) {
                    if (result.code==200){
                        layerTips.msg("发布问卷成功",{icon:1});
                        $("#questionnaireId").val(result.entity);
                        window.history.back(-1);

                    }
                    else {
                        layerTips.msg("发布问卷失败",{offset: '100px',icon:2});
                    }
                },
                error:function (result) {
                    layerTips.msg("发布问卷失败",{offset: '100px',icon:2});
                }
            });
            questionnaireDepts=[];
            questionnaireItems=[];
            questionnaireDiseases=[];
            return false;
        });



        //预览
        $('.preview').on('click',function () {
            var qId = $('#questionnaireId').val();
            if (qId != "" && qId != null){
                window.open('<%=staticPath%>/questionnaire/preview/questionnaire/'+qId);
            }
            else {
                layerTips.alert('请先保存或发布随访问卷,然后再预览.', {offset: '100px',icon: 5});
            }
        });

        //触发删除单个科室
        /*$('.delDisease').on('click',function(){
            layer.confirm('真的删除科室吗?', { icon: 3, title: '系统提示',offset: '100px'},
                function (index, layero) {
                    $.ajax({
                        url: "",
                        dataType: 'json',
                        type: 'get',
                        contentType: 'application/json',
                        success: function (result) {
                            if (result.code == 200) {
                                layer.msg("删除成功", {icon: 1,offset: '100px'});
                                location.reload(true);
                            } else
                                layer.msg("删除失败", {icon: 2,offset: '100px'});
                        },
                        error: function (result) {
                            layer.msg("删除失败", {icon: 2,offset: '100px'});

                        }
                    });
                }
            );
        });*/

        //触发删除单个疾病
       /* $('.delDepartment').on('click',function(){
            layer.confirm('真的删除疾病吗?', { icon: 3, title: '系统提示',offset: '100px'},
                    function (index, layero) {
                        $.ajax({
                            url: "dictDeptList/query",
                            dataType: 'json',
                            type: 'get',
                            contentType: 'application/json',
                            success: function (result) {
                                if (result.code == 200) {
                                    layer.msg("删除成功", {icon: 1,offset: '100px'});
                                    location.reload(true);
                                } else
                                    layer.msg("删除失败", {icon: 2,offset: '100px'});
                            },
                            error: function (result) {
                                layer.msg("删除失败", {icon: 2,offset: '100px'});

                            }
                        });
                    }
            );
        });*/

        //触发添加科室标签
        $('.addDepartment').on('click',function () {
            layer.open({
                type:2,
                title:'添加科室标签',
                content:"<%=staticPath%>/questionnaire/toQuestionnaire/dept/0",
                area:['800px','500px'],
                offset: ['50px', '15%'],
                shadeClone:true,
                btn:['确认','取消'],
                yes:function (index,layero) {
                    $('.deptTags span').remove();
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    params=iframeWin.getParams();
                    var html="";
                    for (var i=0;i<params.length;i++){
                        html+='<span style="margin:5px;display: inline-block;"><input type="hidden" value="'+params[i].dictDepartmentId+'"/><a  href="javascript:"  class="layui-btn layui-btn-danger layui-btn-xs delDepartment" >'+params[i].name+'<i class="layui-icon">&#xe640;</i></a></span>';
                    }

                    $('table  .tags').find(' .deptTags').append(html);
                    $('table  .tags').find(' .deptTags').children("span").find("a").each(function () {
                        var $that=$(this);
                        $that.on('click',function () {
                            for(var i=0;i<params.length;i++){
                                if(Number($that.parent("span").find('input').val())==params[i].dictDepartmentId){
                                    params.splice(i,1);
                                }
                            }
                            $that.parent("span").remove();
                            params.splice(i,1);
                        })
                    });
                    layer.close(index);

                },
                success:function (layero,index) {

                },
                cancel:function (index,layero) {
                    layer.close(index);
                }
            });
        });

        //触发添加疾病标签
        $('.addDisease').on('click',function () {
            layer.open({
                type:2,
                title:'添加疾病标签',
                content:'<%=staticPath%>/questionnaire/toQuestionnaire/disease/0',
                area:['500px','500px'],
                offset: ['50px', '30%'],
                shadeClone:true,
                btn:['确认','取消'],
                yes:function (index,layero) {
                    $('.diseaseTags span').remove();
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：
                    params2=iframeWin.getSelectedDiseases();
                    var html="";
                    for (var i=0;i<params2.length;i++){
                        html+='<span style="margin:5px;display: inline-block;"><input type="hidden"  value="'+params2[i].dictDiseaseId+'"/><a  href="javascript:"  class="layui-btn layui-btn-danger delDisease" >'+params2[i].name+'<i class="layui-icon">&#xe640;</i></a></span>';
//                        html+='<span><input type="hidden"  value="'+params[i].dictDiseaseId+'"/>'+params[i].name+'<a  href="javascript:"  class="layui-btn layui-btn-danger layui-btn-xs delDepartment" ><i class="layui-icon">&#xe640;</i></a></span>';
//                        html+='<span style="margin:5px;display: inline-block;"><input type="hidden"  value="'+params[i].dictDiseaseId+'"/><a  href="javascript:"  class="layui-btn layui-btn-danger layui-btn-xs delDepartment" >'+params[i].name+'<i class="layui-icon">&#xe640;</i></a></span>';
                    }

                    $('table  .tags').find(' .diseaseTags').append(html);
                    $('table  .tags').find('.diseaseTags').children("span").find("a").each(function () {
                        var $that=$(this);
                        $that.on('click',function () {
                            for(var i=0;i<params2.length;i++){
                                if(Number($that.parent("span").find('input').val())==params2[i].dictDiseaseId){
                                    params2.splice(i,1);
                                }
                            }
                            $that.parent("span").remove();
                        })
                    });
                    layer.close(index);
                },

                cancel:function (index,layero) {
                    layer.close(index);
                }
            });
        });

        //添加单选题目
        $('#radioBtn').on('click',function () {
            $('#radioTemplate').tmpl('').appendTo('.content-subject');

            addIndex();
            form.render();
        });

        //添加多选题目
        $('#multipleBtn').on('click',function () {
            $('#multipleTemplate').tmpl('').appendTo('.content-subject');
            addIndex();
            form.render();
        });

        //添加简答题目
        $('#textBtn').on('click',function () {
            $('#textTemplate').tmpl('').appendTo('.content-subject');
            addIndex();
            form.render();
        });

        //添加滑块题目
        $('#sliderBtn').on('click',function () {
            $('#sliderTemplate').tmpl('').appendTo('.content-subject');
            addIndex();
            form.render();
        });

        //添加上传附件题目
        $('#annexBtn').on('click',function () {
            $('#annexTemplate').tmpl('').appendTo('.content-subject');
            addIndex();
            form.render();
        });

    });

</script>

</body>
</html>