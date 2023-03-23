<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

    //菜单切换
    function changemenu() {
        $("#menu").toggle();
    }


    /**
     * 判断用户是不是登录了
     * @param f
     */
    function checkUser(f) {
        if (f) {
            location.href = "menu.jsp";
        } else {
            show('', 550, 550, 'login.jsp');
        }
    }

</script>
<div class="m-top">
    <div class="box" id="j-top-nav">
        <a href="main.jsp">
            <div class="logo fl"></div>
        </a>
        <a href="MenuServlet?m=menuList">
            <div class="menu fl" style="width:100px">
                菜单
            </div>
        </a>

        <c:if test="${sessionScope.user != null}">
            <div class="separator fl"></div>
            <a href="member.jsp">
                <div class="menu fl" style="width:100px">
                    会员中心
                </div>
            </a>
            <input type="hidden" id="j-is-login" value="false"/>
        </c:if>
        <div class="clien fl">
            <div id="login-out" class="" onclick="changemenu()">${sessionScope.user.userName}
                <img src="images/common/arrow-down.png" align="center" />
            </div>
<%--            <a href="#" class="menu" onclick="change()">${user.userName}</a>--%>
<%--            <dl style="display: none; background-color: white;" id="menu"> <!-- 二级菜单 -->--%>
<%--                <dd><a href="UserServlet?m=logout">安全退出</a></dd>--%>
<%--            </dl>--%>
        </div>
        <div class="start fr" id="j-start-order"
             onclick="checkUser(${sessionScope.user == null?false:true})">
            立即点餐
        </div>
        <input type="hidden" id="isMemberLogin" value=""/>
        <input type="hidden" id="isNewLogin" value=""/>
        <input type="hidden" id="j-is-index" value="true"/>
        <input type="hidden" id="j-has-order" value="false"/>
        <input type="hidden" id="j-order-type" name="orderType" value="null"/>
        <input type="hidden" id="j-defaultClassHtmlName" value="Special.htm"/>
        <input type="hidden" id="j-username-afterlogin" value=""/>

    </div>
</div>

<script>

    //退出登录
    layui.use('dropdown', function(){

        var dropdown = layui.dropdown
        dropdown.render({
            elem: '#login-out' //可绑定在任意元素中，此处以上述按钮为例
            ,
            data: [
                //         {
                //   title: '用户信息'
                //   ,id: 100
                //   ,href: '#'
                // },
                {
                    title: '退出登录'
                    ,id: 101
                    ,href: 'UserServlet?m=logout' //开启超链接
                    ,target: '_blank' //新窗口方式打开

                }]

            ,id: 'login-out'
            //菜单被点击的事件
            ,click: function(obj){

                console.log(obj);
                layer.msg('回调返回的参数已显示再控制台');
            }
        });
    });
</script>