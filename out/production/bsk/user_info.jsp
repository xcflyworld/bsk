<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>个人信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!-- 引入 layui.css -->
    <link rel="stylesheet" href="//unpkg.com/layui@2.7.6/dist/css/layui.css">
    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/address.css"/>

    <script type="text/javascript" src="./js/jquery-3.6.3.min.js"></script>
    <script src="./js/jquery.validate.js"></script>
    <script type="text/javascript" src="./js/layui/layui.js"></script>
    <script src="./layer/layer.js" type="text/javascript"></script>

    <script src="js/main.js" type="text/javascript"></script>
    <style>
        .text-input07{
            border: 1px solid silver;
            float: left;
            margin: 0 0 0 17px;
            position: relative;
            width: 172px;
            height: 34px;
            background-color: #f8f8f6;
            line-height: 34px;
        }


    </style>

</head>

<script>


 // const validate = () =>{
     $(function(){
         //让当前表单调用validate方法，实现表单验证功能
         $("#form_id").validate({
             debug:false, //调试模式，即使验证成功也不会跳转到目标页面
             rules:{     //配置验证规则，key就是被验证的dom对象，value就是调用验证的方法(也是json格式)
                 user_info_old_userPwd:{
                     required:true,  //必填。如果验证方法不需要参数，则配置为true
                     rangelength:[6,16],
                     maxlength:16

                 },
                 user_info_new_userPwd:{
                     required:true,
                     rangelength:[6,16],
                     // equalTo:'#user_info_old_userPwd'
                 },
                 validateCode:{
                     required:true,
                     rangelength:[4,4] //表示和id="spass"的值相同
                 },

             }
             ,
             messages:{
                 user_info_old_userPwd:{
                     required:"请输入原密码",
                     rangelength:$.validator.format("密码长度在必须为：{0}-{1}之间"),
                     maxlength:$.validator.format("密码最大长度为为：{0}个字符"),
                 },
                 user_info_new_userPwd:{
                     required:"请输入新密码",
                     rangelength:$.validator.format("密码长度必须为：{0}-{1}之间"),
                     // equalTo:"两次密码一致" //表示和id="spass"的值相同
                 },
                 validateCode:{
                     required:"请输入4位长度的验证码",
                     rangelength:"只能输入长度为{0}个字符的验证码"
                 },

             }
         });

     });



    /**
     * 随机验证码
     */
    const changeImg = () => {
        $("#codeImg").attr("src", "UserServlet?m=codeImg&t=" + Math.random())
    }


    /**
     * 根据电话号码查到用户所有信息，并更新密码
     */
    const savePwd = (userId) => {
        //旧密码
        let pwd = $("#user_info_old_userPwd").val().trim();
        //新密码
        let currentUserPwd = $("#user_info_new_userPwd").val().trim();
        //验证码
        let validateCode = $("#validateCode").val().trim();

        // console.log("v="+validate())
        // if(validate()){
            //验证码是否正确
            if(validateCode.length == 4){
                $.ajaxSettings.async = false;
                if(pwd == currentUserPwd){
                    layer.msg('两次密码输入的一致');
                }else{
                    $.get("UserServlet?m=updatePwd",{"code":validateCode,"oldPwd":pwd,"userPwd":currentUserPwd,"userId":userId},function (data){

                        if(data=="cf"){
                            layer.msg('验证码输入有误');
                        }else {
                            //验证码成功
                            if(data == "pf"){
                                layer.msg('原密码输入有误');
                            }else{
                                if(data == "Y"){
                                    layer.msg('密码修改成功');
                                    setTimeout(function () {
                                        top.location.href="main.jsp"
                                    }, 1000)
                                }
                            }
                        }
                    })

                }

                $.ajaxSettings.async = true;
            }else{
                if(validateCode.length == 0){
                    layer.msg('验证码不能为空');
                }else {
                    layer.msg('验证码长度必须为4个字符');
                }

            }
        // }





    }

    /**
     * 修改用户信息
     */
    const save = (userId) => {

        let userName = $("#user_info_userName").val().trim();
        let userSex = $("#user_info_userSex").val().trim();


        if (userName.length >= 2 && userName.length <= 20) {
            $.ajaxSettings.async = false;
            $.post("UserServlet?m=updateUser", {
                "userName": userName,
                "userSex": userSex,
                "userId": userId,
            }, function (data) {
                // alert(data);
                if (data == "Y") {
                    //修改成功
                    //提示层
                    layer.msg('修改成功');
                    setTimeout(function () {
                        top.location.reload();
                    }, 1000)

                } else {
                    //修改失败
                    layer.msg('修改失败');
                }
            });

            $.ajaxSettings.async = true;
        } else {
            layer.msg("姓名长度2-20个字符")
        }

        console.log("userName=" + userName + ",userSex=" + userSex);


    }


