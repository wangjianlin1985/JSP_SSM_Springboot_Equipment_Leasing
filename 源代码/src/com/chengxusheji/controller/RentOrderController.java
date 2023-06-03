package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.RentOrderService;
import com.chengxusheji.po.RentOrder;
import com.chengxusheji.service.ProductService;
import com.chengxusheji.po.Product;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//RentOrder管理控制层
@Controller
@RequestMapping("/RentOrder")
public class RentOrderController extends BaseController {

    /*业务层对象*/
    @Resource RentOrderService rentOrderService;

    @Resource ProductService productService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("rentOrder")
	public void initBinderRentOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("rentOrder.");
	}
	/*跳转到添加RentOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new RentOrder());
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "RentOrder_add";
	}

	/*客户端ajax方式提交添加租赁订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated RentOrder rentOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        rentOrderService.addRentOrder(rentOrder);
        message = "租赁订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加租赁订单信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(@Validated RentOrder rentOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		rentOrder.setUserObj(userObj);
		
		rentOrder.setReturnDate("--");
		
		int productId = rentOrder.getProductObj().getProductId();
		float price = productService.getProduct(productId).getPrice();
		rentOrder.setTotalMoney(price * rentOrder.getRentCount() * rentOrder.getDays());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		rentOrder.setOrderTime(sdf.format(new java.util.Date()));
		 
		
		
        rentOrderService.addRentOrder(rentOrder);
        message = "租赁订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax方式按照查询条件分页查询租赁订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("productObj") Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (rentDate == null) rentDate = "";
		if (returnDate == null) returnDate = "";
		if (orderTime == null) orderTime = "";
		if (receiveName == null) receiveName = "";
		if (orderStateObj == null) orderStateObj = "";
		if (telephone == null) telephone = "";
		if(rows != 0)rentOrderService.setRows(rows);
		List<RentOrder> rentOrderList = rentOrderService.queryRentOrder(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone, page);
	    /*计算总的页数和总的记录数*/
	    rentOrderService.queryTotalPageAndRecordNumber(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = rentOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rentOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(RentOrder rentOrder:rentOrderList) {
			JSONObject jsonRentOrder = rentOrder.getJsonObject();
			jsonArray.put(jsonRentOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询租赁订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<RentOrder> rentOrderList = rentOrderService.queryAllRentOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(RentOrder rentOrder:rentOrderList) {
			JSONObject jsonRentOrder = new JSONObject();
			jsonRentOrder.accumulate("orderId", rentOrder.getOrderId());
			jsonArray.put(jsonRentOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询租赁订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("productObj") Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (rentDate == null) rentDate = "";
		if (returnDate == null) returnDate = "";
		if (orderTime == null) orderTime = "";
		if (receiveName == null) receiveName = "";
		if (orderStateObj == null) orderStateObj = "";
		if (telephone == null) telephone = "";
		List<RentOrder> rentOrderList = rentOrderService.queryRentOrder(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    rentOrderService.queryTotalPageAndRecordNumber(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = rentOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rentOrderService.getRecordNumber();
	    request.setAttribute("rentOrderList",  rentOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("rentDate", rentDate);
	    request.setAttribute("returnDate", returnDate);
	    request.setAttribute("orderTime", orderTime);
	    request.setAttribute("receiveName", receiveName);
	    request.setAttribute("orderStateObj", orderStateObj);
	    request.setAttribute("telephone", telephone);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "RentOrder/rentOrder_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询租赁订单信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("productObj") Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (rentDate == null) rentDate = "";
		if (returnDate == null) returnDate = "";
		if (orderTime == null) orderTime = "";
		if (receiveName == null) receiveName = "";
		if (orderStateObj == null) orderStateObj = "";
		if (telephone == null) telephone = "";
		
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<RentOrder> rentOrderList = rentOrderService.queryRentOrder(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    rentOrderService.queryTotalPageAndRecordNumber(userObj, productObj, rentDate, returnDate, orderTime, receiveName, orderStateObj, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = rentOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rentOrderService.getRecordNumber();
	    request.setAttribute("rentOrderList",  rentOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("rentDate", rentDate);
	    request.setAttribute("returnDate", returnDate);
	    request.setAttribute("orderTime", orderTime);
	    request.setAttribute("receiveName", receiveName);
	    request.setAttribute("orderStateObj", orderStateObj);
	    request.setAttribute("telephone", telephone);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "RentOrder/rentOrder_userFrontquery_result"; 
	}

	
	

     /*前台查询RentOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取RentOrder对象*/
        RentOrder rentOrder = rentOrderService.getRentOrder(orderId);

        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("rentOrder",  rentOrder);
        return "RentOrder/rentOrder_frontshow";
	}

	/*ajax方式显示租赁订单修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取RentOrder对象*/
        RentOrder rentOrder = rentOrderService.getRentOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRentOrder = rentOrder.getJsonObject();
		out.println(jsonRentOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新租赁订单信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated RentOrder rentOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			rentOrderService.updateRentOrder(rentOrder);
			message = "租赁订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "租赁订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除租赁订单信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  rentOrderService.deleteRentOrder(orderId);
	            request.setAttribute("message", "租赁订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "租赁订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条租赁订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = rentOrderService.deleteRentOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出租赁订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("productObj") Product productObj,String rentDate,String returnDate,String orderTime,String receiveName,String orderStateObj,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(rentDate == null) rentDate = "";
        if(returnDate == null) returnDate = "";
        if(orderTime == null) orderTime = "";
        if(receiveName == null) receiveName = "";
        if(orderStateObj == null) orderStateObj = "";
        if(telephone == null) telephone = "";
        List<RentOrder> rentOrderList = rentOrderService.queryRentOrder(userObj,productObj,rentDate,returnDate,orderTime,receiveName,orderStateObj,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "RentOrder信息记录"; 
        String[] headers = { "订单id","下单用户","租赁商品","租赁数量","租赁开始日期","租赁天数","回收日期","订单总金额","订单状态","下单时间","收货人","收货电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<rentOrderList.size();i++) {
        	RentOrder rentOrder = rentOrderList.get(i); 
        	dataset.add(new String[]{rentOrder.getOrderId() + "",rentOrder.getUserObj().getName(),rentOrder.getProductObj().getProductName(),rentOrder.getRentCount() + "",rentOrder.getRentDate(),rentOrder.getDays() + "",rentOrder.getReturnDate(),rentOrder.getTotalMoney() + "",rentOrder.getOrderStateObj(),rentOrder.getOrderTime(),rentOrder.getReceiveName(),rentOrder.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"RentOrder.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
