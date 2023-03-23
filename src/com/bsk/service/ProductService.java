package com.bsk.service;

import com.bsk.dto.ProductDto;
import com.bsk.po.Product;

import java.util.List;

/**
 * @author scmie
 */
public interface ProductService {



    /**
     * 所有餐品
     * @param product
     * @return
     */
    List<Product> getProductList(Product product,int pageNum,int pageSize,int type);


    List<ProductDto> getProductDtoList(ProductDto product, int pageNum, int pageSize, int type);

    /**
     * 添加餐品
     * @param product
     * @return
     */
    int addProduct(Product product);

    /**
     * 修改餐品信息
     * @param product
     * @return
     */
    int updateProduct(Product product);

    /**
     * 删除餐品信息
     * @param product
     * @return
     */
    int deleteProduct(Product product);
}