</script>
<body>
<div class="m-address">
    <div class="wrapper">
        <div class="area" style="bottom:110px;">
            <div class="type border-bottom">
                <span class="left">个人信息</span>
            </div>
            <div class="title1 a-user">
                <div class="fl">
							<span><img src="images/member/desc-icon-name.png"/>
								姓名/性别</span>
                    <span class="pad">${sessionScope.user.userName} ${sessionScope.user.userSex == "M"?"先生":"女士"}</span>
                </div>
                <div class="fr">
                    <a href="#" class="login-redcolor" onclick="change('name_sex',1)" on>修改</a>
                </div>
            </div>
            <div style="display: none;" class="title1 a-user a-setuser change"
                 id="update_name_sex">
                <div class="fl userleft">
							<span><img src="images/member/desc-icon-name.png"/>
								姓名/性别</span>
                </div>
                <div class="text-input07" style="width: 155px">
                    <input id="user_info_userName" type="text" name="userName" placeholder="姓名"
                           onfocus="if (value ==='${sessionScope.user.userName}'){value =''}"
                           onblur="if (value ===''){value='${sessionScope.user.userName}'}"
                           value="${sessionScope.user.userName}"/>
                </div>
                <div>
                    <%--                    value="${sessionScope.user.userSex == "M"?"先生":"女士"}"--%>
                    <select class="text-input07" id="user_info_userSex" name="userSex" type="text">


                        <option value="M"   ${sessionScope.user.userSex=='M'?'selected':''}>先生</option>
                        <option value="F"  ${sessionScope.user.userSex=='F'?'selected':''}>女士</option>
                    </select>
                    <span class="add-icon cursor"></span>
                </div>
                <div class="act-botton clear">
                    <div class="save-button">
                        <a href="javascript:" class="radius" onclick="save('${sessionScope.user.userId}')">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('name_sex',2)">取消</a>
                    </div>
                </div>
            </div>
            <div class="border-bottom"></div>
            <div class="title1 a-user">
                <div class="fl">
							<span><img src="images/member/desc-icon-phone.png"/>
								手机号码</span>
                    <span class="pad" id="userTel">

                        ${sessionScope.user.userTel}</span>
                </div>
            </div>
            <div class="border-bottom"></div>
            <div>
                <form action="" id="form_id">
                    <fieldset>
                        <div class="title1 a-user">
                            <div class="fl">
                                <span><img src="images/login/icon-name.png"/> 登陆密码</span>
                                <input type="password"  value="${sessionScope.user.userPwd}" style="border: none"
                                       class="pad"/>
                                <span class="add-icon cursor"></span>
                            </div>
                            <div class="fr">
                                <a href="#" class="login-redcolor" onclick="change('pwd',1)">修改</a>
                            </div>
                        </div>
                        <div style="display: none;" class="title1 a-user change" id="update_pwd">
                            <div class="fl">
                                <span><img src="images/login/icon-name.png"/>登陆密码</span>
                            </div>
                            <div class="fl">
                                <div>
                                    <input class="text-input07"
                                           type="password"
                                           id="user_info_old_userPwd"
                                           name="user_info_old_userPwd"
                                           onfocus="if (value ==='请输入旧密码'){value =''}"
                                           onblur="if (value ===''){value='请输入旧密码'}"
                                           placeholder="请输入旧密码"/>
                                </div>
                                <div class="fr">
<%--                                    <span style="line-height: 20px; margin-left: 10px">--%>
<%--                                        请输入6-16位密码，可使用阿拉伯数字,--%>
<%--                                        英文字母或两者结合--%>
<%--                                    </span>--%>
                                </div>
                                <br/>
                                <div>
                                    <input  class="text-input07" type="password"
                                           id="user_info_new_userPwd"
                                            name="user_info_new_userPwd"
                                           onfocus="if (value ==='请输入新密码'){value =''}"
                                           onblur="if (value ===''){value='请输入新密码'}"
                                           placeholder="请输入新密码"/>
                                </div>
                                <br/>
                                <div>
<%--                                <div class="text-input07">--%>
                                    <input class="text-input07" type="text"
                                           id="validateCode"
                                           name="validateCode"
                                           onfocus="if (value ==='请输入验证码'){value =''}"
                                           onblur="if (value ===''){value='请输入验证码'}"
                                           placeholder="请输入验证码"/>
                                </div>
                                <div class="fl">
                                    <p style="line-height: 30px; margin-left: 10px">
                                        <img id="codeImg" src="UserServlet?m=codeImg" alt=""/>
                                        看不清？
                                        <a href="javascript:changeImg()" class="login-redcolor">换一张</a>
                                    </p>
                                </div>
                            </div>
                            <div class="act-botton clear"
                                 style="margin: 20px 0; padding: 20px 0">
                                <div class="save-button">
                                    <a href="javascript:"
                                       class="radius"
                                       onclick="savePwd('${sessionScope.user.userId}')"
                                    >保存</a>
                                </div>
                                <div class="cancel-button">
                                    <a href="javascript:" class="radius" onclick="change('pwd',2)">取消</a>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>

        </div>
    </div>
</div>
</div>
</body>
</html>
