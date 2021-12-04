<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ include file="categoryHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="java.sql.*"%>
<%
String id=request.getParameter("id");
String main=request.getParameter("main");	
String sub1=request.getParameter("sub1");	
String sub2=request.getParameter("sub2");	
String sub3=request.getParameter("sub3");	
String sub4=request.getParameter("sub4");	
%>
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
    <link rel="stylesheet" href="../css/grid.css">
    <link rel="stylesheet" href="../css/admin-style.css">
</head>
<body>
<div class="wrap">
<form action="../EditCategoryServlet" method="post">
	<div id="add-category">
	<div class="category">
		<input type="hidden" name="id" value="<%=id%>">
		<div class="txt-style">
			<strong>메인 카테고리: </strong>
			<input style="color:#bdbdbd" type="text" name="main" value="<%=main%>" required>
		</div>
		<div class="txt-style">
			<label>카테고리1: </label>
			<input style="color:#bdbdbd" type="text" name="sub1" value="<%=sub1%>" required>
		</div>
		<div class="txt-style">
			<label>카테고리2: </label>
			<input style="color:#bdbdbd" type="text" name="sub2" value="<%=sub2%>">
		</div>
		<div class="txt-style">
			<label>카테고리3: </label>
			<input style="color:#bdbdbd" type="text" name="sub3" value="<%=sub3%>">
		</div>
		<div class="txt-style">
			<label>카테고리4: </label>
			<input style="color:#bdbdbd" type="text" name="sub4" value="<%=sub4%>">
		</div>
	</div>
	</div>
	<input type="submit" class="submit" value="저장">
</form>
</div>
</body>
</html>