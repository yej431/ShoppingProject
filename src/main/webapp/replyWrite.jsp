<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@include file="mainHeader.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>
<%
if(session.getAttribute("userid") == null){
%>
<script>
	alert("로그인해주세요.");
	history.back();
</script>
<%
}else{
	String userid = (String)session.getAttribute("userid");
	String id = request.getParameter("idB");
	String idPro = request.getParameter("idPro");
	String sub = request.getParameter("sub");
	if(id == null){
%>
<script>
	alert("잘못된 경로로의 접근!!");
	history.back();
</script>
<%
	return;
	}
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
<br>
<div class="wrap">
<form action="replyWriteSave.jsp" method="post">
	<input type="hidden" name="id" value="<%=id%>"/>
	<input type="hidden" name="userid" value="<%=userid%>"/>
	<input type="hidden" name="idPro" value="<%=idPro%>"/>
	<input type="hidden" name="sub" value="<%=sub%>"/>
	Re: <input type="text" name="title" maxlength="50"><br>
	작성자: <%=userid%><br>
	첨부파일: <input type="file" name="files"><br><br>
	<textarea name="content" maxlength="2048" style="width:100%;height:350px;"></textarea><br><br>
	<input type="submit" value="저장">
</form>
<div class="margin-top text-align-center">
	<a class="btn btn-list" href="productInfo.jsp">목록</a>
</div>
</div>
<%
}
%>
<%@ include file="footer.jsp" %>
</body>
</html>