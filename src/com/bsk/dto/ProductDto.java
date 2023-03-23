package com.bsk.dto;

/**
 * @author scmie
 */
public class ProductDto {

    private Integer productId;
    private String productName;
    private String productPic;
    private Double productPrice;
    private String productDescribe;
    private Integer categoryId;
    private String productStatus;
    private String categoryName;

    public ProductDto() {
    }

    public ProductDto(Integer productId, String productName, String productPic, Double productPrice, String productDescribe, Integer categoryId, String productStatus, String categoryName) {
        this.productId = productId;
        this.productName = productName;
        this.productPic = productPic;
        this.productPrice = productPrice;
        this.productDescribe = productDescribe;
        this.categoryId = categoryId;
        this.productStatus = productStatus;
        this.categoryName = categoryName;
    }

    public ProductDto(String productName, Integer categoryId) {
        this.productName = productName;
        this.categoryId = categoryId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

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

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductDescribe() {
        return productDescribe;
    }

    public void setProductDescribe(String productDescribe) {
        this.productDescribe = productDescribe;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "ProductDto{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productPic='" + productPic + '\'' +
                ", productPrice=" + productPrice +
                ", productDescribe='" + productDescribe + '\'' +
                ", categoryId=" + categoryId +
                ", productStatus='" + productStatus + '\'' +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}
