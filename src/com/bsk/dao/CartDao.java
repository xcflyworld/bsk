package com.bsk.dao;

import com.bsk.dto.CartDto;
import com.bsk.po.Cart;

import java.util.List;

/**
 * @author scmie
 */
public interface CartDao {

    /**
     * 加入购物车
     * @param cart
     * @return
     */
    int addCart(Cart cart);

    /**
     * 更新购物车
     * @param cart
     * @return
     */
    int updateCart(Cart cart);

    /**
     * 更新购物车，包括清空，移出，普通添加等
     * @param cart
     * @param type
     * @return
     */
    int modifyCart(Cart cart,String type);

    /**
     * 获取购物车
     * @param cart
     * @return
     */
    Cart getCart(Cart cart);

    /**
     * 获取购物车列表
     * @param cart
     * @return
     */
    List<CartDto> getCartList(Cart cart);

    int delCart(Cart cart);
}
