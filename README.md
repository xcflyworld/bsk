### 必胜客在线点餐系统

必胜客作为一家全球知名的连锁快餐品牌，也需要适应这一趋势，为顾客提供更加便捷和高效的点餐方式，提高顾客的购物体验和满意度。

### 项目基础架构

![image-20230323171628822](https://raw.githubusercontent.com/xcflyworld/cdn/master/2023/03%E5%9B%BE%E7%89%871.jpg)
#### 技术选型

1.Java EE：JSP和Servlet是Java EE的核心技术之一，用于开发Web应用程序。

2.三层架构+mvc：MVC是一种常用的Web应用程序设计模式，用于实现模型、视图和控制器的分离，降低应用程序的耦合度。

3.Tomcat服务器：Tomcat是一个开源的Web应用服务器，用于运行和部署Java Web应用程序。

4.MySQL数据库：MySQL是一种开源的关系型数据库管理系统，它可以用于存储和管理必胜客外卖点餐系统中的各种数据。

5.HTML、CSS和JavaScript：用于实现系统的前端页面和交互效果。

6.AJAX：用于实现无刷新页面的异步数据传输，提高系统的响应速度和用户体验。

7.JSTL：JavaServer Pages标准标签库，用于简化JSP页面中的代

8.使用Hutool Java工具包类库，生成图形验证码

9.Handlebars是一种流行的JavaScript模板引擎，它可以帮助开发人员更方便地生成HTML代码或其他文本格式。Handlebars使用简单的标记语言来定义模板，通过在模板中插入变量和表达式来动态生成输出。

#### 登录注册页面
![](https://raw.githubusercontent.com/xcflyworld/cdn/master/2023/0320230323185109.png)
登录注册实现了密码加密，注册实现了注册成功即自动登录，如果出现错误，会给出信息提示，电话号码不能重复注册


#### 餐品显示功能
![](https://raw.githubusercontent.com/xcflyworld/cdn/master/2023/0320230323190153.png)
可以按照分类展示餐品信息
