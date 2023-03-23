package com.bsk.controller;

import com.bsk.po.Address;
import com.bsk.po.Category;
import com.bsk.po.User;
import com.bsk.service.CategoryService;
import com.bsk.service.impl.CategoryServiceImpl;
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
@WebServlet("/CategoryServlet")
public class CategoryServlet extends BaseServlet {

    private CategoryService categoryService = new CategoryServiceImpl();


    /**
     * 展示所有分类
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void categoryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Category category = new Category();
        List<Category> categoryList = categoryService.getCategoryList(category);
        //存储分类集合
        request.setAttribute("categoryList", categoryList);
        System.out.println(categoryList.get(0).toString());
        //请求转发
        request.getRequestDispatcher("category.jsp").forward(request, response);


    }


    /**
     * 添加
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void addCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Category category = new Category();
        //参数封装到对象中
        BeanUtils.populate(category, parameterMap);

        Category c2 = new Category();
        c2.setCategoryName(category.getCategoryName());
        List<Category> categoryList = categoryService.getCategoryList(c2);
        if (categoryList.size() == 0) {
            //调用服务层进行验证
            int i = categoryService.addCategory(category);
            if (i > 0) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }
        } else {
            response.getWriter().print("af");
        }
    }


    /**
     * 修改
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void updateCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Category category = new Category();
        //参数封装到对象中
        BeanUtils.populate(category, parameterMap);


        Category c2 = new Category();
        c2.setCategoryName(category.getCategoryName());
        List<Category> categoryList = categoryService.getCategoryList(c2);

        if (categoryList.size() == 0) {
            //调用服务层进行验证
            int i = categoryService.updateCategory(category);
            if (i > 0) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }
        } else {
            response.getWriter().print("uf");
        }
    }

    /**
     * 删除
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void delCategory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Category category = new Category();
        //参数封装到对象中
        BeanUtils.populate(category, parameterMap);
        System.out.println(category.toString());

            int i = categoryService.delCategory(category);
            if (i > 0) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }

    }

}
