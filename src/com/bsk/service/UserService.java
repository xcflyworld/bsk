package com.bsk.service;

import com.bsk.po.User;

import java.util.List;


/**
 * @author scmie
 */
public interface UserService {


    /**
     * 用户登录
     * @param user
     * @return
     */
    User login(User user);

    /**
     * 用户注册
     * @param user
     * @return
     */
    int register(User user);

    /**
     * 修改
     * @param user
     * @return
     */
    int modifyUser(User user);

    /**
     * 获取所有用户
     * @param user
     * @return
     */
    List<User> getUserList(User user,int pageNum,int pageSize,int type);
    List<User> getUserList(User user,String beginDate,String endDate,int pageNum,int pageSize,int type);
}
