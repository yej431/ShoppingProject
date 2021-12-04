<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@page import="java.sql.*"%>
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
    <script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="wrap">
<div style="margin:45px auto;">
<div class="signup-form">
	<h1>회원가입</h1>
	<%
		String messageContent=null;
		if(session.getAttribute("messageContent") != null){
			messageContent=(String)session.getAttribute("messageContent");
		}
		String messageType=null;
		if(session.getAttribute("messageType") != null){
			messageType=(String)session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
	<div class="warning">
	<%if(messageType.equals("오류 메시지"));%>
		<div class="body">
			<%=messageContent %>
		</div>
	</div>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messateType");
		}
	%>
	<form action="./UserRegisterServlet" method="post">
		<div class="txt_field">
			<span>아이디</span>	
			<input type="text" name="userid" required>							
		</div>
		<span id="ck"></span>	
		<div class="txt_field">
			<span>이름</span>
			<input type="text" name="name" required>			
		</div>
		<div class="txt_field">
			<span>이메일</span>
			<input type="email" name="email" required>			
		</div>
		<div style="position:relative;border-bottom: 2px solid #adadad;">
			<span>전화번호</span>
			<div style="margin:10px 0 20px;">
			<input type="text" name="number1" size="3" maxlength="3" required> -	
			<input type="text" name="number2" size="4" maxlength="4" required> -	
			<input type="text" name="number3" size="4" maxlength="4" required>
			</div>
		</div>
		<div class="txt_field">
			<span>주소1</span>
			<input type="text" name="address" required>			
		</div>
		<div class="txt_field">
			<span>주소2</span>
			<input type="text" name="address2" required>			
		</div>
		<div class="txt_field">
			<span>비밀번호 찾기 질문</span><br><br>
			<select name="securityquestion" required>				
				<option value="당신이 가장 좋아하는 색은?">당신이 가장 좋아하는 색은?</option>
				<option value="당신의 첫번째 애완동물 이름은?">당신의 첫번째 애완동물 이름은?</option>
				<option value="당신의 초등학교 이름은?">당신의 초등학교 이름은?</option>
				<option value="당신의 보물1호는?">당신의 보물1호는?</option>
			</select>
			<input type="text" name="answer" placeholder="답을 입력하세요." required>
		</div>
		<div class="txt_field">
			<span>비밀번호</span>
			<input type="password" name="password" id="password" onkeyup="passwordCheckFunction();" required>			
		</div>
		<div class="txt_field">
			<span>비밀번호 확인</span>
			<input type="password" name="password2" id="password2" onkeyup="passwordCheckFunction();" required>			
		</div>	
		<div style="color:red; font-size:16px; ">
			<h5 id="passwordCheckMessage"></h5>	
		</div>			
		<input type="submit" class="submit" style="margin-bottom:30px;" value="등록">	
	</form>
</div>
</div>
</div>

<script>
function passwordCheckFunction(){
	var password=$('#password').val();
	var password2=$('#password2').val();
	if(password != password2){
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	}else{
		$('#passwordCheckMessage').html('')
	}
}
</script>
</body>
</html>