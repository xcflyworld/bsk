package com.bsk.service.impl;

import com.bsk.dao.UserDao;
import com.bsk.dao.impl.UserDaoImpl;
import com.bsk.po.User;
import com.bsk.service.UserService;

import java.util.List;

/**
 * @author scmie
 */
public class UserServiceImpl implements UserService {

    private UserDao userDao = new UserDaoImpl();

    @Override
    public User login(User user) {
        return userDao.getUser(user);
    }

    @Override
    public int register(User user) {

        if (userDao.getUser(user) != null) {
            return -1;
        }
        return userDao.addUser(user);
    }

    @Override
    public int modifyUser(User user) {
        return userDao.updateUser(user);
    }

    @Override
    public List<User> getUserList(User user, int pageNum, int pageSize, int type) {
        return userDao.getUserList(user, pageNum, pageSize, type);
    }

    @Override
    public List<User> getUserList(User user, String beginDate, String endDate, int pageNum, int pageSize, int type) {
        return userDao.getUserList(user, beginDate, endDate, pageNum, pageSize, type);
    }
}
