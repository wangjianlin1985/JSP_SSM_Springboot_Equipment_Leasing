package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.RentOrder;

import com.chengxusheji.mapper.RentOrderMapper;
@Service
public class RentOrderService {

	@Resource RentOrderMapper rentOrderMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加租赁订单记录*/
    public void addRentOrder(RentOrder rentOrder) throws Exception {
    	rentOrderMapper.addRentOrder(rentOrder);
    }

    /*按照查询条件分页查询租赁订单记录*/
    public ArrayList<RentOrder> queryRentOrder(UserInfo userObj,Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_rentOrder.userObj='" + userObj.getUser_name() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_rentOrder.productObj=" + productObj.getProductId();
    	if(!rentDate.equals("")) where = where + " and t_rentOrder.rentDate like '%" + rentDate + "%'";
    	if(!returnDate.equals("")) where = where + " and t_rentOrder.returnDate like '%" + returnDate + "%'";
    	if(!orderTime.equals("")) where = where + " and t_rentOrder.orderTime like '%" + orderTime + "%'";
    	if(!receiveName.equals("")) where = where + " and t_rentOrder.receiveName like '%" + receiveName + "%'";
    	if(!orderStateObj.equals("")) where = where + " and t_rentOrder.orderStateObj like '%" + orderStateObj + "%'";
    	if(!telephone.equals("")) where = where + " and t_rentOrder.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return rentOrderMapper.queryRentOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<RentOrder> queryRentOrder(UserInfo userObj,Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_rentOrder.userObj='" + userObj.getUser_name() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_rentOrder.productObj=" + productObj.getProductId();
    	if(!rentDate.equals("")) where = where + " and t_rentOrder.rentDate like '%" + rentDate + "%'";
    	if(!returnDate.equals("")) where = where + " and t_rentOrder.returnDate like '%" + returnDate + "%'";
    	if(!orderTime.equals("")) where = where + " and t_rentOrder.orderTime like '%" + orderTime + "%'";
    	if(!receiveName.equals("")) where = where + " and t_rentOrder.receiveName like '%" + receiveName + "%'";
    	if(!orderStateObj.equals("")) where = where + " and t_rentOrder.orderStateObj like '%" + orderStateObj + "%'";
    	if(!telephone.equals("")) where = where + " and t_rentOrder.telephone like '%" + telephone + "%'";
    	return rentOrderMapper.queryRentOrderList(where);
    }

    /*查询所有租赁订单记录*/
    public ArrayList<RentOrder> queryAllRentOrder()  throws Exception {
        return rentOrderMapper.queryRentOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_rentOrder.userObj='" + userObj.getUser_name() + "'";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_rentOrder.productObj=" + productObj.getProductId();
    	if(!rentDate.equals("")) where = where + " and t_rentOrder.rentDate like '%" + rentDate + "%'";
    	if(!returnDate.equals("")) where = where + " and t_rentOrder.returnDate like '%" + returnDate + "%'";
    	if(!orderTime.equals("")) where = where + " and t_rentOrder.orderTime like '%" + orderTime + "%'";
    	if(!receiveName.equals("")) where = where + " and t_rentOrder.receiveName like '%" + receiveName + "%'";
    	if(!orderStateObj.equals("")) where = where + " and t_rentOrder.orderStateObj like '%" + orderStateObj + "%'";
    	if(!telephone.equals("")) where = where + " and t_rentOrder.telephone like '%" + telephone + "%'";
        recordNumber = rentOrderMapper.queryRentOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取租赁订单记录*/
    public RentOrder getRentOrder(int orderId) throws Exception  {
        RentOrder rentOrder = rentOrderMapper.getRentOrder(orderId);
        return rentOrder;
    }

    /*更新租赁订单记录*/
    public void updateRentOrder(RentOrder rentOrder) throws Exception {
        rentOrderMapper.updateRentOrder(rentOrder);
    }

    /*删除一条租赁订单记录*/
    public void deleteRentOrder (int orderId) throws Exception {
        rentOrderMapper.deleteRentOrder(orderId);
    }

    /*删除多条租赁订单信息*/
    public int deleteRentOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		rentOrderMapper.deleteRentOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
