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
Connection con=ConnectionProvider.getCon();
String userid = (String)session.getAttribute("userid");
try{
	Statement st=con.createStatement();
	ResultSet rs = st.executeQuery("select * from user where userid='"+userid+"'");
	if(rs.next()){
%>
<div id="txt-wrap">
	<div class="txt-inner">
		<div class="txt-style">
			<label>아이디: </label><%=rs.getString("userid")%>
		</div>
		<div class="txt-style">
			<label>이름: </label><%=rs.getString("name")%>
		</div>
		<div class="txt-style">
			<label>이메일: </label><%=rs.getString("email")%>
		</div>
		<div class="txt-style">
			<label>전화번호: </label><%=rs.getString("mobileNumber")%>
		</div>
		<div class="txt-style">
			<label>주소: </label><%=rs.getString("address")%>
		</div>
		<div class="txt-style">
			<label>주소2: </label><%=rs.getString("address2")%>
		</div>
	</div>
	<a href="editInfo.jsp?id=<%=rs.getString("userid")%>&name=<%=rs.getString("name")%>
		&email=<%=rs.getString("email")%>&phone=<%=rs.getString("mobileNumber")%>
		&address=<%=rs.getString("address")%>&address2=<%=rs.getString("address2")%>" 
		style="font-size:15px;float:right;margin-top:20px;display:block;color:var(--red)"class="clearfix">수정하기</a>
</div>
<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
</div>
</body>
</html>