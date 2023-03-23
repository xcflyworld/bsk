package com.bsk.po;

/**
 * 地址的实体类
 * @author 黑猫
 */
public class Address {

	/**
	 * 地址编号
	 */
	private Integer addressId;
	
	/**
	 * 省
	 */
	private String addressProvince;
	
	/**
	 * 市
	 */
	private String addressCity;
	
	/**
	 * 区
	 */
	private String addressDistrict;
	
	/**
	 * 地址描述
	 */
	private String addressDescribe;
	
	/**
	 * 用户编号 外键
	 */
	private Integer UserId;

	public Address() {}
	
	public Address(Integer addressId, String addressProvince, String addressCity, String addressDistrict,
                   String addressDescribe, Integer userId) {
		this.addressId = addressId;
		this.addressProvince = addressProvince;
		this.addressCity = addressCity;
		this.addressDistrict = addressDistrict;
		this.addressDescribe = addressDescribe;
		UserId = userId;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public String getAddressProvince() {
		return addressProvince;
	}

	public void setAddressProvince(String addressProvince) {
		this.addressProvince = addressProvince;
	}

	public String getAddressCity() {
		return addressCity;
	}

	public void setAddressCity(String addressCity) {
		this.addressCity = addressCity;
	}

	public String getAddressDistrict() {
		return addressDistrict;
	}

	public void setAddressDistrict(String addressDistrict) {
		this.addressDistrict = addressDistrict;
	}

	public String getAddressDescribe() {
		return addressDescribe;
	}

	public void setAddressDescribe(String addressDescribe) {
		this.addressDescribe = addressDescribe;
	}

	public Integer getUserId() {
		return UserId;
	}

	public void setUserId(Integer userId) {
		UserId = userId;
	}

	@Override
	public String toString() {
		return "Address{" +
				"addressId=" + addressId +
				", addressProvince='" + addressProvince + '\'' +
				", addressCity='" + addressCity + '\'' +
				", addressDistrict='" + addressDistrict + '\'' +
				", addressDescribe='" + addressDescribe + '\'' +
				", UserId=" + UserId +
				'}';
	}
}
