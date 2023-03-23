package com.bsk.test;

import com.bsk.dao.UserDao;
import com.bsk.dao.impl.UserDaoImpl;
import com.bsk.po.User;
import org.junit.Test;

import javax.swing.text.DateFormatter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;

/**
 * @author scmie
 */
public class UserDaoTest {


    private UserDao userDao = new UserDaoImpl();


    @Test
    public void testGetUserList() {

        List<User> userList = userDao.getUserList(new User(),0,0,0);

        for (User user : userList) {
            System.out.println(user.toString());

        }
    }

    @Test
    public void testGetUser() {

        User user = new User();
        user.setUserTel("13100000000");
        user.setUserPwd("1234567");
        User daoUser = userDao.getUser(user);
        System.out.println(daoUser.toString());
    }

    @Test
    public void testAddUser() {
        User user = new User();
        user.setUserName("admin");
        user.setUserPwd("123");
        user.setUserTel("15256669875");
        user.setUserSex("W");
        int i = userDao.addUser(user);
        System.out.println(i);
    }
    @Test
    public void testLocalDate(){
        User user = new User();
        DateFormatter format = new DateFormatter();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String now = LocalDate.now().toString()+" "+ LocalTime.now().toString().substring(0,8);

        user.setAddTime(now);
        System.out.println(user.toString());
    }

    public void testItrator() {
        HashSet<Integer> integers = new HashSet<>();
        integers.add(1);
        integers.add(2);
        integers.add(3);
//        for (int i =0 ;i<integers.size();i++) {
//
//        }

    }
}
