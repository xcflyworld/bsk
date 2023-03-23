package com.bsk.dao.impl;

import com.bsk.dao.AddressDao;
import com.bsk.po.Address;
import com.bsk.util.DataSourceUtil;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author scmie
 */
public class AddressDaoImpl implements AddressDao {
    private final JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<Address> getAddressList(Address address) {

        String sql = "select * from t_address where 1=1";
        List<Address> addressList = new ArrayList<>();
        List<Object> objects = new ArrayList<>();

        if (address.getAddressId() != null) {
            sql += " and address_id=?";
            objects.add(address.getAddressId());
        }
        if (address.getAddressProvince() != null) {
            sql += " and address_province=?";
            objects.add(address.getAddressProvince());
        }
        if (address.getAddressCity() != null) {
            sql += " and address_city=?";
            objects.add(address.getAddressCity());
        }

        if (address.getAddressDistrict() != null) {
            sql += " and address_district=?";
            objects.add(address.getAddressDistrict());
        }
        if (address.getAddressDescribe() != null) {
            sql += " and address_describe=?";
            objects.add(address.getAddressDescribe());
        }

        if (address.getUserId() != null) {
            sql += " and user_id=?";
            objects.add(address.getUserId());
        }

        try {
            addressList = jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(Address.class));
        } catch (DataAccessException e) {


        }

        System.out.println("getAddressList_sql = " + sql);
        System.out.println(Arrays.toString(objects.toArray()));
        return addressList;
    }

    @Override
    public Address getAddress(Address address) {
        String sql = "select * from t_address where 1=1";
        ArrayList<Object> objects = new ArrayList<>();
        Address a = null;
        if (address.getAddressId() != null) {
            sql += " and address_id=?";
            objects.add(address.getAddressId());
        }
        if (address.getAddressProvince() != null) {
            sql += " and address_province=?";
            objects.add(address.getAddressProvince());
        }
        if (address.getAddressCity() != null) {
            sql += " and address_city=?";
            objects.add(address.getAddressCity());
        }

        if (address.getAddressDistrict() != null) {
            sql += " and address_district=?";
            objects.add(address.getAddressDistrict());
        }
        if (address.getAddressDescribe() != null) {
            sql += " and address_describe=?";
            objects.add(address.getAddressDescribe());
        }

        if (address.getUserId() != null) {
            sql += " and user_id=?";
            objects.add(address.getUserId());
        }

        try {
            a = jdbcTemplate.queryForObject(sql, objects.toArray(), new BeanPropertyRowMapper<>(Address.class));
        } catch (DataAccessException e) {

        }

        return a;
    }

    @Override
    public int addAddress(Address address) {
        String sql = "insert into t_address(address_province,address_city,address_district,address_describe,user_id) values(?,?,?,?,?)";
        Object[] objects = {address.getAddressProvince(), address.getAddressCity(), address.getAddressDistrict(),
                address.getAddressDescribe(), address.getUserId()};
        System.out.println("addAddress_sql="+sql);
        System.out.println(Arrays.toString(objects));
        return jdbcTemplate.update(sql, objects);

    }

    @Override
    public int updateAddress(Address address) {
        String sql = "update t_address  set ";
        ArrayList<Object> objects = new ArrayList<Object>();

        if (address.getAddressProvince() != null) {
            sql += "address_province=?,";
            objects.add(address.getAddressProvince());
        }
        if (address.getAddressCity() != null) {
            sql += "address_city=?,";
            objects.add(address.getAddressCity());
        }

        if (address.getAddressDistrict() != null) {
            sql += "address_district=?,";
            objects.add(address.getAddressDistrict());
        }
        if (address.getAddressDescribe() != null) {
            sql += "address_describe=?,";
            objects.add(address.getAddressDescribe());
        }

        if (address.getUserId() != null) {
            sql += "user_id=?,";
            objects.add(address.getUserId());
        }

        sql = sql.substring(0, sql.length() - 1) + " where address_id=?";

        System.out.println("updateAddress_sql = " + sql);
        objects.add(address.getAddressId());

        System.out.println(Arrays.toString(objects.toArray()));
        return jdbcTemplate.update(sql, objects.toArray());
    }

    @Override
    public int delAddress(Address address) {
        String sql = "delete from t_address where address_id=" + address.getAddressId();
        return jdbcTemplate.update(sql);
    }
}
