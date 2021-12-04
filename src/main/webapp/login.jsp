<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑is - 로그인</title>
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
<div id="login-form">
	<h1>로그인</h1>
	<%
		String msg=request.getParameter("msg");
		if("notexist".equals(msg)){
	%>  
	<div style="text-align:center; font-size:16px; color:red;margin:20px auto -10px;">아이디 또는 비밀번호가 틀렸습니다.</div>
	<%
		}
		if("invalid".equals(msg)){
	%>
	<div style="text-align:center; font-size:16px; color:red;margin:20px auto -10px;">다시 시도하세요.</div>
	<%
		}
	%>
	<form action="./LoginServlet" method="post">
		<div class="txt_field">
			<input type="text" name="userid" required>
			<span></span>
			<label>아이디</label>
		</div>
		<div class="txt_field">
			<input type="password" name="password" required>
			<span></span>
			<label>비밀번호</label>
		</div>
		<input type="submit" class="submit" value="로그인">
	</form>
	<div class="a-style"><a href="findPassword.jsp">비밀번호 찾기</a></div>	
	<div class="a-style">
		<a href="signup.jsp">회원가입</a>
	</div>	
</div>
</div>
</body>
</html>