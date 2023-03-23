package com.bsk.dao.impl;

import com.bsk.dao.UserDao;
import com.bsk.po.Address;
import com.bsk.po.User;
import com.bsk.util.DataSourceUtil;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author scmie
 */
public class UserDaoImpl implements UserDao {

    private final JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    public List<User> getUserList(User user, String beginDate, String endDate, int pageNum, int pageSize, int type) {
        String sql = "select * from t_user where 1=1 and user_role!='A'";
        ArrayList<Object> objects = new ArrayList<>();
        List<User> userList = new ArrayList<>();

        if (user.getUserTel() != null && !user.getUserTel().equals("")) {
            if (type == 0) {
                sql += " and user_tel like ?";
                objects.add("%" + user.getUserTel() + "%");
            } else {
                sql += " and user_tel= ?";
                objects.add(user.getUserTel());
            }
        }

        if ((beginDate != null && !beginDate.equals("")) ) {
            sql += " and add_time >= ?";
            objects.add(beginDate+" 0:0:0");
        }
        if (endDate != null && !endDate.equals("")) {
            sql += " and add_time <= ?";
            objects.add(endDate+" 23:59:59");
        }

        //处理分页
        if (pageNum != 0 && pageSize != 0) {
            sql += " limit " + (pageNum - 1) * pageSize + "," + pageSize;
        }
//        System.out.println("getUserList_sql2=" + sql);
//        System.out.println("object=" + Arrays.toString(objects.toArray()));
        userList = jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(User.class));
//        System.out.println("dao_userlist="+Arrays.toString(userList.toArray()));
        return userList;

    }

    public List<User> getUserList(User user, int pageNum, int pageSize, int type) {
        String sql = "select * from t_user where 1=1";
        ArrayList<Object> objects = new ArrayList<>();
        List<User> userList = new ArrayList<>();
        if (user.getUserId() != null) {
            sql += " and user_id=?";
            objects.add(user.getUserId());
        }
        if (user.getUserTel() != null) {
            if (type == 0) {
                sql += " and user_tel like?";
                objects.add("%" + user.getUserTel() + "%");
            } else {
                sql += " and user_tel=?";
                objects.add(user.getUserTel());
            }
        }
        if (user.getUserPwd() != null) {
            sql += " and user_pwd=?";
            objects.add(user.getUserPwd());
        }
        if (user.getUserName() != null) {
            sql += " and user_name=?";
            objects.add(user.getUserName());
        }
        if (user.getUserSex() != null) {
            sql += " and user_sex=?";
            objects.add(user.getUserSex());
        }
        if (user.getAddTime() != null) {
            if (type == 0) {
                sql += " and add_time beetween ? and ?";
                objects.add(user.getAddTime());
            } else {
                sql += " and add_time=?";
                objects.add(user.getAddTime());
            }

        }
        if (user.getUserStatus() != null) {
            sql += " and user_status=?";
            objects.add(user.getUserStatus());
        }
        if (user.getUserRole() != null) {
            sql += " and user_role=?";
            objects.add(user.getUserRole());
        }
        //处理分页
        if (pageNum != 0 && pageSize != 0) {
            sql += " limit " + (pageNum - 1) * pageSize + "," + pageSize;
        }
        userList = jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(User.class));
        return userList;
    }
//    @Override
//    public List<User> getUserList() {
//
//        return jdbcTemplate.query("select * from t_user", new BeanPropertyRowMapper<User>(User.class));
//    }

    @Override
    public User getUser(User user) {
        String sql = "select * from t_user where 1=1";

        ArrayList<Object> objects = new ArrayList<>();
        if (user.getUserTel() != null) {
            sql += " and user_tel=?";
            objects.add(user.getUserTel());
        }
        if (user.getUserPwd() != null) {
            sql += " and user_pwd=?";
            objects.add(user.getUserPwd());
        }

        if (user.getUserId() != null) {
            sql += " and user_id=?";
            objects.add(user.getUserId());
        }
        User queryUser = null;

        try {
            queryUser = jdbcTemplate.queryForObject(sql, objects.toArray(), new BeanPropertyRowMapper<>(User.class));
        } catch (Exception e) {
//            e.printStackTrace();
        }
        return queryUser;
    }

    @Override
    public int addUser(User user) {
        String sql = "insert into t_user(user_tel,user_pwd,user_name,user_sex,add_time) values (?, ?, ?,?,?)";

        Object[] objects = {user.getUserTel(), user.getUserPwd(), user.getUserName(), user.getUserSex(), user.getAddTime()};

        return jdbcTemplate.update(sql, objects);

    }

    @Override
    public int updateUser(User user) {
        String sql = "update t_user set ";
        ArrayList<Object> objects = new ArrayList<>();
        if (user.getUserName() != null) {
            sql += "  user_name=?,";
            objects.add(user.getUserName());
        }
        if (user.getUserTel() != null) {
            sql += " user_tel=?,";
            objects.add(user.getUserTel());
        }
        if (user.getUserPwd() != null) {
            sql += " user_pwd=?,";
            objects.add(user.getUserPwd());
        }
        if (user.getUserSex() != null) {
            sql += " user_sex=?,";
            objects.add(user.getUserSex());
        }
        if (user.getAddTime() != null) {
            sql += " add_time=?,";
            objects.add(user.getAddTime());
        }
        if (user.getUserStatus() != null && !user.getUserStatus().equals("")) {
            sql += " user_status=?,";
            objects.add(user.getUserStatus());
        }
        if (user.getUserRole() != null) {
            sql += " user_role=?,";
            objects.add(user.getUserRole());
        }
        sql = sql.substring(0, sql.length() - 1);
        sql += " where user_id=? ";
        objects.add(user.getUserId());
//        System.out.println(sql);
        return jdbcTemplate.update(sql, objects.toArray());
    }


}
