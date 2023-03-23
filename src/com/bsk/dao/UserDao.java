package com.bsk.dao;

import com.bsk.po.User;

import java.util.List;

/**
 * @author scmie
 */
public interface UserDao {

    /**
     * 获取所有用户信息
     * @param user
     * @param pageNum 当前页数
     * @param pageSize 每页数量
     * @param type 0:模糊查询 1:精确查询
     * @return
     */
    List<User> getUserList(User user,int pageNum,int pageSize,int type);

    List<User> getUserList(User user,String beginDate,String endDate,int pageNum,int pageSize,int type);


    /**
     * 根据属性获取对象
     * @param user
     * @return
     */
    User getUser(User user);

    /**
     * 添加用户
     * @param user
     * @return
     */
    int addUser(User user);



    /**
     * 修改用户信息
     * @param user
     * @return
     */
    int updateUser(User user);
}
