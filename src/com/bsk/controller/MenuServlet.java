package com.bsk.controller;

import com.bsk.dto.ProductDto;
import com.bsk.po.Category;
import com.bsk.po.Product;
import com.bsk.service.CategoryService;
import com.bsk.service.ProductService;
import com.bsk.service.impl.CategoryServiceImpl;
import com.bsk.service.impl.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/MenuServlet")
public class MenuServlet extends BaseServlet {


    private CategoryService categoryService = new CategoryServiceImpl();
    private ProductService productService = new ProductServiceImpl();

    public void menuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Product product = new Product();
        //获取上架的所有物品
        product.setProductStatus("Y");

        //获取分类列表
        Integer categoryId = request.getParameter("categoryId")!= null && !request.getParameter("categoryId").equals("")?Integer.parseInt(request.getParameter("categoryId")):null;
        System.out.println("categoryId="+categoryId);
        if(categoryId!=null){
            product.setCategoryId(categoryId);
        }
        List<Product> productList = productService.getProductList(product, 0, 0, 0);
        List<Category> categoryList = categoryService.getCategoryList(new Category());
        //存储
        request.setAttribute("categoryId",product.getCategoryId());
        request.setAttribute("productList",productList);
        request.setAttribute("categoryList",categoryList);
        request.getRequestDispatcher("menu.jsp").forward(request,response);
    }


}
