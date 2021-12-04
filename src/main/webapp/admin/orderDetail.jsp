<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="../mainHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑is</title>
    <!-- google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- boxicons -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <!-- app css -->
    <link rel="stylesheet" href="../css/grid.css">
    <link rel="stylesheet" href="../css/admin-style.css">
    <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
    <style>
    	li{
    		padding:8px 0px 8px 0;
    	}
    </style>
</head>
<body>
<div class="wrap">
<div id="p-info">
<%	
	String userid=request.getParameter("userid");
	String orderDate=request.getParameter("orderDate");	
	
	String sqlO = "select * from orders inner join product on orders.productId=product.id"
			+" where orders.userid='"+userid+"' and orders.orderDate='"+orderDate+"'";
	rs2=st.executeQuery(sqlO);
	rs2.next();
	int proId=rs2.getInt("productId");
	String name=rs2.getString("name");
	int quantity=rs2.getInt("quantity");
	int price=rs2.getInt("price");
	int totalPrice=rs2.getInt("totalPrice");
	String paymentMethod=rs2.getString("paymentMethod");
	Date deliveryDate=rs2.getDate("deliveryDate");
	String status=rs2.getString("status");
	String file=rs2.getString("file");
%>
<form action="../EditOrderServlet" method="post">
<div class="p-info-top clearfix" style="margin:40px 0;font-size:1em;">
	<div>
		<img src="../upload/<%=file%>" style="width:20%;float:left" class="clearfix">
	</div>
	<ul style="float:left;margin-left:120px;width:50%;" class="list clearfix">
		<li style="border-bottom:1px solid grey;"><strong>주문자 아이디:</strong> <%=userid%></li>
		<li><strong>상품 번호:</strong> <%=proId%></li>
		<li><strong>상품 이름:</strong> <%=name%></li>
		<li><strong>상품 가격:</strong> <fmt:formatNumber value="<%=price%>"/></li>
		<li style="border-bottom:1px solid grey;"><strong>전체 가격:</strong> <fmt:formatNumber value="<%=totalPrice%>"/></li>
		<li><strong>결제 수단:</strong> <%=paymentMethod%></li>	
		<li><strong>주문 날짜:</strong> <%=orderDate%></li>		
		<li><strong>예상 배송 날짜:</strong> <%=deliveryDate%></li>		
		<li style="border-bottom:1px solid grey;"><strong>주문 상태:</strong> <%=status%></li>	
	</ul>
</div>
</form>
</div>
</div>
</body>
</html>