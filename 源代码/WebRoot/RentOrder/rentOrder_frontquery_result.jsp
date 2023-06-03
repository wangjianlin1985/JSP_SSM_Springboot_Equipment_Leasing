<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.RentOrder" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<RentOrder> rentOrderList = (List<RentOrder>)request.getAttribute("rentOrderList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    Product productObj = (Product)request.getAttribute("productObj");
    String rentDate = (String)request.getAttribute("rentDate"); //租赁开始日期查询关键字
    String returnDate = (String)request.getAttribute("returnDate"); //回收日期查询关键字
    String orderTime = (String)request.getAttribute("orderTime"); //下单时间查询关键字
    String receiveName = (String)request.getAttribute("receiveName"); //收货人查询关键字
    String orderStateObj = (String)request.getAttribute("orderStateObj"); //订单状态查询关键字
    String telephone = (String)request.getAttribute("telephone"); //收货电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>租赁订单查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#rentOrderListPanel" aria-controls="rentOrderListPanel" role="tab" data-toggle="tab">租赁订单列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>RentOrder/rentOrder_frontAdd.jsp" style="display:none;">添加租赁订单</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="rentOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单id</td><td>下单用户</td><td>租赁商品</td><td>租赁数量</td><td>租赁开始日期</td><td>租赁天数</td><td>回收日期</td><td>订单总金额</td><td>订单状态</td><td>下单时间</td><td>收货人</td><td>收货电话</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<rentOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		RentOrder rentOrder = rentOrderList.get(i); //获取到租赁订单对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=rentOrder.getOrderId() %></td>
 											<td><%=rentOrder.getUserObj().getName() %></td>
 											<td><%=rentOrder.getProductObj().getProductName() %></td>
 											<td><%=rentOrder.getRentCount() %></td>
 											<td><%=rentOrder.getRentDate() %></td>
 											<td><%=rentOrder.getDays() %></td>
 											<td><%=rentOrder.getReturnDate() %></td>
 											<td><%=rentOrder.getTotalMoney() %></td>
 											<td><%=rentOrder.getOrderStateObj() %></td>
 											<td><%=rentOrder.getOrderTime() %></td>
 											<td><%=rentOrder.getReceiveName() %></td>
 											<td><%=rentOrder.getTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>RentOrder/<%=rentOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="rentOrderEdit('<%=rentOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="rentOrderDelete('<%=rentOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>租赁订单查询</h1>
		</div>
		<form name="rentOrderQueryForm" id="rentOrderQueryForm" action="<%=basePath %>RentOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="userObj_user_name">下单用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="productObj_productId">租赁商品：</label>
                <select id="productObj_productId" name="productObj.productId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Product productTemp:productList) {
	 					String selected = "";
 					if(productObj!=null && productObj.getProductId()!=null && productObj.getProductId().intValue()==productTemp.getProductId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productTemp.getProductId() %>" <%=selected %>><%=productTemp.getProductName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="rentDate">租赁开始日期:</label>
				<input type="text" id="rentDate" name="rentDate" class="form-control"  placeholder="请选择租赁开始日期" value="<%=rentDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="returnDate">回收日期:</label>
				<input type="text" id="returnDate" name="returnDate" class="form-control"  placeholder="请选择回收日期" value="<%=returnDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="orderTime">下单时间:</label>
				<input type="text" id="orderTime" name="orderTime" value="<%=orderTime %>" class="form-control" placeholder="请输入下单时间">
			</div>






			<div class="form-group">
				<label for="receiveName">收货人:</label>
				<input type="text" id="receiveName" name="receiveName" value="<%=receiveName %>" class="form-control" placeholder="请输入收货人">
			</div>






			<div class="form-group">
				<label for="orderStateObj">订单状态:</label>
				<input type="text" id="orderStateObj" name="orderStateObj" value="<%=orderStateObj %>" class="form-control" placeholder="请输入订单状态">
			</div>






			<div class="form-group">
				<label for="telephone">收货电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入收货电话">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="rentOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;租赁订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="rentOrderEditForm" id="rentOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="rentOrder_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="rentOrder_orderId_edit" name="rentOrder.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="rentOrder_userObj_user_name_edit" class="col-md-3 text-right">下单用户:</label>
		  	 <div class="col-md-9">
			    <select id="rentOrder_userObj_user_name_edit" name="rentOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_productObj_productId_edit" class="col-md-3 text-right">租赁商品:</label>
		  	 <div class="col-md-9">
			    <select id="rentOrder_productObj_productId_edit" name="rentOrder.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_rentCount_edit" class="col-md-3 text-right">租赁数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_rentCount_edit" name="rentOrder.rentCount" class="form-control" placeholder="请输入租赁数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_rentDate_edit" class="col-md-3 text-right">租赁开始日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date rentOrder_rentDate_edit col-md-12" data-link-field="rentOrder_rentDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="rentOrder_rentDate_edit" name="rentOrder.rentDate" size="16" type="text" value="" placeholder="请选择租赁开始日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_days_edit" class="col-md-3 text-right">租赁天数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_days_edit" name="rentOrder.days" class="form-control" placeholder="请输入租赁天数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_returnDate_edit" class="col-md-3 text-right">回收日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date rentOrder_returnDate_edit col-md-12" data-link-field="rentOrder_returnDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="rentOrder_returnDate_edit" name="rentOrder.returnDate" size="16" type="text" value="" placeholder="请选择回收日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_totalMoney_edit" class="col-md-3 text-right">订单总金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_totalMoney_edit" name="rentOrder.totalMoney" class="form-control" placeholder="请输入订单总金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_orderStateObj_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_orderStateObj_edit" name="rentOrder.orderStateObj" class="form-control" placeholder="请输入订单状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_orderTime_edit" class="col-md-3 text-right">下单时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_orderTime_edit" name="rentOrder.orderTime" class="form-control" placeholder="请输入下单时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_receiveName_edit" class="col-md-3 text-right">收货人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_receiveName_edit" name="rentOrder.receiveName" class="form-control" placeholder="请输入收货人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_telephone_edit" class="col-md-3 text-right">收货电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_telephone_edit" name="rentOrder.telephone" class="form-control" placeholder="请输入收货电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_address_edit" class="col-md-3 text-right">收货地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="rentOrder_address_edit" name="rentOrder.address" class="form-control" placeholder="请输入收货地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_wuliu_edit" class="col-md-3 text-right">订单物流:</label>
		  	 <div class="col-md-9">
			 	<textarea name="rentOrder.wuliu" id="rentOrder_wuliu_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="rentOrder_orderMemo_edit" class="col-md-3 text-right">订单备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="rentOrder_orderMemo_edit" name="rentOrder.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#rentOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRentOrderModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var rentOrder_wuliu_edit = UE.getEditor('rentOrder_wuliu_edit'); //订单物流编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.rentOrderQueryForm.currentPage.value = currentPage;
    document.rentOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.rentOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.rentOrderQueryForm.currentPage.value = pageValue;
    documentrentOrderQueryForm.submit();
}

/*弹出修改租赁订单界面并初始化数据*/
function rentOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "RentOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (rentOrder, response, status) {
			if (rentOrder) {
				$("#rentOrder_orderId_edit").val(rentOrder.orderId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#rentOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#rentOrder_userObj_user_name_edit").html(html);
		        		$("#rentOrder_userObj_user_name_edit").val(rentOrder.userObjPri);
					}
				});
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#rentOrder_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#rentOrder_productObj_productId_edit").html(html);
		        		$("#rentOrder_productObj_productId_edit").val(rentOrder.productObjPri);
					}
				});
				$("#rentOrder_rentCount_edit").val(rentOrder.rentCount);
				$("#rentOrder_rentDate_edit").val(rentOrder.rentDate);
				$("#rentOrder_days_edit").val(rentOrder.days);
				$("#rentOrder_returnDate_edit").val(rentOrder.returnDate);
				$("#rentOrder_totalMoney_edit").val(rentOrder.totalMoney);
				$("#rentOrder_orderStateObj_edit").val(rentOrder.orderStateObj);
				$("#rentOrder_orderTime_edit").val(rentOrder.orderTime);
				$("#rentOrder_receiveName_edit").val(rentOrder.receiveName);
				$("#rentOrder_telephone_edit").val(rentOrder.telephone);
				$("#rentOrder_address_edit").val(rentOrder.address);
				rentOrder_wuliu_edit.setContent(rentOrder.wuliu, false);
				$("#rentOrder_orderMemo_edit").val(rentOrder.orderMemo);
				$('#rentOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除租赁订单信息*/
function rentOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "RentOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#rentOrderQueryForm").submit();
					//location.href= basePath + "RentOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交租赁订单信息表单给服务器端修改*/
function ajaxRentOrderModify() {
	$.ajax({
		url :  basePath + "RentOrder/" + $("#rentOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#rentOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#rentOrderQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*租赁开始日期组件*/
    $('.rentOrder_rentDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*回收日期组件*/
    $('.rentOrder_returnDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

