<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="userInfoHeader.jsp" %>
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
<body>
<div class="wrap">
<div style="margin:45px 0;">
<%
String userid = (String)session.getAttribute("userid");
Connection con = ConnectionProvider.getCon();
Statement st = con.createStatement();
PreparedStatement ps = null;
%>
<table>
<tr>
	<th>상품이름</th>
	<th>수량</th>
	<th>전체가격</th>
	<th>결제수단</th>
	<th>주문날짜</th>
	<th>배송예정날짜</th>
	<th>상태</th>
	<th>주문취소</th>
</tr>
<%
String sql="select * from orders inner join product on orders.productId=product.id"
	+" where orders.userid='"+userid+"' order by orderDate desc";	
ResultSet rs=st.executeQuery(sql);
while(rs.next()) {
%>
<tr>
	<td style="width:14.1%">
		<a href='productInfo.jsp?idPro=<%=rs.getInt("productId")%>&sub=<%=rs.getString("subCategory")%>'>
			<%=rs.getString("productName")%>
		</a>
	</td>
	<td style="width:5%"><%=rs.getInt("orderQuantity")%> 개</td>
	<td style="width:14.1%"><fmt:formatNumber value='<%=rs.getInt("totalPrice")%>'/> 원</td>
	<td style="width:14.1%"><%=rs.getString("paymentMethod")%></td>
	<td style="width:14.1%"><%=rs.getString("orderDate")%></td>
	<td style="width:14.1%"><%=rs.getString("deliveryDate")%></td>
	<td style="width:14.1%"><%=rs.getString("status")%></td>
	<td style="width:10%;" >
		<a href="./UserCancleOrder?userid=<%=rs.getString("userid")%>&productId=<%=rs.getString("productId")%>
			&status=<%=rs.getString("status")%>" onclick="return confirm('정말 취소하시겠습니까?')"
			style="color:var(--red)">주문취소</a>
	</td>
</tr>
<%
}
%>
</table>
</div>
</div>
</body>
</html>