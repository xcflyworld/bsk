<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 19:09
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
    <link rel="stylesheet" type="text/css" href="css/menu.css"/>
    <%--    <link rel="stylesheet" type="text/css" href="./js/layui/css/layui.css" />--%>
    <title>用户管理</title>
    <script type="text/javascript" src="./js/jquery-3.6.3.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        const resetPwd = (id) => {
            layer.confirm('确定要重置密码吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                $.ajaxSettings.async = false;
                $.post("UserServlet?m=updateUser", {"userId": id, "userPwd": "000000"}, function (data) {
                    if (data == 'Y') {
                        layer.msg('密码重置成功');
                    } else {
                        layer.msg('密码重置失败');
                    }

                    setTimeout(function () {
                        window.location.reload();
                    }, 1000)
                })
            })
        }
        const query = () => {

            $.ajaxSettings.async = false;
            let beginDate = $("#beginDate").val().trim();
            let endDate = $("#endDate").val().trim();
            let userTel = $("#userTel").val().trim();
            $.post("UserServlet?m=getUserList", {
                "beginDate": beginDate,
                "endDate": endDate,
                "userTel": userTel
            }, function (data) {

                if (data == "Y") {
                    layer.msg("查询成功")
                }
                // window.location.reload();
            })
            // location.href = "UserServlet?m=getUserList";
            // window.location.reload();
        }

        function update(id, type) {
            let msg;

            if (type == 'N') {
                msg = "停用"

            } else {
                msg = "启用"

            }
            layer.confirm('确定要' + msg + '吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                $.ajaxSettings.async = false;
                console.log(status)
                $.post("UserServlet?m=updateUser", {"userId": id, "userStatus": type}, function (data) {
                    if (data == 'Y') {
                        layer.msg(msg + '成功');
                    } else {
                        layer.msg(msg + '失败');
                    }

                    setTimeout(function () {
                        window.location.reload();
                    }, 1000)
                })


            });
        }

        console.log($("#ul_footer").find("li a").addClass("active"))
        $("a").click(function () {
            console.log(this)
            $(this).addClass("active");

        })

    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div class="fl">用户管理</div>
            <div class="fr">
                <form action="UserServlet?m=getUserList" method="post">
                    <input id="beginDate" name="beginDate" type="date" placeholder="注册时间-始" style="width:100px;"
                           value="${param.beginDate}"/>-
                    <input type="date"
                           id="endDate"
                           name="endDate"
                           placeholder="注册时间-终"
                           value="${param.endDate}"
                           style="width:100px;"/>
                    <input type="text" id="userTel" name="userTel"
                           value="${param.userTel}"
                           placeholder="手机号码"/>
                    <%--                    onclick="query()"--%>
                    <button type="submit">查询</button>
                </form>
            </div>
        </div>

        <c:forEach items="${requestScope.userList}" var="u">
            <div class="mf-menu border-t">
                <div class="fl">
                    <h1>${varStatus}</h1>
                    <span class="m-wt1"></span>
                    <span>${u.userTel}</span>
                    <span>${u.userName}</span>
                    <span>${u.userSex == "F" ? "女" : "男"}</span>
                    <span>${u.addTime}</span>
                </div>
                <div class="fr">

                    <c:if test="${u.userStatus=='Y'}">
                        <button style="background: #dc0505;width: 100px;color: #FFF;"
                                onclick="resetPwd('${u.userId}')">密码重置
                        </button>
                        <button class="xiugai" onclick="update('${u.userId}','N')">停用</button>
                    </c:if>

                    <c:if test="${u.userStatus=='N'}">
                        <button style="background: #dc0505;width: 100px;color: #FFF;"
                                onclick="resetPwd('${u.userId}')">密码重置
                        </button>
                        <button class="xiajia" onclick="update('${u.userId}','Y')">启用</button>
                    </c:if>
                </div>
            </div>
        </c:forEach>


        <div class="mf-top" style="margin-top:30px">

            <ul class="pagination" style="margin-left:250px" id="ul_footer">


                <c:if test="${requestScope.pageNum > 1}">
                    <li>
                        <a
                                href="UserServlet?m=getUserList&pageNum=${requestScope.pageNum-1}&beginDate=${param.beginDate}&endDate=${param.endDate}&userTel=${param.userTel}">上一页</a>
                    </li>
                </c:if>
                <c:forEach begin="${requestScope.pageNum-3>=1?requestScope.pageNum-3:1}"
                           end="${requestScope.pages-requestScope.pageNum>=3?requestScope.pageNum+3:requestScope.pages}"
                           var="i" step="1">
                    <li>
                        <a href="UserServlet?m=getUserList&pageNum=${i}&beginDate=${param.beginDate}&endDate=${param.endDate}&userTel=${param.userTel}"
                           onclick=""
                           class="${requestScope.pageNum == i?"active":""}"
                           id="page${i}">
                                ${i}
                        </a>
                    </li>


                </c:forEach>
                <c:if test="${requestScope.pageNum < requestScope.pages }">

                    <li>
                        <a
                                href="UserServlet?m=getUserList&pageNum=${requestScope.pageNum+1}&beginDate=${param.beginDate}&endDate=${param.endDate}&userTel=${param.userTel}">下一页</a>
                    </li>
                    <li>
                        <a href="UserServlet?m=getUserList&pageNum=${requestScope.pages}&beginDate=${param.beginDate}&endDate=${param.endDate}&userTel=${param.userTel}">尾页</a>
                    </li>

                </c:if>


            </ul>
        </div>

    </div>
</div>
</body>
</html>
