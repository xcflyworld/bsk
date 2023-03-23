package com.bsk.dao;

import com.bsk.po.Address;

import java.util.List;

/**
 * @author scmie
 */
public interface AddressDao {

    /**
     * 获取所有地址
     *
     * @param address
     * @return
     */
    List<Address> getAddressList(Address address);


    /**
     *   根据属性获取对象
     * @param address
     * @return
     */
    Address getAddress(Address address);


    /**
     * 添加新地址
     *
     * @param address
     * @return
     */
    int addAddress(Address address);

    /**
     * 修改地址
     *
     * @param address
     * @return
     */
    int updateAddress(Address address);


    /**
     * 删除地址
     *
     * @param address
     * @return
     */
    int delAddress(Address address);


}
