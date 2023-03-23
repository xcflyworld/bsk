package com.bsk.service.impl;

import com.bsk.dao.AddressDao;
import com.bsk.dao.UserDao;
import com.bsk.dao.impl.AddressDaoImpl;
import com.bsk.po.Address;
import com.bsk.service.AddressDaoService;

import java.util.List;

/**
 * @author scmie
 */
public class AddressDaoServiceImpl  implements AddressDaoService {

    private AddressDao addressDao = new AddressDaoImpl();
    @Override
    public int addAddress(Address address) {
        return addressDao.addAddress(address);
    }

    @Override
    public int updateAddress(Address address) {
        return addressDao.updateAddress(address);
    }

    @Override
    public int delAddress(Address address) {
        return addressDao.delAddress(address);
    }

    @Override
    public List<Address> getAddressList(Address address) {
        return addressDao.getAddressList(address);
    }
}
