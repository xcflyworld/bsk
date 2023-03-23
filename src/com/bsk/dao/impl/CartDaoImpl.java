package com.bsk.dao.impl;

import com.bsk.dao.CartDao;
import com.bsk.dto.CartDto;
import com.bsk.po.Cart;
import com.bsk.util.DataSourceUtil;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * @author scmie
 */
public class CartDaoImpl implements CartDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public int addCart(Cart cart) {

        String sql = "insert into t_cart (product_id,product_num,user_id) values(?,?,?)";
        Object[] objects = {cart.getProductId(), cart.getProductNum(), cart.getUserId()};
        return jdbcTemplate.update(sql, objects);
    }

    @Override
    public int updateCart(Cart cart) {

        String sql = "update t_cart set product_num= product_num + ? where product_id =? and user_id =?";
        Object[] objects = {cart.getProductNum(), cart.getProductId(), cart.getUserId()};
        return jdbcTemplate.update(sql, objects);
    }

    @Override
    public int modifyCart(Cart cart,String type) {
      List<Object> objects =   new ArrayList<>();
//        Object[] objects = {cart.getProductNum(),cart.getCartId()};
        String sql="";
        if(type.equals("0")){
            //正常添加餐品数量
            objects.clear();
            objects.add(cart.getProductNum());
            objects.add(cart.getCartId());
            sql = "update t_cart set product_num= ? where cart_id =? ";

        }else if(type.equals("1")){
            //删除该餐品
            objects.clear();
            objects.add(cart.getCartId());
            sql = "delete from  t_cart  where cart_id = ? ";

        }else if(type.equals("-1")){
            //清空购物车
            objects.clear();
            objects.add(cart.getUserId());
            sql = "delete from  t_cart  where user_id = ? ";
        }

        return jdbcTemplate.update(sql, objects.toArray());
    }


    @Override
    public Cart getCart(Cart cart) {
        String sql = "select * from  t_cart  where product_id =? and user_id =?";
        Object[] objects = {cart.getProductId(), cart.getUserId()};
        try {
            return jdbcTemplate.queryForObject(sql, objects, new BeanPropertyRowMapper<>(Cart.class));
        } catch (DataAccessException e) {
            return null;
        }
    }

    @Override
    public List<CartDto> getCartList(Cart cart) {
        String sql = "select p.product_name,p.product_pic,p.product_price,c.cart_id,c.product_id,c.product_num from " +
                "t_cart c join t_product p on c.product_id = p.product_id and c.user_id = ?";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CartDto.class), cart.getUserId());
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int delCart(Cart cart) {

        String sql = "delete from  t_cart  where cart_id = ? ";
        return jdbcTemplate.update(sql,cart.getCartId());
    }
}
