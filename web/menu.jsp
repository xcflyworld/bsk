<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css"/>
    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css"/>
    <title>点餐菜单</title>
    <script src="js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript" src="./js/layui/layui.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="./js/jquery.fly.min.js"></script>
    <!-- 兼容IE10 -->
    <script type="text/javascript" src="js/requestAnimationFrame.js"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(document).ready(function () {
            $(".m-main li").click(function () {
                $(".m-main li").removeClass("on");
                $(this).addClass("on");
            });
        });

        //添加餐品特效
        function productFly(t) {
            let cartLeft = $('#cart_image').offset().left - $(document).scrollTop(); // 获取a标签距离屏幕顶端的距离(因为fly插件的start开始位置是根据屏幕可视区域x，y来计算的，而不是根据整个文档的x，y来计算的)
            let cartTop = $('#cart_image').offset().top; // 获取a标签的y坐标
            let btnLeft = $(t).parent().find('img').offset().left - $(document).scrollTop() + 20;
            let btnTop = $(t).parent().find('img').offset().top + 20;

            let img = $(t).parent().find('img').attr('src');
            let flyer = $('<img class="u-flyer" src="' + img + '">');
            flyer.fly({
                start: {
                    left: btnLeft,
                    top: btnTop
                },
                end: {
                    left: cartLeft, //结束位置（必填）
                    top: cartTop, //结束位置（必填）
                    width: 0, //结束时宽度
                    height: 0 //结束时高度
                },
                onEnd: function () { //结束回调
                    this.destory(); //移除dom
                }
            });

        }

        /**
         * 添加购物车
         */
        function addCart(productId, userId, t) {
            //权限
            if (userId == "") {
                show('', 550, 550, 'login.jsp');
            } else {
                //添加购物车
                $.post("CartServlet?m=addCart", {"productId": productId, "userId": userId}, function (data) {
                    if (data == "Y") {
                        productFly(t);
                        //重新获取列表
                        getCart();
                    } else {
                        layer.msg("添加购物车失败");
                    }
                })
            }
        }

    </script>

</head>
<body style="background: #efeee9;">
<input type="hidden" id="pageName" value="customerCenter"/>
<input type="hidden" id="morePrivilege" value="false"/>
<form id="j-main-form" action="">

    <%@include file="top.jsp" %>
    <input type="hidden" id="userName" value="${requestScope.user.userName}">
    <div class="m-main">
        <div class="m-menu fl">
            <ul>
                <!-- 菜单 -->
                <li class="${requestScope.categoryId == null ? "on":""}" onclick="change(this)">
                    <a href="MenuServlet?m=menuList"> 当季特选</a>
                </li>
                <c:forEach items="${requestScope.categoryList}" var="ca">

                    <li class="${requestScope.categoryId != null && requestScope.categoryId == ca.categoryId?"on":""}"
                        id="extId2" cn="${ca.categoryName}" en="" onclick="change(this)">
                        <a href="MenuServlet?m=menuList&categoryId=${ca.categoryId}"> ${ca.categoryName}</a>
                    </li>
                </c:forEach>
                <!-- /菜单 -->
            </ul>
        </div>
        <div class="m-menu-content fr" style="position: relative; top: 70px">
            <!-- 产品列表 -->
            <div style="height: 450px; display: none;"></div>
            <div class="m-product-list">

                <c:forEach items="${requestScope.productList}" var="p">
                    <div class="product" condid="0" style="background: #FFF">
                        <div class="img cursor">
                            <img src="upload/${p.productPic}"/>
                        </div>
                        <div class="title">
                                ${p.productName}
                        </div>
                        <div class="desc grey">
                        </div>
                        <div class="order j-menu-order" onclick="addCart('${p.productId}','${sessionScope.user.userId}',this)">
                            <div id="${p.productId}" class="start ui-bgbtn-green">
                                +
                            </div>
                        </div>
                    </div>

                </c:forEach>

            </div>


            <!-- /产品列表 -->
        </div>
    </div>
    </div>
    </div>

    <%@include file="foot.jsp" %>


</form>


<!-- 购物车-->
<c:if test="${sessionScope.user != null}">
    <%@include file="cart.jsp" %>
</c:if>
</body>
</html>
<script>

</script>