package com.bsk.controller;

import com.bsk.po.Address;
import com.bsk.po.User;
import com.bsk.service.AddressDaoService;
import com.bsk.service.impl.AddressDaoServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends BaseServlet {
    private AddressDaoService addressDaoService = new AddressDaoServiceImpl();
    public void submitOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("submitOrder...");




    }
    public void selectAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("selectAddress...");


        //获取当前登录用户
        User user = (User) request.getSession().getAttribute("user");

        //根据userId获取地址
        Address address = new Address();
        address.setUserId(user.getUserId());
        //模拟数据
        List<Address> addressList = addressDaoService.getAddressList(address);
        //存储地址集合
        request.setAttribute("addressList", addressList);
        //请求转发
        //以json格式输出
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(response.getWriter(), addressList);




    }


}
