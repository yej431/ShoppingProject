<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="categoryHeader.jsp" %>
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
    <title>쇼핑is - 카테고리목록</title>
    <!-- google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- boxicons -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <!-- app css -->
    <link rel="stylesheet" href="./css/grid.css">
    <link rel="stylesheet" href="./css/admin-style.css">
</head>
<body>
<div class="wrap">
<div style="margin:45px 0;">
<%
Connection con = ConnectionProvider.getCon();
Statement st = con.createStatement();
PreparedStatement ps = null;
%>
<table>
<tr>
	<th>메인카테고리</th>	
	<th>서브카테고리1</th>
	<th>서브카테고리2</th>
	<th>서브카테고리3</th>
	<th>서브카테고리4</th>
	<th>수정</th>
	<th>삭제</th>
</tr>
<%
String sql="select * from category";	
ResultSet rs=st.executeQuery(sql);
while(rs.next()) {
	int id=rs.getInt("id");
	String main=rs.getString("main");
	String sub1=rs.getString("sub1");
	String sub2=rs.getString("sub2");
	String sub3=rs.getString("sub3");
	String sub4=rs.getString("sub4");
%>
<tr>
	<td style="width:18%"><%=main%></td>
	<td style="width:18%"><%=sub1%></td>
	<td style="width:18%"><%=sub2%></td>
	<td style="width:18%"><%=sub3%></td>
	<td style="width:18%"><%=sub4%></td>
	<td style="width:5%"><a href="editCategory.jsp?id=<%=id%>&main=<%=main%>&sub1=<%=sub1%>&sub2=<%=sub2%>
		&sub3=<%=sub3%>&sub4=<%=sub4%>">수정</a></td>
	<td style="width:5%"><a href="../DeleteCategoryServlet?id=<%=id%>" 
		onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
</tr>
<%
}
%>
</table>
</div>
</div>
</body>
</html>