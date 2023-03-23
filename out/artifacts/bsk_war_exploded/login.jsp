<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <title>登录</title>

    <script type="text/javascript">
        function login(){
            let userTel = $("#userTel").val().trim();
            let userPwd = $("#userPwd").val().trim();

            //验证参数
            // let userTel_test = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;

            let userTel_test = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
            // let userPwd_test = /^[a-zA-Z]\w{5,15}$/;

            if(userTel_test.test(userTel)){
                if(userPwd.length>=6 && userPwd.length<=16){
                    //执行登录
                    $.post("UserServlet?m=login",{"userTel":userTel,"userPwd":userPwd},function (data) {
                        if(data == "Y"){
                            top.location.reload();  //顶层页面刷新
                        }else if(data == "N"){
                            layer.msg("用户已停用，无法登录，请联系管理员");
                        }else{
                            layer.msg("账户或者密码错误");
                        }
                    })
                }else{
                    layer.msg("密码，长度6-16字符");
                }
            }else{
                layer.msg("请输入有效的手机号码");
            }

        }


    </script>
</head>

<body>

<!--login begin-->
<div class="m-login">
    <div class="login-logo"><img src="images/common/logo.png" /></div>
    <div class="login-title border-bot login-redcolor" style="font-weight:normal">账号密码登陆</div>
    <div class="input-box  border-bot"><img src="images/login/icon-phone.png" /><input id="userTel" type="text" placeholder="请输入手机号"  class="input-box1"/></div>
    <div class="input-box  border-bot"><img src="images/login/icon-password.png" /><input id="userPwd" type="text" placeholder="密码，长度6-16字符"  class="input-box1" /></div>
    <div class="input-box" style="text-align:left"
    ><a href="register.jsp" class="login-redcolor" style="text-decoration:underline; font-size:18px">快速注册</a></span></div>
    <div class="input-box "></div>
    <div class="login-me cursor" onclick="login()"><button class="cursor">登陆</button></div>
</div>
<!--login end-->
</body>
</html>

