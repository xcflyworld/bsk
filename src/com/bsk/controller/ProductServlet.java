package com.bsk.controller;

import com.bsk.dto.ProductDto;
import com.bsk.po.Category;
import com.bsk.po.Product;
import com.bsk.po.ProductCategory;
import com.bsk.po.User;
import com.bsk.service.CategoryService;
import com.bsk.service.ProductService;
import com.bsk.service.impl.CategoryServiceImpl;
import com.bsk.service.impl.ProductServiceImpl;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * @author scmie
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends BaseServlet {
    ProductService productService = new ProductServiceImpl();


    /**
     * 删除
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void delProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Product product = new Product();
        //参数封装到对象中
        BeanUtils.populate(product, parameterMap);
        int i = productService.deleteProduct(product);
        if (i > 0) {
            //修改成功
            response.getWriter().print("Y");

        } else {
            //修改失败
            response.getWriter().print("N");

        }
    }

    /**
     * 更新
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        System.out.println("userStatus="+request.getParameter("userStatus"));
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Product product = new Product();
        //参数封装到对象中
        BeanUtils.populate(product, parameterMap);
        //调用服务层进行验证
        int modifyUser = productService.updateProduct(product);
        if (modifyUser > 0) {
            //修改成功
            response.getWriter().print("Y");

        } else {
            //修改失败
            response.getWriter().print("N");
        }

    }

    /**
     * 获取餐品列表
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void productList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        CategoryService categoryService = new CategoryServiceImpl();
        ProductDto product = new ProductDto();
        //分类名称集合
        List<Category> categoryList = categoryService.getCategoryList(new Category());
        //搜索条件
        String productName = request.getParameter("productName") != null && !"".equals(request.getParameter("productName")) ? request.getParameter("productName") : null;
        Integer categoryId = request.getParameter("categoryId") != null && !"".equals(request.getParameter("categoryId")) ? Integer.parseInt(request.getParameter("categoryId")) : null;

        //每页的数据  pageSize
        int pageSize = 2;
        //页码号  pageNum
        int pageNum = 1;
        if (request.getParameter("pageNum") != null) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }
        //总数据量
        int total = productService.getProductDtoList(new ProductDto(productName, categoryId), 0, 0, 0).size();
        //总页数 total % pageSize == 0?total / pageSize: tot/pageSize+1
        int pages = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
        //页码修正
        if (pageNum < 1) {
            pageNum = 1;
        }
        if (pageNum > pages) {
            pageNum = pages;
        }


        List<ProductDto> productList = productService.getProductDtoList(new ProductDto(productName, categoryId), pageNum, pageSize, 0);

        for (ProductDto productDto : productList) {
//            System.out.println(productDto.toString());

        }
        //存储当前页和总页码数
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("pages", pages);
        //存储集合
        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);

        //请求转发
        request.getRequestDispatcher("product.jsp").forward(request, response);

    }

    /**
     * 添加餐品
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Product product = new Product();
        //参数封装到对象中
        BeanUtils.populate(product, parameterMap);


        int size = productService.getProductList(new Product(product.getProductName()), 0, 0, 0).size();
        if (size == 0) {
            int i = productService.addProduct(product);
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
    public void modifyProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {


        //获取所有的参数键值对

        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Product product = new Product();
        //参数封装到对象中
        BeanUtils.populate(product, parameterMap);
        System.out.println(product);
        List<Product> query = productService.getProductList(new Product(product.getProductName()), 0, 0, 1);
        int size = query.size();
//        System.out.println(6);
//        System.out.println("size=" + size);
        if(query.size() == 1 && query.get(0).getProductName().equals(product.getProductName())|| query.size()  > 1){
            if(query.get(0).getProductId().equals(product.getProductId())){

                int i = productService.updateProduct(product);
                System.out.println(i);
                if (i > 0 ) {
                    response.getWriter().print("Y");
                } else {
                    response.getWriter().print("N");
                }
            }else{
                //重复
                response.getWriter().print("uf");
            }

        }else {

            int i = productService.updateProduct(product);
            System.out.println(i);
            if (i > 0 ) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }


        }



    }

    /**
     * 上传图片
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 创建一个DiskFileItemfactory工厂类
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 创建一个ServletFileUpload核心对象
        ServletFileUpload sfu = new ServletFileUpload(factory);
        // 解决上传文件名中文乱码
        sfu.setHeaderEncoding("utf-8");

        String filename = "";
        // 解析request对象
        try {
            FileItem fileItem = sfu.parseRequest(request).get(0);
            filename = uploadFile(fileItem);
            response.getWriter().print(filename);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            response.getWriter().print("N");
        }

    }


    /**
     * 将上传文件表单项封装
     *
     * @param fileItem
     * @return
     */
    private String uploadFile(FileItem fileItem) {
        // 如果上传表单项
        // 得到文件输入流
        // 创建物理目录路径

        String realPath = this.getServletContext().getRealPath("/upload");
        // 根据该路径创建一个目录对象
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();// 创建一个指定的目录
        }
        // 得到上传的名子
        String filename = fileItem.getName();
        if (filename != null) {
            // 得到文件后缀
            String extend = filename.substring(filename.indexOf("."));
            System.out.println(extend);
            // 重写生成一个唯一的文件名
            filename = UUID.randomUUID() + extend;
        }
        // 上传文件,自动删除临时文件
        try {
            fileItem.write(new File(realPath, "/" + filename));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return filename;
    }
}
