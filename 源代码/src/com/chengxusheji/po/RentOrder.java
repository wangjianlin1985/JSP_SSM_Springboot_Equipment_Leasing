package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class RentOrder {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*下单用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*租赁商品*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*租赁数量*/
    @NotNull(message="必须输入租赁数量")
    private Integer rentCount;
    public Integer getRentCount() {
        return rentCount;
    }
    public void setRentCount(Integer rentCount) {
        this.rentCount = rentCount;
    }

    /*租赁开始日期*/
    @NotEmpty(message="租赁开始日期不能为空")
    private String rentDate;
    public String getRentDate() {
        return rentDate;
    }
    public void setRentDate(String rentDate) {
        this.rentDate = rentDate;
    }

    /*租赁天数*/
    @NotNull(message="必须输入租赁天数")
    private Integer days;
    public Integer getDays() {
        return days;
    }
    public void setDays(Integer days) {
        this.days = days;
    }

    /*回收日期*/
    @NotEmpty(message="回收日期不能为空")
    private String returnDate;
    public String getReturnDate() {
        return returnDate;
    }
    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    /*订单总金额*/
    @NotNull(message="必须输入订单总金额")
    private Float totalMoney;
    public Float getTotalMoney() {
        return totalMoney;
    }
    public void setTotalMoney(Float totalMoney) {
        this.totalMoney = totalMoney;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderStateObj;
    public String getOrderStateObj() {
        return orderStateObj;
    }
    public void setOrderStateObj(String orderStateObj) {
        this.orderStateObj = orderStateObj;
    }

    /*下单时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    /*收货人*/
    @NotEmpty(message="收货人不能为空")
    private String receiveName;
    public String getReceiveName() {
        return receiveName;
    }
    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    /*收货电话*/
    @NotEmpty(message="收货电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*收货地址*/
    @NotEmpty(message="收货地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*订单物流*/
    private String wuliu;
    public String getWuliu() {
        return wuliu;
    }
    public void setWuliu(String wuliu) {
        this.wuliu = wuliu;
    }

    /*订单备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRentOrder=new JSONObject(); 
		jsonRentOrder.accumulate("orderId", this.getOrderId());
		jsonRentOrder.accumulate("userObj", this.getUserObj().getName());
		jsonRentOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonRentOrder.accumulate("productObj", this.getProductObj().getProductName());
		jsonRentOrder.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonRentOrder.accumulate("rentCount", this.getRentCount());
		jsonRentOrder.accumulate("rentDate", this.getRentDate().length()>19?this.getRentDate().substring(0,19):this.getRentDate());
		jsonRentOrder.accumulate("days", this.getDays());
		jsonRentOrder.accumulate("returnDate", this.getReturnDate().length()>19?this.getReturnDate().substring(0,19):this.getReturnDate());
		jsonRentOrder.accumulate("totalMoney", this.getTotalMoney());
		jsonRentOrder.accumulate("orderStateObj", this.getOrderStateObj());
		jsonRentOrder.accumulate("orderTime", this.getOrderTime());
		jsonRentOrder.accumulate("receiveName", this.getReceiveName());
		jsonRentOrder.accumulate("telephone", this.getTelephone());
		jsonRentOrder.accumulate("address", this.getAddress());
		jsonRentOrder.accumulate("wuliu", this.getWuliu());
		jsonRentOrder.accumulate("orderMemo", this.getOrderMemo());
		return jsonRentOrder;
    }}