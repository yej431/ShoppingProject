<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
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
    <link rel="stylesheet" href="./css/grid.css">
    <link rel="stylesheet" href="./css/user-style.css">
    <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<div class="wrap" >
<div style="margin:40px 0">
<div style="padding:0 100px">
	<div style="margin-bottom:40px;">
		<span style="font-size:1.2em;font-weight:bold;">&lt;결제 정보&gt;</span>
	</div>
<%
String userid = (String)session.getAttribute("userid");
String sqlC="select * from cart inner join product on cart.productId=product.id where userid='"+userid+"'";
ResultSet rsC=st.executeQuery(sqlC);
try{
	while(rsC.next()){ 	
		int productId=rsC.getInt("productId");
		String productName=rsC.getString("name");
		int quantity=rsC.getInt("cartQuantity");
		int price=rsC.getInt("price");
		int total=rsC.getInt("totalPrice");
		String file=rsC.getString("file");
%>
	<div class="clearfix" style="margin-bottom:40px">
	<div style="float:left;"><img src="./upload/<%=file%>" width="140px"></div>
	<div style="float:left;margin-left:20px;">
		<div style="margin-bottom:20px">
			<a style="font-size:1.2em;font-weight:bold" href="productInfo.jsp?proId=<%=productId%>"><%=productName%></a>
		</div>
		<div><label style="font-size:1em;color:#c0392b">개수: <%=quantity%>개</label></div>
		<div><label style="font-size:1em;color:#c0392b;padding-top:10px;">
			전체금액: <fmt:formatNumber value="<%=total%>"/>원</label>
		</div>
	</div>
	</div>
<%
	}
}catch(Exception e){
	System.out.println(e);
}
%>
</div>
<%
String sqlC2="select sum(cart.totalPrice) total, user.name, user.email, user.mobileNumber, user.address, user.address2"
			+" from cart inner join user on cart.userid=user.userid and cart.userid='"+userid+"'";
ResultSet rsC2=st.executeQuery(sqlC2);
try{
	if(rsC2.next()){
		int total=rsC2.getInt("total");
		String name=rsC2.getString("name");
		String email=rsC2.getString("email");
		String mobileNumber=rsC2.getString("mobileNumber");
		String address=rsC2.getString("address");
		String address2=rsC2.getString("address2");
%>
<div style="padding:0 100px">
<form action="./UserOrderServlet" method="post">
	<input type="hidden" name="userid" value="<%=userid%>"/>
	<div style="margin:50px 0 20px;"><span style="font-size:1.1em;">- 고객 정보 -</span></div>
	<div style="margin-bottom:10px;">
		<span><strong>이름: </strong></span><%=name%>
	</div>	
	<div style="margin-bottom:10px;">
		<span><strong>이메일: </strong></span><%=email%>
	</div>
	<div style="margin-bottom:10px;">
		<span><strong>전화번호: </strong></span><%=mobileNumber%>
	</div>
	<div style="margin-bottom:10px;">
		<span><strong>주소1: </strong></span><%=address%>
	</div>
	<div style="margin-bottom:10px;">
		<span><strong>주소2: </strong></span><%=address2%>
	</div>
	<div style="margin-bottom:10px;">
		<span><strong>결제수단: </strong></span>
		<select name="paymentMethod">
			<option value="무통장 입금">무통장 입금</option>
			<option value="계좌이체">계좌이체</option>
			<option value="신용카드">신용카드</option>
			<option value="휴대폰 소액결제">휴대폰 소액결제</option>
		</select>
	</div>
	<div class="clerafix" style="float:right;margin-top:40px;">
	<button type="submit"><fmt:formatNumber value="<%=total%>"/>원 결제하기</button>
	</div>
<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
</form>
</div>
</div>
</div>
</body>
</html>