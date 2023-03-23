<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css"/>
    <link rel="stylesheet" type="text/css" href="css/address.css"/>
    <script src="./js/jquery-3.6.3.min.js"></script>
    <script src="js/area/distpicker.data.js"></script>
    <script src="js/area/distpicker.js"></script>
    <script type="text/javascript" src="./js/layui/layui.js"></script>
    <script src="./js/handlebars.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <title>地址</title>
</head>

<body style="background:#F1F5F4">
<%@include file="top.jsp" %>

<div class="m-address clear">
    <div class="wrapper">
        <div class="area clear" style="padding-left:20px">

            <!-- 送餐方式 -->
            配餐地址
            <div class="type clear">
                <span class="left" style="width:400px;" id="order_address"></span>
                <select id="containerCart" onclick="modifyaddress()" class=" rb-red" style="margin-right:10px">选择 v
                    <script type="text/x-handlebars-template" id="templateCart">
                        {{#each this}}
                        <option>
                            {{addressProvince}}-{{addressCity}}-{{addressDistrict}}-{{addressDescribe}}
                        </option>
                        {{/each}}
                    </script>
                </select>

                <%--                <a href="" class=" rb-red" style="margin-right:10px">选择 v</a>--%>
                <a href="#" class=" rb-red" onclick="change('addaddress',3)">+使用新地址</a>
                <%--                javascript:addAddress()--%>

            </div>

            <!--  old  -->
            <div style="display: none; margin-left:-150px" id="insert_addaddress" class="change">
                <div style="margin-top: 20px" data-toggle="distpicker">
                    <span class="m-wt" style="padding: 0 30px"></span>
                    <select name="" id="add_addressProvince${sessionScope.user.userId}"
                            style="width: 110px;height: 32px"></select>
                    —
                    <select name="" id="add_addressCity${sessionScope.user.userId}"
                            style="width: 110px;height: 32px"></select>
                    —
                    <select name="" id="add_addressDistrict${sessionScope.user.userId}"
                            style="width: 110px;height: 32px"></select>
                    —
                    <input
                            id="add_addressDescribe${sessionScope.user.userId}" type="text"
                            class="t-ad" style="width: 110px;height: 27px"
                            placeholder="描述"/>


                </div>

                <div class="act-botton clear"
                     style="margin: 20px 40px; padding: 20px 0">
                    <div class="save-button">
                        <a href="javascript:addAddress('${sessionScope.user.userId}')" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('addaddress',4)">取消</a>
                    </div>
                </div>
            </div>


        </div>
        <div class="area">
            <div class="addr-box-line">
                <span class="text-w02 fl">顾客姓名</span>
                <span class="text-w02 fl">${sessionScope.user.userName}</span>
            </div>
            <div class="addr-box-line">
                <span class="text-w02 fl">联系电话</span>
                <span class="text-w02 fl">${sessionScope.user.userTel}</span>
            </div>
            <div class="addr-box-line">

                <span class="text-w02 fr">总共金额</span>
                <span class="text-w02 fr"><span class="login-redcolor" style="font-size:24px"
                                                id="total"></span>元</span>

                </script>
            </div>
            <div class="addr-box-line" id="j-address-reminder">
            </div>
            <div class="act-botton" id="j-act-botton" style="padding:10px 50px; ">
                <div style="padding:10px 50px; background:#DF544E; width:120px; text-align:center;
        border-radius:5px
       "><a href="OrderServlet?m=submitOrder" style="color:#FFF; font-size:22px;">提交订单 &gt;</a></div>
            </div>
        </div>


        <div class="area clear" style="margin-top:60px; font-size:14px; color:#999; padding-left:30px">
            友情提示：网络订餐不提供订单修改和取消功能，请提交前仔细核实订单内容
        </div>
    </div>


    <%@include file="foot.jsp" %>

</div>
</body>
</html>
<script>
    //获取需要放数据的容器
    let containerCart;
    //获取我们定义的模板的dom对象。主要是想获取里面的内容
    let templateCart;

    $(document).ready(function () {
        containerCart = $('#containerCart');
        templateCart = $('#templateCart');
        selectAddress();

    });

    $.get("CartServlet?m=getCart", function (data) {
        console.log(data);
        data = JSON.parse(data);
        let count = 0; //总金额
        let num = 0;  //餐品总数量

        for (let e of data) {
            count += e.productPrice * e.productNum;
            num += e.productNum;
        }


        count = Math.round(count * 100) / 100;

        $("#total").html(count);
    })
    const selectAddress = () => {

        $.get("OrderServlet?m=selectAddress", {}, function (data) {
            console.log(data);
            data = JSON.parse(data);
            //编译模板的里的内容
            var template = Handlebars.compile(templateCart.html());
            // console.log("template="+template)
            //把后台获取到的数据渲染到页面
            containerCart.html(template(data));
        })

    }

    const modifyaddress = () => {
        console.log($("#containerCart").val())
        $("#order_address").html(($("#containerCart").val()))
    }


    const addAddress = (id) => {
        let addressProvince = $("#add_addressProvince" + id).val().trim();
        let addressCity = $("#add_addressCity" + id).val().trim();
        let addressDistrict = $("#add_addressDistrict" + id).val().trim();
        let addressDescribe = $("#add_addressDescribe" + id).val().trim();
        $.ajaxSettings.async = false;
        console.log(addressProvince + " " + addressCity + " " + addressDistrict + " " + addressDescribe)
        if (addressDescribe.length > 0 && addressDescribe.length <= 50) {
            $.post("AddressServlet?m=addAddress",
                {
                    "addressProvince": addressProvince,
                    "addressCity": addressCity,
                    "addressDistrict": addressDistrict,
                    "addressDescribe": addressDescribe,
                    "userId": id,
                }
                , function (data) {
                    // alert(data)
                    if (data == "Y") {
                        layer.msg("添加地址成功");
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000)
                    } else if (data == "af") {
                        layer.msg("添加失败，地址重复");
                    } else {
                        layer.msg("添加失败");
                    }
                })
        } else {
            if (addressDescribe.length == 0) {
                layer.msg("地址不能为空");
            } else {
                layer.msg("地址长度在1-50个字符之间");
            }

        }

        $.ajaxSettings.async = true;

    }
</script>
<%--<script>--%>
<%--    //获取需要放数据的容器--%>
<%--    let containerCart;--%>
<%--    //获取我们定义的模板的dom对象。主要是想获取里面的内容--%>
<%--    let templateCart;--%>

<%--    $(document).ready(function () {--%>
<%--        containerCart = $('#containerCart');--%>
<%--        templateCart = $('#templateCart');--%>

<%--$.get("CartServlet?m=getCart", function (data) {--%>
<%--console.log(data);--%>
<%--data = JSON.parse(data);--%>
<%--let count = 0; //总金额--%>
<%--let num = 0; //餐品总数量--%>

<%--for (let e of data) {--%>
<%--count += e.productPrice * e.productNum;--%>
<%--num += e.productNum;--%>
<%--}--%>


<%--count = Math.round(count * 100) / 100;--%>

<%--$("#total").html(count);--%>
<%--// $("#num").html(num);--%>
<%--//编译模板的里的内容--%>
<%--var template = Handlebars.compile(templateCart.html());--%>
<%--//把后台获取到的数据渲染到页面--%>
<%--containerCart.html(template(data));--%>

<%--        })--%>

<%--    })--%>
<%--</script>--%>

