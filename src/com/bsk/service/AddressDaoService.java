package com.bsk.service;

import com.bsk.po.Address;

import java.util.List;

/**
 * @author scmie
 */
public interface AddressDaoService {


    /**
     * 添加新地址
     *
     * @param address
     * @return
     */
    int addAddress(Address address);

    /**
     * 修改地址
     * @param address
     * @return
     */
    int updateAddress(Address address);

    /**
     * 删除地址
     * @param address
     * @return
     */
    int delAddress(Address address);

    /**
     * 获取该用户的所有地址
     * @param address 地址信息中国包含User_id
     * @return
     */
    List<Address> getAddressList(Address address);


}
