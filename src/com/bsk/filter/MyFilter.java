package com.bsk.filter;

import com.bsk.controller.UserServlet;
import com.bsk.po.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest re = (HttpServletRequest) req;
        HttpServletResponse res = (HttpServletResponse) resp;
        re.setCharacterEncoding("utf-8");
        res.setContentType("text/html;charset=UTF-8");
        User user = (User) re.getSession().getAttribute("user");
        if (user != null) {
            chain.doFilter(req, resp);
        } else {
            StringBuffer requestURL = re.getRequestURL();
            if (requestURL.indexOf("login.jsp") != -1 || requestURL.indexOf("register.jsp") != -1 || requestURL.indexOf("main.jsp") != -1 || requestURL.indexOf("top.jsp") != -1) {
                chain.doFilter(req, resp);
            } else {
                re.getRequestDispatcher("main.jsp").forward(re, res);
            }
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
