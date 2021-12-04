<%@page import="java.util.ArrayList"%>
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
</head>
<body>
<div class="wrap" >
<div style="margin:40px 0">
<div style="padding:0 100px">
<%
String userid = (String)session.getAttribute("userid");
	String msg2 =null;
	if(session.getAttribute("msg") != null){
		msg2=(String)session.getAttribute("msg");
	}
	if(msg2 != null){
	if(msg2.equals("결제 완료")){
%>
<script>
	alert("결제 완료");
</script>
<%
	session.removeAttribute("msg");
	}
	if(msg2.equals("결제 실패")){
%>
<script>
	alert("결제 실패");
</script>
<%
	session.removeAttribute("msg");
	}
}

String sqlC="select * from cart inner join product on cart.productId=product.id where userid='"+userid+"'";
ResultSet rsC;
rsC=st.executeQuery(sqlC);
int result=0;
try{
	while(rsC.next()){ 	
		result=1;
		String productId=rsC.getString("productId");
		String productName=rsC.getString("name");
		String quantity=rsC.getString("cartQuantity");
		String price=rsC.getString("price");
		String totalPrice=rsC.getString("totalPrice");
		String file=rsC.getString("file");
%>
<div class="clearfix" style="margin-bottom:40px">
<div style="float:left;"><img src="./upload/<%=file%>" width="140px"></div>
<div style="float:left;margin-left:20px;">
	<div style="margin-bottom:20px">
		<a style="font-size:1.2em;font-weight:bold" href="productInfo.jsp?proId=<%=productId%>"><%=productName%></a>
	</div>
	<div><label style="font-size:1em;color:#c0392b">개수: <%=quantity%>개</label></div>
	<div><label style="font-size:1em;color:#c0392b;">
		전체금액: <fmt:formatNumber value="<%=totalPrice%>"/>원</label>
	</div>	
	<div style="margin-top:20px;">	
	<button onclick="location='./CartDelateServlet?userid=<%=userid%>&proId=<%=productId%>'" type="button">삭제</button>
	</div>
</div>
</div>
<%
	}
	
}catch(Exception e){
	e.printStackTrace();
}

if(result==0){
%>
<div style="text-align:center;margin:100px auto"><label style="font-size:1em;">장바구니가 비었습니다.</label></div>
<%
}else{
%>
<div class="clearfix" style="float:right;margin-top:40px;">	
	<span style="margin-left:10px"><a href="payment.jsp" style="font-size:1rem">결제하기</a></span>
</div>
<%
}
%>

</div>
</div>
</div>
</body>
</html>