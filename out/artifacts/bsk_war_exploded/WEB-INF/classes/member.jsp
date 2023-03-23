<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css" />
    <title>会员管理</title>
    <script type="text/javascript"
            src="./js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript" src="./js/layui/layui.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <%--    <script type="text/javascript" src="./js/jquery.validate.js"></script>--%>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".center-bg li:first").addClass("on");
            $("#url").attr('src', 'user_info.jsp');
            $(".center-bg li").click(function () {
                $(".center-bg li").removeClass("on");
                $(this).addClass("on");
                $("#url").attr('src', $(this).children("input").val());
            });
        });
    </script>
</head>
<body style="background: #efeee9;">
<input type="hidden" id="pageName" value="customerCenter"/>
<input type="hidden" id="morePrivilege" value="false"/>
<form id="j-main-form" action="">
    <%@include file="top.jsp" %>

    <div id="j-popup-captcha"></div>
    <div id="j-popup-click"></div>

    <div class="m-customer-center">
        <div class="ui-chat" id="j-chat">
            <div class="online chat"></div>
            <div class="offline chat">
                <div class="tip"></div>
            </div>
        </div>

        <div id="j-center-top" class="top-bg">
            <div class="img"></div>
        </div>
        <div class="center-bg">
            <div class="fl center-left">
                <ul class="font14 cursor">
                    <li>
                        <input type="hidden" value="user_info.jsp"/>
                        <a num="7" class="tab07" href="javascript:">个人信息</a>
                    </li>
                    <li>
                        <input type="hidden" value="AddressServlet?m=addressList"/>
                        <a num="6" class="tab06" href="javascript:">地址管理</a>
                    </li>

                    <%--                    是管理员才能进行用户管理--%>


<%--                    ${sessionScope.user.userRole == 'U' ? 'style="display: none"':'' }--%>
                    <c:if test="${sessionScope.user.userRole == 'A'}">
                    <li >
                        <input type="hidden" value="UserServlet?m=getUserList"/>
                        <a num="1" class="tab01" href="javascript:">用户管理</a>
                    </li>


                    <li>
                        <input type="hidden" value="CategoryServlet?m=categoryList"/>
                        <a num="6" class="tab08" href="javascript:">分类管理</a>
                    </li>
                    <li>
                        <input type="hidden" value="ProductServlet?m=productList"/>
                        <a num="7" class="tab09" href="javascript:">餐品管理</a>
                    </li>
                    <li>
                        <input type="hidden" value="order.jsp"/>
                        <a num="5" class="tab05" href="javascript:">订单管理</a>
                    </li>
                    </c:if>
                </ul>
            </div>
            <div id="j-customer-center-right" class="center-right">
                <div class="m-member-home">
                    <div class="center">
                        <div class="left center-left">
                            <iframe id="url" frameborder="0" height="600px" , width="100%" src=""
                                    scrolling="no"></iframe>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <%@include file="foot.jsp" %>


</form>
<!-- 购物车-->
<c:if test="${sessionScope.user != null}">
    <%@include file="cart.jsp"%>
</c:if>


</body>
</html>
