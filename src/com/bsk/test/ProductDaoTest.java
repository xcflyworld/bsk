package com.bsk.test;

import com.bsk.dao.CategoryDao;
import com.bsk.dao.ProductDao;
import com.bsk.dao.impl.CategoryDaoImpl;
import com.bsk.dao.impl.ProductDaoImpl;
import com.bsk.dto.ProductDto;
import com.bsk.po.Category;
import com.bsk.po.Product;
import org.junit.Test;

import java.util.List;

/**
 * @author scmie
 */
public class ProductDaoTest {

    private ProductDao productDao = new ProductDaoImpl();
    private CategoryDao categoryDao =new CategoryDaoImpl();
    @Test

    /**
     * 获取餐品列表
     */
    public  void getProductList(){

        List<ProductDto> productList = productDao.getProductDtoList(new ProductDto(), 0, 0, 0);

        for (ProductDto product : productList) {
            System.out.println(product.toString());

        }
    }

    @Test
    public  void getCategoryList(){
        List<Category> categoryList = categoryDao.getCategoryList(new Category());
        for (Category category : categoryList) {
            System.out.println(category.toString());

        }
    }

}
