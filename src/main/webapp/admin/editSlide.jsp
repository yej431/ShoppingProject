<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ include file="mainScreenHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="java.sql.*"%>
<%
String id=request.getParameter("id");	
String file=request.getParameter("file");
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
<form action="../EditSlideServlet" method="post" enctype="multipart/form-data">
	<div id="add-category">
	<div class="category">
		<input type="hidden" name="id" value="<%=id%>">
		<div class="txt-style">
			<label>현재 파일: </label>
			<div style="width:50%;margin-top:10px;"><img src="../upload/<%=file%>" onerror="this.style.display='none'" alt=""/></div>
		</div>
		<div class="txt-style">
			<label>파일 선택: </label>
			<input type="file" name="file">		
		</div>
	</div>
	</div>
	<input type="submit" class="submit" value="저장">
</form>
</div>
</body>
</html>