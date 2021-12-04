<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ include file="categoryHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="java.sql.*"%>
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
<form action="../AddCategoryServlet" method="post">
	<div id="txt-wrap">
	<div class="txt-inner">
		<div class="txt-style">
			<strong>메인 카테고리: </strong>
			<input type="text" name="main" required>
		</div>
		<div class="txt-style">
			<label>카테고리1: </label>
			<input type="text" name="sub1" required>
		</div>
		<div class="txt-style">
			<label>카테고리2: </label>
			<input type="text" name="sub2">
		</div>
		<div class="txt-style">
			<label>카테고리3: </label>
			<input type="text" name="sub3">
		</div>
		<div class="txt-style">
			<label>카테고리4: </label>
			<input type="text" name="sub4">
		</div>
	</div>
	</div>
	<input type="submit" class="submit" value="저장">
</form>
</div>
</body>
</html>