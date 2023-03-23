package com.bsk.dto;

import com.bsk.po.Cart;

/**
 * @author scmie
 */
public class CartDto extends Cart {

    /**
     * 餐品名称
     */
    private String productName;

    /**
     * 餐品图片
     */
    private String productPic;

    /**
     * 餐品单价
     */
    private String productPrice;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }
}
