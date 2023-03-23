<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/9
  Time: 19:10
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
    <title>餐品管理</title>

    <style>

        .select_input {
            width: 163px;
            height: 28px;
            margin-right: 16px;
            border: 1px solid;
        }
    </style>
    <script src="js/jquery-3.6.3.min.js"></script>
    <script src="js/jquery.validate.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">


        const upload = (id, type) => {

            if ($("#photoFile" + id).val() == '') {
                return;
            }
            let formData = new FormData();
            console.log($('#photoFile' + id));

            formData.append('photoFile' + id, $('#photoFile' + id)[0].files[0]);

            console.log($('#photoFile' + id)[0].files[0]);
            $.ajax({
                url: "ProductServlet?m=upload",
                type: "post",
                data: formData,
                contentType: false,
                processData: false,
                success: function (data) {
                    // alert(data);
                    if (type == 0) {
                        $("#add_productPic" + id).val(data);
                    } else if (type == 1) {
                        $("#modify_productPic" + id).val(data);
                    }

                }
            });
        }

        function del(id) {
            layer.confirm('确定要删除吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {

                $.ajaxSettings.async = false;
                console.log(status)
                $.post("ProductServlet?m=delProduct", {"productId": id}, function (data) {
                    if (data == 'Y') {
                        layer.msg('删除成功');
                    } else {
                        layer.msg('删除失败');
                    }

                    setTimeout(function () {
                        window.location.reload();
                    }, 1000)
                })


                // layer.msg('删除成功');
            });
        }

        function update(id, type) {
            var msg;
            if (type == 'N') {
                msg = "下架"
            } else {
                msg = "上架"
            }
            layer.confirm('确定要' + msg + '吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {

                $.ajaxSettings.async = false;
                console.log(status)
                $.post("ProductServlet?m=updateProduct", {"productId": id, "productStatus": type}, function (data) {
                    if (data == 'Y') {
                        layer.msg(msg + '成功');
                    } else {
                        layer.msg(msg + '失败');
                    }

                    setTimeout(function () {
                        window.location.reload();
                    }, 1000)
                })

                // layer.msg(msg + '成功');
            });
        }


    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food" style="overflow-y: auto"> <!--style="overflow-y: auto" -->
        <div class="mf-top border-t" s>
            <div class="fl">
                餐品管理
            </div>
            <div class="fr">
                <%--                <input type="text">--%>
                <%--                    --%>
                <%--                </input>--%>

                <form action="ProductServlet?m=productList" method="post">
                    <select class="select_input" id="categoryId" name="categoryId">
                        <option value="">请选择</option>
                        <c:forEach items="${requestScope.categoryList}" var="category">
                            <option ${param.categoryId == category.categoryId ?"selected":""}
                                    value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>


                    <input type="text" id="productName" value="${param.productName}" name="productName"
                           placeholder="请输入餐品名称..."/>
                    <button type="submit">
                        搜索
                    </button>
                </form>
            </div>
        </div>
        <c:forEach items="${requestScope.productList}" var="p">

            <div class="mf-menu"
                 style="height: auto; line-height:normal; padding: 30px 0">


                <div class="fl">


                    <img src="upload/${p.productPic}"
                         width="100" align="center"/>
                        <%--                    <img src="images/banner/Banner_18_2017_08_28_14_25_56.jpg"--%>
                        <%--                         width="100" align="center"/>--%>
                    <span>${p.productName}</span>
                    <span>${p.productPrice}</span>
                    <span>${p.productDescribe}</span>
                    <span>${p.categoryName}</span>
                </div>
                <div class="fr weizhi">
                    <button class="${p.productStatus == "Y"?"xiajia":"shangjia"}"
                        <%--                            onclick="update('${p.productId}','Y')">--%>
                            onclick="update('${p.productId}','${p.productStatus == "Y"? 'N':'Y'}')">
                            ${p.productStatus == "Y"?"下架":"上架"}
                    </button>
                    <button class="xiugai" onclick="change('product${p.productId}',1)">
                        修改
                    </button>
                    <button class="del" onclick="del('${p.productId}')">
                        删除
                    </button>
                </div>

                <div id="update_product${p.productId}" style="display: none;" class="change">
                    <div class="myform">
                        <div class="new-food clear">
                            <div>
                                <input placeholder="选择图片" type="file" id="photoFile${p.productId}"
                                       onchange="upload('${p.productId}','1')"/>
                                <!--存图片名称-->
                                <input placeholder="选择图片" type="hidden" id="modify_productPic${p.productId}"
                                       name="add_productPic"/>

                                <button class="xiugai nw-btn" style="padding: 10px">
                                    上传图片
                                </button>
                                <input placeholder="餐品名" id="modify_productName${p.productId}" name="add_productName"
                                       type="text"/>
                                <input placeholder="单价" id="modify_productPrice${p.productId}" name="add_productPrice"
                                       type="text"/>
                            </div>
                            <div>
                                <input placeholder="描述" id="modify_productDescribe${p.productId}"
                                       name="add_productDescribe" type="text" style="width: 390px"/>
                                <select name="add_categoryId" id="modify_categoryId${p.productId}" style="height: 28px">
                                    <option value="">请选择</option>
                                    <c:forEach items="${categoryList}" var="category">
                                        <option   ${p.categoryId == category.categoryId?"selected":""}
                                                value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <input type="submit" onclick="modifyProduct('${p.productId}')"
                                       class="nw-btn xiugai m-submit"
                                       style="border: none; height: 40px"/>
                                <input type="reset" value="取消" onclick="change('product${p.productId}',2)"
                                       class="del" style="height: 40px; border-radius: 5px"/>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </c:forEach>
        <div class="mf-top clear">
            <div class="fl" style="line-height: 40px; margin-top:40px">
                <a href="#" class=" rb-red" onclick="change('addproduct',3)">+添加新餐品</a>
            </div>
            <div id="insert_addproduct" style="display: none;" class="change">
                <div class="myform" method="post">
                    <fieldset>
                        <div class="new-food clear">
                            <div>
                                <input placeholder="选择图片" type="file" id="photoFile${p.productId}"
                                       onchange="upload('${p.productId}','0')"/>
                                <!--存图片名称-->
                                <input placeholder="选择图片" type="hidden" id="add_productPic${p.productId}"
                                       name="add_productPic"/>
                                <button class="xiugai nw-btn" style="padding: 10px">
                                    上传图片
                                </button>
                                <input placeholder="餐品名" type="text" name="add_productName"
                                       id="add_productName${p.productId}"/>
                                <input placeholder="单价" type="text" name="add_productPrice"
                                       id="add_productPrice${p.productId}"/>
                            </div>
                            <div>
                                <input placeholder="描述" type="text" name="add_productDescribe"
                                       id="add_productDescribe${p.productId}"
                                       style="width: 390px"/>
                                <select name="add_categoryId" id="add_categoryId${p.productId}" style="height: 28px">
                                    <option value="">请选择</option>
                                    <c:forEach items="${categoryList}" var="ca">
                                        <option ${p.categoryId == ca.categoryId?"selected":""}
                                                value="${ca.categoryId}">${ca.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <input onclick="addProduct('${p.productId}')" type="submit"
                                       class="nw-btn xiugai m-submit"
                                       style="border: none; height: 40px"/>
                                <input type="reset" value="取消" onclick="change('addproduct',4)"
                                       class="del" style="height: 40px; border-radius: 5px"/>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

        </div>


    </div>

</div>

<div class="m-food" style="padding: 9px 100px;">
    <!--
    <ul class="pagination fr" style="margin-right: 50px; margin-top:40px"> -->
    <ul class="pagination fr" style="margin-right: 201px;margin-top: 80px;">

        <c:if test="${requestScope.pageNum > 1}">
            <li>
                <a
                        href="ProductServlet?m=productList&pageNum=${requestScope.pageNum-1}&productName=${param.productName}&categoryId=${param.categoryId}">上一页</a>
            </li>
        </c:if>
        <c:forEach begin="${requestScope.pageNum-3>=1?requestScope.pageNum-3:1}"
                   end="${requestScope.pages-requestScope.pageNum>=3?requestScope.pageNum+3:requestScope.pages}"
                   var="i" step="1">
            <li>
                <a href="ProductServlet?m=productList&pageNum=${i}&productName=${param.productName}&categoryId=${param.categoryId}"
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
                        href="ProductServlet?m=productList&pageNum=${requestScope.pageNum+1}&productName=${param.productName}&categoryId=${param.categoryId}">下一页</a>
            </li>
            <li>
                <a href="ProductServlet?m=productList&pageNum=${requestScope.pages}&productName=${param.productName}&categoryId=${param.categoryId}">尾页</a>
            </li>

        </c:if>
    </ul>
</div>

<script>


    const modifyProduct = (id) => {
        let productPic = $("#modify_productPic" + id).val().trim();
        let productName = $("#modify_productName" + id).val().trim();
        let productPrice = $("#modify_productPrice" + id).val().trim();
        let productDescribe = $("#modify_productDescribe" + id).val().trim();
        let categoryId = $("#modify_categoryId" + id).val().trim();
        // let productId = $("#modify_productId"+id).val().trim();
        //让当前表单调用validate方法，实现表单验证功能
        console.log(productPic + " " + productName + " " + productPrice + " " + productDescribe + " " + categoryId)

        if (productPic != "") {
            if (productName.length >= 2 && productName.length <= 20) {
                if (/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/.test(productPrice)) {
                    if (productDescribe.length >= 2 && productDescribe.length <= 20) {
                        if (categoryId != "") {
                            $.post("ProductServlet?m=modifyProduct", {
                                "productPic": productPic,
                                "productName": productName,
                                "productPrice": productPrice,
                                "productDescribe": productDescribe,
                                "categoryId": categoryId,
                                "productId": id
                            }, function (data) {

                                if (data == "Y") {
                                    layer.msg("修改餐品成功！")
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 1000)

                                } else if (data == "uf") {
                                    layer.msg("餐品已存在")
                                } else {
                                    layer.msg("修改餐品失败！")
                                }

                            })
                        } else {
                            layer.msg("请选择餐品分类");
                        }
                    } else {
                        layer.msg("请入2~20个字符的描述");
                    }
                } else {
                    layer.msg("请入有效的单价");
                }
            } else {
                layer.msg("请输入有效的名称");
            }
        } else {
            layer.msg("请选择餐品图片");
        }



    }
    const addProduct = (id) => {
        let productPic = $("#add_productPic" + id).val().trim();
        let productName = $("#add_productName" + id).val().trim();
        let productPrice = $("#add_productPrice" + id).val().trim();
        let productDescribe = $("#add_productDescribe" + id).val().trim();
        let categoryId = $("#add_categoryId" + id).val().trim();
        //让当前表单调用validate方法，实现表单验证功能
        console.log(productPic + " " + productName + " " + productPrice + " " + productDescribe + " " + categoryId)

        if (productPic != "") {
            if (productName.length >= 2 && productName.length <= 20) {
                if (/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/.test(productPrice)) {
                    if (productDescribe.length >= 2 && productDescribe.length <= 20) {
                        if (categoryId != "") {
                            $.post("ProductServlet?m=addProduct", {
                                "productPic": productPic,
                                "productName": productName,
                                "productPrice": productPrice,
                                "productDescribe": productDescribe,
                                "categoryId": categoryId
                            }, function (data) {
                                if (data == "Y") {
                                    layer.msg("添加餐品成功！")
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 2000)

                                } else if (data == "af") {

                                    layer.msg("添加餐品已存在")

                                } else {
                                    layer.msg("添加餐品失败！")
                                }
                            })
                        } else {
                            layer.msg("请选择餐品分类");
                        }
                    } else {
                        layer.msg("请入2~20个字符的描述");
                    }
                } else {
                    layer.msg("请入有效的单价");
                }
            } else {
                layer.msg("请输入有效的名称");
            }
        } else {
            layer.msg("请选择餐品图片");
        }



    }
</script>
</body>
</html>
