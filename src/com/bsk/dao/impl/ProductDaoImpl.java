package com.bsk.dao.impl;

import com.bsk.dao.ProductDao;
import com.bsk.dto.ProductDto;
import com.bsk.po.Product;
import com.bsk.util.DataSourceUtil;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/**
 * @author scmie
 */
public class ProductDaoImpl implements ProductDao {

    private final JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<Product> getProductList(Product product, int pageNum, int pageSize, int type) {
        String sql = "select p.*,c.* from t_product p join t_category c on c.category_id = p.category_id  where 1=1";
        ArrayList<Object> objects = new ArrayList<>();
        if (product.getProductName() != null) {
            if (type == 0) {
                sql += " and p.product_name like ? ";
                objects.add("%" + product.getProductName() + "%");
            } else {
                sql += " and p.product_name=? ";
                objects.add(product.getProductName());
            }
        }
        if (product.getProductId() != null) {
            sql += " and p.product_id=? ";
            objects.add(product.getProductId());
        }
        if (product.getProductPrice() != null) {
            sql += " and p.product_price=? ";
            objects.add(product.getProductPrice());
        }
        if (product.getProductDescribe() != null) {
            sql += " and p.product_describe=? ";
            objects.add(product.getProductDescribe());
        }
        if (product.getProductPic() != null) {
            sql += " and p.product_pic=? ";
            objects.add(product.getProductPic());
        }
        if (product.getCategoryId() != null) {
            sql += " and p.category_id=? ";
            objects.add(product.getCategoryId());
        }
        if (product.getProductStatus() != null) {
            sql += " and p.product_status=? ";
            objects.add(product.getProductStatus());
        }


        //处理分页
        if (pageNum != 0 && pageSize != 0) {
            sql += " limit " + (pageNum - 1) * pageSize + "," + pageSize;
        }
//        System.out.println("getProductDtoList_sql="+sql);
//        System.out.println(Arrays.toString(objects.toArray()));
        List<Product> productList = jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(Product.class));

        return productList;

    }

    @Override
    public List<ProductDto> getProductDtoList(ProductDto product, int pageNum, int pageSize, int type) {
        String sql = "select p.*,c.* from t_product p join t_category c on c.category_id = p.category_id  where 1=1";
        ArrayList<Object> objects = new ArrayList<>();
        if (product.getProductName() != null) {
            if (type == 0) {
                sql += " and p.product_name like ? ";
                objects.add("%" + product.getProductName() + "%");
            } else {
                sql += " and p.product_name=? ";
                objects.add(product.getProductName());
            }
        }
        if (product.getProductId() != null) {
            sql += " and p.product_id=? ";
            objects.add(product.getProductId());
        }
        if (product.getProductPrice() != null) {
            sql += " and p.product_price=? ";
            objects.add(product.getProductPrice());
        }
        if (product.getProductDescribe() != null) {
            sql += " and p.product_describe=? ";
            objects.add(product.getProductDescribe());
        }
        if (product.getProductPic() != null) {
            sql += " and p.product_pic=? ";
            objects.add(product.getProductPic());
        }
        if (product.getCategoryId() != null) {
            sql += " and p.category_id=? ";
            objects.add(product.getCategoryId());
        }
        if (product.getProductStatus() != null) {
            sql += " and p.product_status=? ";
            objects.add(product.getProductStatus());
        }
        if(product.getCategoryName()!=null){
            sql += " and c.category_name=? ";
            objects.add(product.getCategoryName());
        }

        //处理分页
        if (pageNum != 0 && pageSize != 0) {
            sql += " limit " + (pageNum - 1) * pageSize + "," + pageSize;
        }
//        System.out.println("getProductDtoList_sql="+sql);
//        System.out.println(Arrays.toString(objects.toArray()));
        List<ProductDto> productList = jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(ProductDto.class));

        return productList;
    }

    @Override
    public int addProduct(Product product) {

        String sql = "insert into t_product(product_name,product_pic,product_price,product_describe,category_id)" +
                " values(?,?,?,?,?)";

        Object[] objects = {product.getProductName(), product.getProductPic(), product.getProductPrice(), product.getProductDescribe(),
                product.getCategoryId()};
        System.out.println("addProduct_sql="+sql);
        System.out.println(Arrays.toString(objects));
        return jdbcTemplate.update(sql, objects);
    }

    @Override
    public int updateProduct(Product product) {
        String sql = "update t_product set ";
        ArrayList<Object> objects = new ArrayList<>();
        if (product.getProductName() != null) {
            sql += " product_name=?,";
            objects.add(product.getProductName());
        }

        if (product.getProductPrice() != null) {
            sql += " product_price=?,";
            objects.add(product.getProductPrice());
        }
        if (product.getProductDescribe() != null) {
            sql += " product_describe=?,";
            objects.add(product.getProductDescribe());
        }
        if (product.getProductPic() != null) {
            sql += "  product_pic=?,";
            objects.add(product.getProductPic());
        }
        if (product.getCategoryId() != null) {
            sql += "  category_id=?,";
            objects.add(product.getCategoryId());
        }
        if (product.getProductStatus() != null) {
            sql += "  product_status=?,";
            objects.add(product.getProductStatus());
        }

        sql = sql.substring(0,sql.length()-1);
        sql+=" where product_id=?";
        objects.add(product.getProductId());
        System.out.println("updateProduct_sql="+sql);
        System.out.println(Arrays.toString(objects.toArray()));
        int update = 0;
        try {
            update = jdbcTemplate.update(sql, objects.toArray());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return update;
    }

    @Override
    public int deleteProduct(Product product) {
        String sql = "delete from t_product where product_id=" + product.getProductId();
        return jdbcTemplate.update(sql);
    }
}
