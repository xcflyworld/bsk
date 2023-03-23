package com.bsk.controller;

import com.bsk.dto.CartDto;
import com.bsk.po.Cart;
import com.bsk.po.Product;
import com.bsk.po.User;
import com.bsk.service.CartService;
import com.bsk.service.impl.CartServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author scmie
 */
@WebServlet("/CartServlet")
public class CartServlet extends BaseServlet {
    private CartService cartService = new CartServiceImpl();


    /**
     * 更新购物车
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void updateCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Cart cart = new Cart();
        //参数封装到对象中
        BeanUtils.populate(cart, parameterMap);
        //type表示状态 0：正常加减  1:移出购物车  -1:清空购物车
        String type = request.getParameter("type");
        if (cart.getProductNum() >= 1) {
            //更新
            int i = cartService.modifyCart(cart, type);
            response.getWriter().print(i > 0 ? "Y" : "N");
        } else if (cart.getProductNum() == 0 && type.equals("1")) {
            //删除
            int delete = cartService.modifyCart(cart, type);
            response.getWriter().print(delete > 0 ? "ds" : "df");
        } else if (type.equals("-1")) {
            //清空购物车
            //获取当前登录用户
            User user = (User) request.getSession().getAttribute("user");
            cart.setUserId(user.getUserId());
            int clear = cartService.modifyCart(cart, type);
            response.getWriter().print(clear > 0 ? "cs" : "cf");

        }


    }

    /**
     * 展示购物车
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void getCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //获取当前登录用户
        User user = (User) request.getSession().getAttribute("user");
        //获取当前购物车列表
        Cart cart = new Cart();
        cart.setUserId(user.getUserId());
        List<CartDto> carts = cartService.getCarts(cart);

//        System.out.println(carts.size());
        //以json格式输出
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(response.getWriter(), carts);


    }

    public void addCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Cart cart = new Cart();
        //参数封装到对象中
        BeanUtils.populate(cart, parameterMap);

        int i = cartService.addCart(cart);
        if (i == 1) {
            response.getWriter().print("Y");
        } else {
            response.getWriter().print("N");
        }
    }


}
