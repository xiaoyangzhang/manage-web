<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String staticPath=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width">
    <meta name="format-detection" content="telephone=no, email=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title></title>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        *, :after, :before { -webkit-box-sizing: border-box;box-sizing: border-box;}
        header {position: relative;width: 100%;height: 40px;line-height: 40px;padding: 0 10px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;font-size: 1.4rem;}
        .headImg{max-width: 100%;display: block;margin: 0 auto;}
    </style>
</head>
<body>
<header><h1></h1></header>
<img src="" alt="" class="headImg">
<div class="mainCon">

</div>

<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.js"></script>
<script type="text/javascript">

    function GetQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    $(function() {
        var id = GetQueryString("id");
        $.ajax({
            type: "GET",
            url:'<%=staticPath%>/publish/detail/'+id,
            contentType:'application/json',
            success: function(res){
                if(res.code=="200"){
                    var data = res.entity;
                    if(data.isQuote == 1){
                        window.open(data.h5Url);
                    }else{
                        $('h1').text(data.subtitle);
                        $('.headImg').attr('src',data.titlePic);
                        $('.mainCon').html(data.body);
                    }
                }else{

                }
            }
        });
    });
</script>
</body>
</html>
