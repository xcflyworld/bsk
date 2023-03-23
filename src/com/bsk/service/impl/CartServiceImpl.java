package com.bsk.service.impl;

import com.bsk.dao.CartDao;
import com.bsk.dao.impl.CartDaoImpl;
import com.bsk.dto.CartDto;
import com.bsk.po.Cart;
import com.bsk.service.CartService;

import java.util.List;

/**
 * @author scmie
 */
public class CartServiceImpl implements CartService {

    private CartDao cartDao = new CartDaoImpl();

    @Override
    public int addCart(Cart cart) {
        Cart c = cartDao.getCart(cart);
        if (c == null) {
            //没买过，添加一条数据
            return  cartDao.addCart(cart);
        }else{
            //买过，更新数量
           return  cartDao.updateCart(cart);
        }

    }

    @Override
    public List<CartDto> getCarts(Cart cart) {
        return cartDao.getCartList(cart);
    }

    @Override
    public int modifyCart(Cart cart,String type) {
        return cartDao.modifyCart(cart,type);
    }

    @Override
    public int delCart(Cart cart) {
        return cartDao.delCart(cart);
    }
}
