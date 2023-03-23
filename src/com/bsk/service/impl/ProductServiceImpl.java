package com.bsk.service.impl;

import com.bsk.dao.ProductDao;
import com.bsk.dao.impl.ProductDaoImpl;
import com.bsk.dto.ProductDto;
import com.bsk.po.Product;
import com.bsk.service.ProductService;

import java.util.List;

/**
 * @author scmie
 */
public class ProductServiceImpl implements ProductService {
    private ProductDao productDao = new ProductDaoImpl();
    @Override
    public List<Product> getProductList(Product product,int pageNum,int pageSize,int type) {

        return productDao.getProductList(product,pageNum,pageSize,type);
    }

    @Override
    public List<ProductDto> getProductDtoList(ProductDto product, int pageNum, int pageSize, int type) {
        return productDao.getProductDtoList(product,pageNum,pageSize,type);
    }

    @Override
    public int addProduct(Product product) {
        return productDao.addProduct(product);
    }

    @Override
    public int updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    @Override
    public int deleteProduct(Product product) {
        return productDao.deleteProduct(product);
    }
}
