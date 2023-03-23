<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2023/3/10
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>地址管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/menu.css"/>
    <link rel="stylesheet" type="text/css" href="css/address.css"/>

    <style>
        select, input:valid {
            border: 2px solid green;
        }
    </style>
    <script type="text/javascript" src="./js/jquery-3.6.3.min.js"></script>
    <script src="js/area/distpicker.data.js"></script>
    <script src="js/area/distpicker.js"></script>
    <script src="js/area/main.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        // $("#distpicker").distpicker();


        const addAddress = (id, userId) => {
            let addressProvince = $("#add_addressProvince" + id).val().trim();
            let addressCity = $("#add_addressCity" + id).val().trim();
            let addressDistrict = $("#add_addressDistrict" + id).val().trim();
            let addressDescribe = $("#add_addressDescribe" + id).val().trim();
            $.ajaxSettings.async = false;
            console.log(addressProvince + " " + addressCity + " " + addressDistrict + " " + addressDescribe)
            if(addressDescribe.length > 0 && addressDescribe.length<=50){
                $.post("AddressServlet?m=addAddress",
                    {
                        "addressProvince": addressProvince,
                        "addressCity": addressCity,
                        "addressDistrict": addressDistrict,
                        "addressDescribe": addressDescribe,
                        "userId": userId,
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
            }else {
                if(addressDescribe.length ==0){
                    layer.msg("地址不能为空");
                }else{
                    layer.msg("地址长度在1-50个字符之间");
                }

            }


            $.ajaxSettings.async = true;

        }

        /**
         * 删除地址
         * @param id
         */
        function del(id) {
            layer.confirm('确定要删除吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                $.ajaxSettings.async = false;
                $.post("AddressServlet?m=delAddress",
                    {
                        "addressId": id
                    }, function (data) {
                        if (data == "Y") {
                            layer.msg("删除成功");
                            setTimeout(function () {
                                window.location.reload();
                            }, 1000)
                        } else {
                            layer.msg("删除失败");
                        }
                    })
                $.ajaxSettings.async = true;
                layer.msg('删除成功');
            });
        }

        function save(id, userId, addressId) {
            let addressProvince = $("#addressProvince" + id).val().trim();
            let addressCity = $("#addressCity" + id).val().trim();
            let addressDistrict = $("#addressDistrict" + id).val().trim();
            let addressDescribe = $("#addressDescribe" + id).val().trim();

            $.ajaxSettings.async = false;
            console.log(addressProvince + " " + addressCity + " " + addressDistrict + " " + addressDescribe)
            if(addressDescribe.length > 0 && addressDescribe.length<=50){
                $.post("AddressServlet?m=updateAddress",
                    {
                        "addressProvince": (addressProvince == "" ? $("#addressProvince" + id).attr('placeholder') : addressProvince),
                        "addressCity": (addressCity == "" ? $("#addressCity" + id).attr('placeholder').trim() : addressCity),
                        "addressDistrict": (addressDistrict == "" ? $("#addressDistrict" + id).attr('placeholder') : addressDistrict),
                        "addressDescribe": (addressDescribe == "" ? $("#addressDescribe" + id).attr('placeholder'): addressDescribe),
                        "userId": userId,
                        "addressId": addressId
                    }
                    , function (data) {
                        // alert(data)
                        if (data == "Y") {
                            layer.msg("修改地址成功");
                            setTimeout(function () {
                                window.location.reload();
                            }, 1000)
                        } else if(data == "uf"){
                            layer.msg("地址重复，修改失败");
                        }else{
                            layer.msg("修改地址失败")
                        }
                    })

            }else {
                if(addressDescribe.length ==0){
                    layer.msg("地址不能为空");
                }else{
                    layer.msg("地址长度在1-50个字符之间");
                }

            }



            $.ajaxSettings.async = true;

            // alert(addressProvince);

        }

    </script>

</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div>
                地址管理
            </div>
        </div>
        <c:forEach items="${addressList}" var="a">
            <div class="mf-menu border-t"
                 style="height: auto; line-height:7px; padding: 30px 0">

                <div class="fl">
                    <span class="m-wt"></span>
                    <span>${a.addressProvince}-${a.addressCity}-${a.addressDistrict}-${a.addressDescribe}</span>
                </div>
                <div class="fr">
                    <button class="xiugai dingwei" onclick="change('address${a.addressId}',1)">
                        修改
                    </button>
                    <button class="del dingwei" onclick="del('${a.addressId}')">
                        删除
                    </button>
                </div>

                <div style="display: none;" class="change" id="update_address${a.addressId}">
                    <div style="padding-top: 20px" class="clear" data-toggle="distpicker">
                        <span class="m-wt" style="padding: 0 30px; width: 70px;"></span>

                        <select id="addressProvince${a.addressId}"
                                style="width: 110px;height: 32px">

                        </select>
                        —
                            <%--                    type="text" class="t-ad"   placeholder="${a.addressCity}" --%>
                        <select id="addressCity${a.addressId}"
                                style="width: 110px;height: 32px;">

                        </select>
                        —
                        <select id="addressDistrict${a.addressId}" style="width: 110px;height: 32px;">

                        </select>
                        —

                        <input id="addressDescribe${a.addressId}" style="width: 110px;height: 27px;"
<%--                               onfocus="if (placeholder ==='描述'){placeholder =''}"--%>
<%--                               onblur="if (placeholder ===''){placeholder='描述'}"--%>
                               placeholder="${a.addressDescribe}"/>
                    </div>

                    <div class="act-botton clear"
                         style="margin: 10px 0 10px 15px; padding: 10px 0">
                        <div class="save-button">
                            <a href="javascript:save('${a.addressId}','${sessionScope.user.userId}','${a.addressId}')"
                               class="radius">保存</a>
                        </div>
                        <div class="cancel-button">
                            <a href="javascript:" class="radius"
                               onclick="change('address${a.addressId}',2)">取消</a>
                        </div>
                    </div>
                </div>
            </div>

        </c:forEach>
    </div>
    <div class="mf-top" style="margin-top: 30px">
        <div id="addaddress">
            <div style="line-height: 40px">
                <span class="m-wt" style="padding: 0 30px"></span><a href="#"
                                                                     class=" rb-red" onclick="change('addaddress',3)">+使用新地址</a>
            </div>
        </div>
        <div style="display: none;" id="insert_addaddress" class="change">

            <span class="m-wt" style="padding: 0 30px; width: 70px"></span>
            <div style="margin-top: 20px" class="add_validate" data-toggle="distpicker">
                <span class="m-wt" style="padding: 0 30px"></span>


                <select name="" id="add_addressProvince${a.addressId}" style="width: 110px;height: 32px"></select>
                —
                <select name="" id="add_addressCity${a.addressId}" style="width: 110px;height: 32px"></select>
                —
                <select name="" id="add_addressDistrict${a.addressId}" style="width: 110px;height: 32px"></select>
                —
                <input
                        id="add_addressDescribe${a.addressId}" type="text"
                        class="t-ad" style="width: 110px;height: 27px"
<%--                        onfocus="if (placeholder ==='描述'){placeholder =''}"--%>
<%--                        onblur="if (placeholder ===''){placeholder='描述'}"--%>
                        placeholder ="描述"/>
            </div>

            <div class="act-botton clear"
                 style="margin: 20px 40px; padding: 20px 0">
                <div class="save-button">
                    <a href="javascript:" onclick="addAddress('${a.addressId}','${sessionScope.user.userId}')"
                       class="radius">保存</a>
                </div>
                <div class="cancel-button">
                    <a href="javascript:" class="radius"
                       onclick="change('addaddress',4)">取消</a>
                </div>
            </div>
        </div>
        <div class="area clear"
             style="margin-top: 60px; font-size: 14px; color: #999">
            <span class="m-wt" style="padding: 0 30px"></span> 友情提示：
            <br/>
            <span class="m-wt" style="padding: 0 30px"></span>如果您选择不设置密码，您送餐信息的主要内容会以*号遮蔽，如：虹桥路2号，会显示为“虹﹡……﹡2号”。
            <br/>
            <span class="m-wt" style="padding: 0 30px"></span>该显示信息可能不受保护，建议您设置密码。
        </div>
    </div>
</div>
</body>
</html>