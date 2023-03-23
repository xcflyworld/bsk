<%--
  Created by IntelliJ IDEA.
  User: scmie
  Date: 2023/3/17
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="./js/handlebars.js"></script>
<div class="m-shopping" id="cart">
    <div class="m-cart">
        <div id="close">
            <img src="images/common/close.png" class="m-img"/>
        </div>
        <span> 我的购物盒</span> <a href="#" onclick="clearCart()">清空购物盒</a>
    </div>
    <div id="containerCart" style="overflow-y: auto">
        <script type="text/x-handlebars-template" id="templateCart">
            {{#each this}}
            <div class="border-bot eat">
                <div class=" eat-left fl">
                    <img src="upload/{{productPic}}"/> <span>{{productName}}</span>
                    <br/> <span class="login-redcolor">{{productPrice}}元</span>
                </div>
                <div class="fr  eat-right">
                    <button class="cursor">
                        <img src="images/common/minus-red.png" onclick="saveCart({{productNum}}-1,{{cartId}})"/>
                    </button>
                    <input type="text" placeholder="{{productNum}}"/>
                    <button class="cursor">
                        <img src="images/common/plus-green.png" onclick="saveCart({{productNum}}+1,{{cartId}})"/>
                    </button>
                </div>
            </div>
            {{/each}}
        </script>
    </div>
    <div class="login-bgrcolor eat-bot" id="cart_show">
        <img src="images/menu/box.png" class="e-img"/> <span
            class="e-top login-redcolor" id="num"> </span><strong class="e-title1">总计<span
            class="e-bigfont" id="cart_image"> </span><span></span>
    </strong>
        <button class="e-btn fr cu"
                onclick="location.href='order_submit.jsp'">选好了 &gt;
        </button>
    </div>

</div>


<script>
    //获取需要放数据的容器
    let containerCart;
    //获取我们定义的模板的dom对象。主要是想获取里面的内容
    let templateCart;

    $(document).ready(function () {
        containerCart = $('#containerCart');
        templateCart = $('#templateCart');
        getCart();

    });


    //获取购物车数据
    function getCart() {
        $.ajaxSettings.async = false;
        $.get("CartServlet?m=getCart", function (data) {
            console.log(data);
            data = JSON.parse(data);
            let count = 0; //总金额
            let num = 0;  //餐品总数量

            for (let e of data) {
                count += e.productPrice * e.productNum;
                num += e.productNum;
            }
            ;

            count = Math.round(count * 100) / 100;

            $("#cart_image").html(count);
            $("#num").html(num);
            //编译模板的里的内容
            var template = Handlebars.compile(templateCart.html());
            //把后台获取到的数据渲染到页面
            containerCart.html(template(data));


        })
    }

    const saveCart = (productNum, cartId) => {
        // console.log('productNum:' + productNum + ",cartId:" + cartId)

        let type = 0;

        if (productNum == 0) {
            layer.confirm('不能再减了，确定要移出购物车吗？', {
                    btn: ['确定', '取消'] //按钮
                    , cancel: function () {
                        //关闭；
                        layer.closeAll();
                    },
                }, function () {
                    type = 1;
                    layer.closeAll();
                    updateCart(productNum, cartId, type);
                    // console.log(type + " 1111 ")
                    setTimeout(function () {
                        getCart();

                    }, 2000)
                }, function () {
                    type = 0;

                    // console.log(type + " 000 ")
                }
            )

        }else{
            updateCart(productNum, cartId, type);
        }


    }

    const updateCart = (productNum, cartId, type) => {
        $.ajaxSettings.async = false;
        $.post("CartServlet?m=updateCart", {
            "productNum": productNum,
            "cartId": cartId,
            "type": type,
        }, function (data) {
            if (data == "Y") {
                getCart();
            }
            if (data == "ds") {
                getCart();
            }
        })
    }
    const clearCart = () => {
        layer.confirm('确定要清空购物车吗？', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.post("CartServlet?m=updateCart", {
                "productNum": 0,
                "cartId": 0,
                "type": -1,
            }, function (data) {
                if (data == "cs") {
                    layer.msg('清空成功', {
                        icon: 6,
                        time: 1500
                    }, function () {
                        getCart();
                    });
                }
            })

        })

    }

</script>