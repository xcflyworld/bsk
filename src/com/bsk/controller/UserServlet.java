package com.bsk.controller;

import com.bsk.po.Category;
import com.bsk.po.User;
import com.bsk.service.UserService;
import com.bsk.service.impl.UserServiceImpl;
import com.bsk.util.Base64Util;
import com.bsk.util.CodeImgUtil;
import org.apache.commons.beanutils.BeanUtils;


import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.print.Book;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

/**
 * @author scmie
 */
@WebServlet("/UserServlet")
public class UserServlet extends BaseServlet {


    private UserService userService = new UserServiceImpl();


    /**
     * 修改用户密码
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void updatePwd(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        String code = request.getParameter("code");
        String oldPwd = request.getParameter("oldPwd");
        String sessionCode = (String) request.getSession().getAttribute("code");
        String sessionPwd = ((User) request.getSession().getAttribute("user")).getUserPwd();
        //先判断验证码
        if (code.toLowerCase().equals(sessionCode.toLowerCase())) {
            //再判断原密码
            //解密
            byte[] bytes = Base64Util.decryptBASE64(sessionPwd);
            String decodePwd = new String(bytes);
            if (oldPwd.equals(decodePwd)) {
                //构建封装对象
                User u = new User();
                //参数封装到对象中
                BeanUtils.populate(u, parameterMap);
                u.setUserPwd(Base64Util.encryptBASE64(u.getUserPwd().getBytes()));
                //调用服务层进行验证
                int modifyUser = userService.modifyUser(u);
                if (modifyUser > 0) {
                    response.getWriter().print("Y");
                    //清理session
                    request.getSession().removeAttribute("user");

                } else {
                    response.getWriter().print("N");
                }

            } else {
                //密码错误
                response.getWriter().print("pf");
            }
        } else {
            //验证码错误
            response.getWriter().print("cf");
        }


    }

    /**
     * 随机验证码
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void codeImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        String code = CodeImgUtil.drawImage(output);
        System.out.println(code);
        // 将验证码文本直接存放到session中
        request.getSession().setAttribute("code", code);
        try {
            ServletOutputStream out = response.getOutputStream();
            output.writeTo(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 修改用户信息（姓名，电话）
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void updateUser(HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("userStatus=" + request.getParameter("userStatus"));
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        User u = new User();
        //参数封装到对象中
        BeanUtils.populate(u, parameterMap);
//        u.setUserPwd(Base64Util.encryptBASE64(u.getUserPwd().getBytes()));
        //调用服务层进行验证
        int modifyUser = userService.modifyUser(u);
        if (modifyUser > 0) {
            //修改成功
            response.getWriter().print("Y");
            //如果是修改简单信息
            User currentUser = userService.login(u);
            request.getSession().setAttribute("user", currentUser);

        } else {
            //修改失败
            response.getWriter().print("N");
        }


    }


    public void getUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = new User();
        Map<String, String[]> parameterMap = request.getParameterMap();
        BeanUtils.populate(user, parameterMap);
        String beginDate = request.getParameter("beginDate");
        String endDate = request.getParameter("endDate");
        String userTel = request.getParameter("userTel");
        //每页的数据  pageSize
        int pageSize = 3;
        //页码号  pageNum
        int pageNum = 1;
        if (request.getParameter("pageNum") != null) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
        //总数据量
        int total = userService.getUserList(user, beginDate, endDate, 0, 0, 0).size();

        //总页数 total % pageSize == 0?total / pageSize: tot/pageSize+1
        int pages = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;

        //页码修正
        if (pageNum < 1) {
            pageNum = 1;
        }
        if (pageNum > pages) {
            pageNum = pages;
        }


        //遍历param参数何和value
/*        Set<Map.Entry<String, String[]>> entries = parameterMap.entrySet();
        for (Map.Entry<String, String[]> entry : entries) {
            System.out.println(entry.getKey()+":"+ Arrays.toString(entry.getValue()));
        }*/


//        System.out.println("beginDate="+beginDate+",endDate="+endDate+",userTel="+userTel);

        List<User> userList = userService.getUserList(user, beginDate, endDate, pageNum, pageSize, 0);


        //删除管理员
        Iterator<User> iterator = userList.iterator();
        while (iterator.hasNext()) {
            User next = iterator.next();
            if (next.getUserRole().equals("A")) {
                iterator.remove();
                ;
            }
        }

        if (userList.size() != 0) {
            response.getWriter().print("Y");
        }

        //存储当前页和总页码数
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("pages", pages);
        //存储分类集合
        request.setAttribute("userList", userList);
        //请求转发
        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }

    /**
     * 登录
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        User u = new User();
        //参数封装到对象中
        BeanUtils.populate(u, parameterMap);
        //加密后与数据库比对
        u.setUserPwd(Base64Util.encryptBASE64(u.getUserPwd().getBytes()));
        //调用服务层进行验证
        User user = userService.login(u);


        //判断
        if (user != null) {
            if (user.getUserStatus().equals("Y")) {
                //保存登录用户信息
                request.getSession().setAttribute("user", user);
                //给信号
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }
        }


    }

    /**
     * 注册
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void register(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        User u = new User();
        String now = LocalDate.now().toString() + " " + LocalTime.now().toString().substring(0, 8);
        u.setAddTime(now);
        //参数封装到对象中
        BeanUtils.populate(u, parameterMap);
        u.setUserPwd(Base64Util.encryptBASE64(u.getUserPwd().getBytes()));
        System.out.println(u.toString());
        User user = new User();
        user.setUserTel(u.getUserTel());
        //验证注册是否去重
        int size = userService.getUserList(user, 0, 0, 0).size();
        if (size == 0) {
            //调用服务层进行验证
            int register = userService.register(u);
            if (register > 0) {
                User sessionUser = userService.login(user);
                request.getSession().setAttribute("user", sessionUser);
                //注册成功
                response.getWriter().print("Y");
            }

        } else {
            response.getWriter().print("N");
        }

    }

    /**
     * 退出登录
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("user");
        response.sendRedirect("main.jsp");
    }


}
