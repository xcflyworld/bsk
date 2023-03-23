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
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" href="css/css.css" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <link rel="stylesheet" type="text/css" href="css/menu.css" />
  <title>订单管理</title>
  <script type="text/javascript"
          src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  <script src="layer/layer.js" type="text/javascript"></script>
  <script src="js/main.js" type="text/javascript"></script>
  <script type="text/javascript">


  </script>
</head>
<body>
<div class="m-main">
  <div class="m-food">
    <div class="mf-top border-t">
      <div class="fl">
        订单管理
      </div>
      <div class="fr">
        <input type="text" placeholder="下单时间" style="width: 100px;" />
        -
        <input type="text" placeholder="下单时间" style="width: 100px;" />
        -
        <input type="text" placeholder="订单状态" style="width: 100px;" />
        <!--<button style="height: 29px; position: relative; top: -1px">
            <img src="images/detail/show-more.png" />
        </button>-->
        <select class="select">
          <option></option>
        </select>
        -
        <input type="text" placeholder="订单号" />
        <button>
          查询
        </button>
      </div>
    </div>
    <div class="mf-menu border-t"
         style="height: auto; line-height: normal; padding: 30px 0">
      <div class="fl">
        <span class="m-wt1" style="width: 10px"></span>
        <span>1</span>
        <span>张三</span>
        <span>2018-01-25 00:24:35</span>
        <span>2018-01-25 00:24:35</span>
      </div>
      <div class="fr weiyi">
        <input type="text" placeholder="已下单"
               style="width: 70px; height: 22px; padding-left: 10px" />
        <select class="select">
          <option></option>
        </select>
        <button class="xiugai" style="padding: 10px"
                onclick="change('order1',1)">
          详情
        </button>
      </div>
      <div id="update_order1" style="display: none;" class="change">
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">群英荟萃</span>
          <span class="sp sp-2">1</span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class="clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">经典意式酱面</span>
          <span class="sp sp-2">1</span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">总额</span>
          <span class="sp sp-2"></span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-4">送餐地址</span>
          <span>天宁区文化宫</span>
        </div>
      </div>
    </div>

    <div class="mf-menu border-t"
         style="height: auto; line-height: normal; padding: 30px 0">
      <div class="fl">
        <span class="m-wt1" style="width: 10px"></span>
        <span>2</span>
        <span>李四</span>
        <span>2018-01-25 00:24:35</span>
        <span>2018-01-25 00:24:35</span>
      </div>
      <div class="fr weiyi">
        <input type="text" placeholder="已下单"
               style="width: 70px; height: 22px; padding-left: 10px" />
        <select class="select">
          <option></option>
        </select>
        <button class="xiugai" style="padding: 10px"
                onclick="change('order2',1)">
          详情
        </button>
      </div>
      <div id="update_order2" style="display: none;" class="change">
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">群英荟萃</span>
          <span class="sp sp-2">1</span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class="clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">经典意式酱面</span>
          <span class="sp sp-2">1</span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-1">总额</span>
          <span class="sp sp-2"></span>
          <span class="sp sp-3">176.00</span>
        </div>
        <div class=" clear" style="padding: 20px 0">
          <span class="m-wt1" style="width: 28px"></span>
          <span></span>
          <span class="sp sp-4">送餐地址</span>
          <span>天宁区文化宫</span>
        </div>
      </div>
    </div>




  </div>
</div>
</body>
</html>
