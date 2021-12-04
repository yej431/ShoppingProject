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
    <link rel="stylesheet" href="../css/user-style.css">
    <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
    <style>
    	.div > div{
    		padding-bottom:15px;
    	}
    </style>
</head>
<body>
<div class="wrap">
<div id="p-info">
<form action="../EditOrderServlet" method="post">
<%	
	String userid=request.getParameter("userid");
	String orderDate=request.getParameter("orderDate");	
	String productId=request.getParameter("productId");	
	
	String sqlO = "select * from orders inner join product on orders.productId=product.id"
			+" where orders.userid='"+userid+"' and orders.productId='"+productId+"' and orders.orderDate='"+orderDate+"'";
	ResultSet rs=st.executeQuery(sqlO);
	if(rs.next()) {
		int totalPrice=rs.getInt("totalPrice");
		String paymentMethod=rs.getString("paymentMethod");
		Date deliveryDate=rs.getDate("deliveryDate");
		String status=rs.getString("status");
		String file=rs.getString("file");
%>

<div class="p-info-top clearfix" style="padding-top:40px;font-size:0.8em;margin-bottom:40px;">
	<input type="hidden" name="userid" value="<%=userid%>"/>
	<input type="hidden" name="orderDate" value="<%=orderDate%>"/>
	<input type="hidden" name="proId" value="<%=productId%>"/>
	<div>
		<img src="../upload/<%=file%>" style="width:300px;float:left">
	</div>
	<div style="float:left;margin-left:120px;" class="div">
		<div>주문자 아이디: <%=userid%></div>
		<div>상품 번호: <%=productId%></div>
		<div>전체 가격: <fmt:formatNumber value="<%=totalPrice%>"/></div>
		<div>결제 수단: <%=paymentMethod%></div>	
		<div>주문 날짜: <%=orderDate%></div>		
		<div>예상 배송 날짜: <%=deliveryDate%></div>		
		<div>주문 상태: <%=status%></div>		
		<div style="margin-bottom:10px;">
			<span><strong>주문상태 수정: </strong></span>
			<select name="status">
				<option value="결제완료">결제완료</option>				
				<option value="배송준비중">배송준비중</option>
				<option value="배송중">배송중</option>
				<option value="배송완료">배송완료</option>
				<option value="주문취소">주문취소</option>
			</select>
		</div>
	</div>	
</div>
<input type="submit" class="submit" onclick="return confirm('정말 수정하시겠습니까?')" value="수정"/>
<%
	}
%>
</form>
</div>
</div>
</body>
</html>