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
<div class="wrap" >
<%
String id=request.getParameter("id");
String name=request.getParameter("name");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String address=request.getParameter("address");
String address2=request.getParameter("address2");
%>
<form action="./UserInfoChange" method="post">
<div id="txt-wrap">
	<div class="txt-inner">
		<div class="txt-style">
			<label>아이디: </label><%=id%>
		</div>
		<div class="txt-style">
			<label>이름: </label><input type="text" name="name" value="<%=name%>" style="color:#bdbdbd"/>
		</div>
		<div class="txt-style">
			<label>이메일: </label><input type="text" name="email" value="<%=email%>" style="color:#bdbdbd"/>
		</div>
		<div class="txt-style">
			<label>전화번호: </label><input type="text" name="phone" value="<%=phone%>" style="color:#bdbdbd"/>
		</div>
		<div class="txt-style">
			<label>주소: </label><input type="text" name="address" value="<%=address%>" style="color:#bdbdbd"/>
		</div>
		<div class="txt-style">
			<label>주소2: </label><input type="text" name="address2" value="<%=address2%>" style="color:#bdbdbd"/>
		</div>
	</div>
</div>
<input type="submit" class="submit" style="width:30%;height:38px;font-size:0.9em" value="수정">
</form>
</div>
</body>
</html>