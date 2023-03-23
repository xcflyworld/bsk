package com.bsk.controller;

import com.bsk.po.Address;
import com.bsk.po.User;
import com.bsk.service.AddressDaoService;
import com.bsk.service.UserService;
import com.bsk.service.impl.AddressDaoServiceImpl;
import com.bsk.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author scmie
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends BaseServlet {

    private AddressDaoService addressDaoService = new AddressDaoServiceImpl();

    /**
     * 添加新地址
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void addAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Address address = new Address();
        //参数封装到对象中

        BeanUtils.populate(address, parameterMap);

        Address a2 = new Address();
        a2.setAddressProvince(address.getAddressProvince());
        a2.setAddressCity(address.getAddressCity());
        a2.setAddressDistrict(address.getAddressDistrict());
        a2.setAddressDescribe(address.getAddressDescribe());
        a2.setUserId(address.getUserId());

        if (addressDaoService.getAddressList(a2).size() != 0) {
            //地址重复
            response.getWriter().print("af");
        } else {
            //调用服务层进行验证
            int i = addressDaoService.addAddress(address);
            if (i > 0) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }
        }


    }

    /**
     * 删除地址
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void delAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Address address = new Address();
        //参数封装到对象中
        BeanUtils.populate(address, parameterMap);
        //调用服务层进行验证
        int i = addressDaoService.delAddress(address);
        if (i > 0) {
            response.getWriter().print("Y");
        } else {
            response.getWriter().print("N");
        }
    }

    /**
     * 修改地址信息
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void updateAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取所有的参数键值对
        Map<String, String[]> parameterMap = request.getParameterMap();
        //构建封装对象
        Address address = new Address();
        //参数封装到对象中
        BeanUtils.populate(address, parameterMap);
        //调用服务层进行验证
        Address a2 = new Address();
        a2.setAddressProvince(address.getAddressProvince());
        a2.setAddressCity(address.getAddressCity());
        a2.setAddressDistrict(address.getAddressDistrict());
        a2.setAddressDescribe(address.getAddressDescribe());
        a2.setUserId(address.getUserId());
        if (addressDaoService.getAddressList(a2).size() !=0  ) {

            response.getWriter().print("uf");
        } else {
            int i = addressDaoService.updateAddress(address);
            if (i > 0) {
                response.getWriter().print("Y");
            } else {
                response.getWriter().print("N");
            }
        }

    }

    /**
     * 获取所有地址信息
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public void addressList(HttpServletRequest request, HttpServletResponse response) throws Exception {

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
        request.getRequestDispatcher("address.jsp").forward(request, response);


    }


}
