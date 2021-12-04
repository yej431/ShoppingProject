<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>
<%
String userid = (String)session.getAttribute("userid");
String idPro = request.getParameter("idPro");
String sub = request.getParameter("sub");
%>
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
    <link rel="stylesheet" href="./css/grid.css">
    <link rel="stylesheet" href="./css/user-style.css">
</head>
<body>
<%
	if(userid == null) {
%>
	<script>
		alert("로그인 해주세요.")
		history.back();
	</script>
<%
	}
%>
<div class="wrap">
<div style="margin-top:20px;">
<form action="./BoardWriteServlet" method="post" enctype="multipart/form-data">
	<input type="hidden" name="idPro" value="<%=idPro%>"/>
	<input type="hidden" name="sub" value="<%=sub%>"/>
	제목: <input type="text" name="title"><br>
	작성자 <%=userid%><br>
	첨부파일: <input type="file" name="file"><br>
	내용: <textarea style="width:100%;height:50%;" name="content"></textarea><br>
	<input type="submit" class="submit" value="저장">
</form>
</div>
<div class="clearfix" style="float:right;margin-top:40px;">
	<a style="font-size:1em;" href="/ShoppingProject/productInfo.jsp?idPro=<%=idPro%>&sub=<%=sub%>">목록</a>
</div>
</div>
</body>
</html>