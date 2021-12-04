<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String userid = (String)session.getAttribute("userid");
	Statement st2=con.createStatement();

	String idB=request.getParameter("idB");
	String idPro=request.getParameter("idPro");
	String sub=request.getParameter("sub");
	if(idB==null || idB.equals("")){
%>
<script>
	alert("잘못된 경로로의 접근!!");
	location="history.back();";
</script>
<%
	return;
	}
	String sqlB="select title,userid,content from board where id='"+idB+"'";
	ResultSet rsB=st2.executeQuery(sqlB);
	
	String title="";
	String user="";
	String content="";
	if(rsB.next()){
		title=rsB.getString("title");
		user=rsB.getString("userid");
		content=rsB.getString("content");
	}else{
%>
<script>
		alert("잘못된 접근입니다.");
		location="history.back();";
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
<div class="wrap">
<div style="margin-top:20px;">
<form action="./BoardModifyServlet" method="post" enctype="multipart/form-data">
	<input type="hidden" name="idPro" value="<%=idPro%>"/>
	<input type="hidden" name="idB" value="<%=idB%>"/>
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