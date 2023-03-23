<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <script src="./js/jquery-3.6.3.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>

    <title>注册</title>
</head>

<script>


    let userSex = 'M';
    //获取性别的值


    const reg = () => {

        let userTel = $("#userTel").val().trim();
        let userPwd = $("#userPwd").val().trim();
        let userName = $("#userName").val().trim();
        // console.log(userSex)
        let userTel_test = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;


        if (userTel_test.test(userTel)) {
            if (userPwd.length >= 6 && userPwd.length <= 16) {

                if (userName.length > 0 && userName.length <= 20) {
                    console.log("userSex=" + userSex)
                    $.ajaxSettings.async = false;
                    //执行登录
                    $.post("UserServlet?m=register", {
                        "userTel": userTel,
                        "userPwd": userPwd,
                        "userName": userName,
                        "userSex": userSex
                    }, function (data) {

                        // alert(data)
                        if (data == "Y") {

                           top.location.href= "main.jsp";
                            // top.location.reload();  //顶层页面刷新
                        } else {
                            layer.msg("用户已存在，注册失败！");
                        }
                    })

                    $.ajaxSettings.async = true;
                } else {
                    if (userName.length <= 0) {
                        layer.msg("姓名不能为空");
                    } else {
                        layer.msg("姓名，最长为20字符");
                    }

                }

            } else {
                layer.msg("密码，长度6-16字符");
            }
        } else {
            layer.msg("请输入有效的手机号码");
        }

    }
    const changeSex = (v) => {
        userSex = v;
        $("#userSex").find("a").removeClass("login-redcolor");
        $("#" + v).addClass("login-redcolor");
    }


</script>
<body>

<!--register begin-->
<div class="m-login">
    <div class="login-logo"><img src="images/common/logo.png"/></div>
    <div class="login-title border-bot">欢迎注册加入会员中心</div>
    <div class="input-box  border-bot"><img src="images/login/icon-phone.png"/>
        <input type="text" id="userTel" name="userTel" placeholder="请输入手机号" class="input-box1"/>
    </div>
    <div class="input-box  border-bot"><img src="images/login/icon-password.png"/>
        <input type="text" id="userPwd" name="userPwd" placeholder="密码，长度6-16字符" class="input-box1"/>
    </div>
    <div class="input-box  border-bot"><img src="images/login/icon-name.png"/>
        <input type="text" id="userName" name="userName" placeholder="姓名，最多5个字"/>

        <span id="userSex">
            <a id="M" href="#" class="login-redcolor" onclick="changeSex('M')">
<!--           <input type="radio" name="userSex" value="M">-->
                先生</a> |
            <a id="F" href="#" style="margin:0" onclick="changeSex('F')">
<!--             <input type="radio" name="userSex" value="W">-->
                女士</a>
        </span>
    </div>
    <div class="input-box "></div>
    <div class="login-me cursor" onclick="reg()">
        <button class="cursor" >立即注册</button>
    </div>
</div>
<!--register end-->
</body>
</html>
