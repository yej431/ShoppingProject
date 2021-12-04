<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@page import="java.sql.*"%>
<%@ include file="footer.jsp" %>
<%
	String msg=request.getParameter("msg");
	if("done".equals(msg)){
%>   
<script>
	alert('비밀번호가 변경되었습니다');
</script>
<%
	}
	if("invalid".equals(msg)){
%>
<script>
	alert('다시 시도해주세요');
</script>
<%
	}
%>
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
    <script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="wrap">
<div style="margin:45px auto;" id="find-password">
<h1>비밀번호 찾기</h1>
<form action="./FindPassword" method="post">	
	<div class="txt_field">
		<span>아이디</span>	
		<input type="text" name="userid" required>							
	</div>
	<div class="txt_field">
		<span>비밀번호 찾기 질문</span><br><br>
		<select name="security-question" required>				
			<option value="당신이 가장 좋아하는 색은?">당신이 가장 좋아하는 색은?</option>
			<option value="당신의 첫번째 애완동물 이름은?">당신의 첫번째 애완동물 이름은?</option>
			<option value="당신의 초등학교 이름은?">당신의 초등학교 이름은?</option>
			<option value="당신의 보물1호는?">당신의 보물1호는?</option>
	</select>
	<input type="text" name="answer" placeholder="답을 입력하세요." required>
	</div>
	<div class="txt_field">
		<span>새 비밀번호 입력</span><br><br>
		<input type="password" name="new-password" placeholder="새로운 비밀번호를 입력하세요." required>		
	</div>	
	<input type="submit" class="submit" value="저장">	
</form>
<div class="a-style"><a href="login.jsp" class="a-style">Login</a></div>
</div>
<div>
</div>
</div>
</body>
</html>