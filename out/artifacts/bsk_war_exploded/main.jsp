<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <title>首页</title>
    <script type="text/javascript"
            src="./js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript" src="./js/layui/layui.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>


</head>

<body>

<%@include file="top.jsp"%>
<!-- 首页内容区域 -->
<div class="m-main">
    <div class="m-main-box m-home" id="j-homepage">
        <div class="ui-chat" id="j-chat">
            <div class="online chat" id="j-chat-online"></div>
            <div class="offline chat" id="j-chat-offline">
                <div class="tip"></div>
            </div>
        </div>

        <!--大Banner轮播区域 begin-->
        <div class="banner" id="j-banner">
            <div class="banner-item">
                <ul>
                    <li>
                        <a href="#" alt='' onfocus='this.blur()'><img
                                src="images/banner/Banner_1_2017_12_12_12_03_31.jpg" alt=''
                                null /> </a>
                    </li>
                    <li>
                        <a href="#" alt='必胜客荟萃中华九合一比萨全新上市' onfocus='this.blur()'><img
                                src="images/banner/Banner_1_2017_12_27_14_10_03.jpg"
                                alt='必胜客荟萃中华九合一比萨全新上市' null /> </a>
                    </li>
                    <li>
                        <a href="#" alt='' onfocus='this.blur()'><img
                                src="images/banner/Banner_1_2017_12_27_14_15_41.jpg" alt=''
                                null /> </a>
                    </li>
                    <li>
                        <a href='javascript:' alt='' style='cursor: default'
                           onfocus='this.blur()'><img
                                src="images/banner/Banner_1_2018_01_04_16_48_03.jpg" alt=''
                                null /> </a>
                    </li>
                </ul>
            </div>
            <div class="banner-nav"></div>
        </div>
        <!--大Banner轮播区 end-->

        <!-- 菜单导航 -->
        <div class="nav">
            <div class="nav-menu clear-fix">
                <div class="menu-box clear-fix">
                    <a href="#">
                        <dl nameEn="">
                            <dt>
                                <img src="images/banner/Banner_18_2017_08_28_14_24_36.jpg"
                                     alt="39元十翅" />
                            </dt>
                            <dd class="font-weight">
                                39元十翅
                            </dd>
                            <dd></dd>
                        </dl> </a>
                    <a href="#"><dl nameEn="">
                        <dt>
                            <img src="images/banner/Banner_18_2017_12_27_15_10_01.jpg"
                                 alt="比萨" />
                        </dt>
                        <dd class="font-weight">
                            比萨
                        </dd>
                        <dd></dd>
                    </dl> </a>
                    <a href="#"><dl nameEn="">
                        <dt>
                            <img src="images/banner/Banner_18_2017_08_28_14_25_23.jpg"
                                 alt="小吃" />
                        </dt>
                        <dd class="font-weight">
                            小吃
                        </dd>
                        <dd></dd>
                    </dl> </a>
                    <a href="#"><dl nameEn="">
                        <dt>
                            <img src="images/banner/Banner_18_2017_08_28_14_25_56.jpg"
                                 alt="饮料" />
                        </dt>
                        <dd class="font-weight">
                            饮料
                        </dd>
                        <dd></dd>
                    </dl> </a>

                    <a href="#"><dl nameEn="">
                        <dt>
                            <img src="images/banner/Banner_18_2017_12_27_17_34_47.jpg"
                                 alt="意面" />
                        </dt>
                        <dd class="font-weight">
                            意面
                        </dd>
                        <dd></dd>
                    </dl> </a>
                    <a href="#">
                        <dl nameEn="All Menu">
                            <dt>
                                <div class="more"></div>
                            </dt>
                            <dd class="font-weight">
                                全部餐品
                            </dd>
                            <dd></dd>
                        </dl> </a>

                </div>
                <a href="#"><div class="coupon-left" id="j-combo">
                    <div class="title">
                        当季特选
                    </div>
                    <div class="desc font14">
                        &nbsp;
                    </div>
                </div> </a>

                <a href="javascript:" style="cursor: default"><div
                        class="coupon-right hidden" id="j-workday-lunch"
                        startTime="00:01" endTime="23:59">
                    <div class="title">
                        登录享更多优惠活动
                    </div>
                    <div class="desc font14">
                        &nbsp;
                    </div>
                </div> </a>
            </div>
        </div>
        <div class="img-banner">
            <a href="#"> <img
                    src="images/banner/Banner_22_2017_08_28_14_34_03.jpg" alt="" />
            </a>
        </div>
        <div class="img-banner">
            <a href="#"> <img
                    src="images/banner/Banner_22_2017_10_20_16_10_58.jpg" alt="" />
            </a>
        </div>
        <!-- 下载区域 -->
        <div class="down_level" alt="下载必胜客全新App ">
            <div class="down_content">
                <div class="down-content-left">
                    <div class="down_title">
                        下载必胜客全新App
                    </div>
                    <div class="down-info-tip">
                        外送订餐更方便
                    </div>
                    <div class="down-info-tip">
                        餐厅和外送消费都能赚K金积分
                    </div>
                    <div class="down-info-tip">
                        全新K金商城，好礼兑不停
                    </div>
                    <div class="down-info-tip">
                        优惠券商城，独家优惠天天享
                    </div>
                    <div class="down-info-tip">
                        超级App，轻松好用，一手掌控
                    </div>
                </div>
                <div class="down-content-center">
                    <div class="down-iphone-content">
                        <a href="" target="_blank" class="down_ios">iOS下载</a>
                    </div>
                    <div class="down-android-content">
                        <a href="" target="_blank" class="down_ad">Android下载</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /菜单导航 -->
</div>
<!-- /首页内容区域 -->
<%@include file="foot.jsp" %>


<!-- 购物车-->
<c:if test="${sessionScope.user != null}">
    <%@include file="cart.jsp"%>
</c:if>



</body>
</html>
