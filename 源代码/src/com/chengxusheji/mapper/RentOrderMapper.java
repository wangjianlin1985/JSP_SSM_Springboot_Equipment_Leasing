package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.RentOrder;

public interface RentOrderMapper {
	/*添加租赁订单信息*/
	public void addRentOrder(RentOrder rentOrder) throws Exception;

	/*按照查询条件分页查询租赁订单记录*/
	public ArrayList<RentOrder> queryRentOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有租赁订单记录*/
	public ArrayList<RentOrder> queryRentOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的租赁订单记录数*/
	public int queryRentOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条租赁订单记录*/
	public RentOrder getRentOrder(int orderId) throws Exception;

	/*更新租赁订单记录*/
	public void updateRentOrder(RentOrder rentOrder) throws Exception;

	/*删除租赁订单记录*/
	public void deleteRentOrder(int orderId) throws Exception;

}
