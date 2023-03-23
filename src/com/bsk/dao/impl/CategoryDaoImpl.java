package com.bsk.dao.impl;

import com.bsk.dao.CategoryDao;
import com.bsk.po.Address;
import com.bsk.po.Category;
import com.bsk.po.Product;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;


/**
 * @author scmie
 */
public class CategoryDaoImpl implements CategoryDao {
    private final JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<Category> getCategoryList(Category category) {
        String sql = "select * from t_category where 1=1";
        List<Category> categoryList = new ArrayList<>();
        List<Object> objects = new ArrayList<>();

        if (category.getCategoryId() != null) {
            sql += " and category_id =?";
            objects.add(category.getCategoryId());
        }
        if (category.getCategoryName() != null) {
            sql += " and category_name=?";
            objects.add(category.getCategoryName());
        }

//        System.out.println("getCategoryList_sql="+sql);
        return jdbcTemplate.query(sql, objects.toArray(), new BeanPropertyRowMapper<>(Category.class));
    }

    @Override
    public int addCategory(Category category) {
        String sql = "insert into t_category(category_name) values(?)";
        return jdbcTemplate.update(sql, category.getCategoryName());
    }

    @Override
    public int updateCategory(Category category) {
        String sql = "update  t_category set category_name=? where category_id = ?";
        return jdbcTemplate.update(sql, category.getCategoryName(), category.getCategoryId());
    }

    @Override
    public int delCategory(Category category) {
        String sql = "delete  from  t_category where category_id = ?";
        String sql2 = "select * from t_product p  where p.category_id = ?";
        List<Object> objects = new ArrayList<>();
        objects.add(category.getCategoryId());
        List<Product> productList = jdbcTemplate.query(sql2,objects.toArray(),new BeanPropertyRowMapper<Product>(Product.class));
        if(productList.size() == 0){
            return jdbcTemplate.update(sql,objects.toArray());
        }else{
            return  -1;
        }


    }
}
