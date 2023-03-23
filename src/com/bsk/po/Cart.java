package com.bsk.po;

/**
  * 购物车
 * @author 黑猫
 *
 */
public class Cart {

	/**
	 * 购物车编号
	 */
	private Integer cartId;
	
	/**
	 * 餐品编号 外键
	 */
	private Integer productId;
	
	/**
	 * 餐品数量
	 */
	private int productNum=1;
	
	/**
	 * 用户编号 外键
	 */
	private Integer userId;

	public Cart() {}
	
	public Cart(Integer cartId, Integer productId, int productNum, Integer userId) {
		this.cartId = cartId;
		this.productId = productId;
		this.productNum = productNum;
		this.userId = userId;
	}

	public Integer getCartId() {
		return cartId;
	}

	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Cart [cartId=" + cartId + ", productId=" + productId + ", productNum=" + productNum + ", userId="
				+ userId + "]";
	}
	
}
