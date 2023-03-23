<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>分类管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css"/>
    <link rel="stylesheet" type="text/css" href="css/address.css"/>
    <script type="text/javascript" src="./js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript" src="./js/jquery.validate.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            //让当前表单调用validate方法，实现表单验证功能
            $(".add_validate").validate({
                debug: false, //调试模式，即使验证成功也不会跳转到目标页面
                rules: {     //配置验证规则，key就是被验证的dom对象，value就是调用验证的方法(也是json格式)
                    modify_categoryName: {
                        required: true,  //必填。如果验证方法不需要参数，则配置为true
                        rangelength: [1, 20],
                        maxlength: 20
                    },
                    add_categoryName: {
                        required: true,  //必填。如果验证方法不需要参数，则配置为true
                        rangelength: [1, 20],
                        maxlength: 20
                    }

                }
                ,
                messages: {
                    modify_categoryName: {
                        required: "请输入分类名称",
                        rangelength: $.validator.format("分类名称长度必须在：{0}-{1}之间"),
                        maxlength: $.validator.format("分类名称最大长度为为：{0}个字符"),
                    },
                    add_categoryName: {
                        required: "请输入分类名称",
                        rangelength: $.validator.format("分类名称长度必须在：{0}-{1}之间"),
                        maxlength: $.validator.format("分类名称最大长度为为：{0}个字符"),
                    },

                }
            });

        });

        function del(id) {
            layer.confirm('确定要删除吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                $.post("CategoryServlet?m=delCategory", {
                    "categoryId": id
                }, function (data) {

                    if (data == "Y") {
                        layer.msg('分类删除成功');
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000)
                    } else {
                        layer.msg("该分类下存在其他餐品，无法删除！")
                    }
                })
                // layer.msg('删除成功');
            });
        }


        const save = (id) => {
            let categoryName = $("#add_categoryName"+id).val().trim();

            $.ajaxSettings.async = false;
            if (categoryName.length > 0 && categoryName.length <= 20) {
                $.post("CategoryServlet?m=addCategory", {
                    "categoryName": categoryName
                }, function (data) {


                    if (data == "af") {
                        layer.msg("分类已重复，无法添加")
                    } else if (data == "Y") {

                        layer.msg("分类添加成功")
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000)

                    } else {
                        layer.msg("分类添加失败")
                    }

                })
            }else {
                if (categoryName.length == 0) {
                    layer.msg("分类名称不能·为空")
                } else {
                    layer.msg("分类名称必须长度在1-20个字符之间")
                }
            }


            $.ajaxSettings.async = true;
        }

        const modify = (id) => {
            let categoryName = $("#modify_categoryName"+id).val().trim();
            $.ajaxSettings.async = false;

            if (categoryName.length > 0 && categoryName.length <= 20) {
                $.post("CategoryServlet?m=updateCategory", {
                    "categoryName": categoryName,
                    "categoryId":id
                }, function (data) {


                    if (data == "uf") {
                        layer.msg("分类已重复，无法修改")
                    } else if (data == "Y") {
                        layer.msg("分类修改成功")

                        setTimeout(function () {
                            window.location.reload();
                        }, 1000)
                    } else {
                        layer.msg("分类修改失败")
                    }

                })
            }else {
                if (categoryName.length == 0) {
                    layer.msg("分类名称不能为空")
                } else {
                    layer.msg("分类名称必须长度在1-20个字符之间")
                }
            }

            $.ajaxSettings.async = true;
        }

    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div>
                分类管理
            </div>
        </div>
        <c:forEach items="${requestScope.categoryList}" var="c">
            <div class="mf-menu border-t"
                 style="height: auto; line-height: normal; padding: 30px 0">

                <div class="fl">
                    <span class="m-wt"></span>
                    <span>${c.categoryName}</span>
                </div>
                <div class="fr dingwei">
                    <button class="xiugai" onclick="change('category${c.categoryId}',1)">
                        修改
                    </button>
                    <button class="del" onclick="del('${c.categoryId}')">
                        删除
                    </button>
                </div>



                <div id="update_category${c.categoryId}" style="display: none;" class="change">
                    <div style="padding-top: 20px" class="clear">
                        <span class="m-wt" style="padding: 0 30px; width: 70px"></span>


                        <input type="text" class="t-ad" style="width: 150px"
<%--                               onfocus="if (value ==='${c.categoryName}'){value =''}"--%>
<%--                               onblur="if (value ===''){value='${c.categoryName}'}"--%>
                               id="modify_categoryName${c.categoryId}"
                               placeholder="${c.categoryName}"/>

                    </div>

                    <div class="act-botton clear"
                         style="margin: 10px 0 10px 15px; padding: 10px 0">
                        <div class="save-button">
                            <a href="javascript:modify('${c.categoryId}')" class="radius">保存</a>
                        </div>
                        <div class="cancel-button">
                            <a href="javascript:" class="radius"
                               onclick="change('category${c.categoryId}',2)">取消</a>
                        </div>
                    </div>
                </div>


            </div>
        </c:forEach>
        <%--        <div class="mf-menu border-t"--%>
        <%--             style="height: auto; line-height: normal; padding: 30px 0">--%>

        <%--            <div class="fl">--%>
        <%--                <span class="m-wt"></span>--%>
        <%--                <span>意面</span>--%>
        <%--            </div>--%>
        <%--            <div class="fr  dingwei">--%>
        <%--                <button class="xiugai" onclick="change('category2',1)">--%>
        <%--                    修改--%>
        <%--                </button>--%>
        <%--                <button class="del" onclick="del(2)">--%>
        <%--                    删除--%>
        <%--                </button>--%>
        <%--            </div>--%>

        <%--            <div id="update_category2" style="display: none;" class="change">--%>
        <%--                <div style="padding-top: 20px" class="clear">--%>
        <%--                    <span class="m-wt" style="padding: 0 30px; width: 70px"></span>--%>
        <%--                    <input type="text" class="t-ad" style="width: 150px"--%>
        <%--                           value="请输入分类名称"/>--%>
        <%--                </div>--%>

        <%--                <div class="act-botton clear"--%>
        <%--                     style="margin: 10px 0 10px 15px; padding: 10px 0">--%>
        <%--                    <div class="save-button">--%>
        <%--                        <a href="javascript:" class="radius">保存</a>--%>
        <%--                    </div>--%>
        <%--                    <div class="cancel-button">--%>
        <%--                        <a href="javascript:" class="radius"--%>
        <%--                           onclick="change('category2',2)">取消</a>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <div class="mf-top" style="margin-top: 30px">
            <div id="addcategory">
                <div style="line-height: 40px">
                    <span class="m-wt" style="padding: 0 20px"></span><a href="#"
                                                                         class=" rb-red"
                                                                         onclick="change('addcategory',3)">+添加新分类</a>
                </div>
            </div>
            <div id="insert_addcategory" style="display: none;" class="change">
                <div style="padding-top: 20px" class="clear">
                    <span class="m-wt" style="padding: 0 30px; width: 70px"></span>

                    <input type="text" class="t-ad" style="width: 150px"
                           id="add_categoryName${c.categoryId}"
                           onfocus="if (value ==='请输入分类名称'){value =''}"
                           onblur="if (value ===''){value='请输入分类名称'}"
                           placeholder="请输入分类名称"/>

                </div>

                <div class="act-botton clear"
                     style="margin: 10px 0 10px 15px; padding: 10px 0">
                    <div class="save-button">
                        <a href="javascript:save('${c.categoryId}')" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('addcategory',4)">取消</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
