<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../mainHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="controller.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑is - 상품목록</title>
    <!-- google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- boxicons -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <!-- app css -->
    <link rel="stylesheet" href="../css/grid.css">
    <link rel="stylesheet" href="../css/admin-style.css">
</head>
<body>
<div class="wrap">
<div style="margin:45px 0;padding:0 100px">
<div class="clearfix" style="background:#f5f5f5;padding:10px 0;font-size:0.8em">
<form>
<div style="float:left;">
<span style="margin-right:30px;vertical-align:middle;padding-left:10px;">상품검색</span>
	<select name="key" style="height:30px;width:120px;">
  		<option ${(param.key=="userid")?"selected":""} value="userid">아이디</option>
  		<option ${(param.key=="orderDate")?"selected":""} value="orderDate">주문날짜</option>
  		<option ${(param.key=="totalPrice")?"selected":""} value="totalPrice">전체가격</option>
  		<option ${(param.key=="status")?"selected":""} value="status">상태</option>
  	</select>
    <input type="search" placeholder="Search" name="word" value="${param.word}" aria-label="Search" 
    	style="height:30px;width:250px;"/>
</div>
<button style="margin-left:5px; height:30px;width:40px;" type="submit">검색</button>
</form>
</div>
<%	
PreparedStatement ps = null;

int unit=7;

String p=request.getParameter("p");
if(p==null){
	p="1";
}
int v_page=Integer.parseInt(p);
int index_no=(v_page-1)*unit;

String sqlTot="select count(*) total from orders";	
ResultSet rsTot=st.executeQuery(sqlTot);
rsTot.next();
int total=rsTot.getInt("total");

int lastpage=(int)Math.ceil((double)total/7);
%>
<table>
<tr>
	<th>아이디</th>
	<th>주문날짜</th>
	<th>주문상세</th>
	<th>전체가격</th>
	<th>상태</th>
	<th>수정</th>
	<th>삭제</th>
</tr>
<%
String key=request.getParameter("key");
String word=request.getParameter("word");
String data;
if(word != null && !word.equals("")){
	data="select * from orders where "+key+" like '%"+word+"%' order by id desc limit "+index_no+","+unit;
}else{
	data = "select * from orders order by id desc limit "+index_no+","+unit;
}
ResultSet rsO=st.executeQuery(data);
while(rsO.next()) {
	String userid=rsO.getString("userid");
	String productId=rsO.getString("productId");
	Date orderDate=rsO.getDate("orderDate");
	int totalPrice=rsO.getInt("totalPrice");
	String status=rsO.getString("status");
%>
<tr>	
	<td style="width:20%"><%=userid%></td>
	<td style="width:20%"><%=orderDate%></td>	
	<td style="width:10%;color:var(--red);font-weight:bold">
		<a href="orderDetail.jsp?userid=<%=userid%>&orderDate=<%=orderDate%>
			&status=<%=status%>">주문상세</a>
	</td>
	<td style="width:20%"><fmt:formatNumber value="<%=totalPrice%>"/></td>	
	<td style="width:10%"><%=status%></td>	
	<td style="width:10%"><a href="editOrder.jsp?userid=<%=userid%>&orderDate=<%=orderDate%>
		&productId=<%=productId%>">수정</a></td>
	<td style="width:10%"><a href="../DeleteOrderServlet?userid=<%=userid%>&orderDate=<%=orderDate%>&productId=<%=productId%>" 
		onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
</tr>
<%
}
%>
</table>
<c:set var="page" value="${(empty param.p)? 1:param.p}"/>
<c:set var="startNum" value="${page-(page-1)%5}"/>
<c:set var="lastNum" value="<%=lastpage%>"/>
<div class="board-number">
	<div class="prev">
		<c:if test="${startNum>1}">
			<a href="orderList.jsp?p=${startNum+i}?p=${startNum-1}&t=&q=">이전</a>
		</c:if>
		<c:if test="${startNum<=1}">
			<span onclick="alert('이전 페이지가 없습니다.');">이전</span>
		</c:if>
	</div>		
	<ul class="number">
		<c:forEach var="i" begin="0" end="4">
		<c:if test="${(startNum+i) <= lastNum}">
			<li><a style="${(page==(startNum+i))?'color:#c0392b':''}" 
				href="orderList.jsp?p=${startNum+i}">${startNum+i}</a></li>
		</c:if>
		</c:forEach>	
	</ul>
	<div class="next">
		<c:if test="${startNum+4<lastNum}">
			<a href="orderList.jsp?p=${startNum+i}?p=${startNum+5}">다음</a>
		</c:if>
		<c:if test="${startNum+4>=lastNum}">
			<span onclick="alert('다음 페이지가 없습니다.');">다음</span>
		</c:if>
	</div>
</div>
</div>
</div>
</body>
</html>