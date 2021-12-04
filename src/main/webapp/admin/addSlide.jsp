<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="mainScreenHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="controller.ConnectionProvider"%>
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
    <style>
    	#slide > div{
    		padding:20px;
    		border-bottom:1px solid #ccc;
    	}
    	#slide > div label{
    		font-size:1em; font-weight:bold;
    		padding-right:15px;
    	}
    </style>
</head>
<body>
<div class="wrap">
<div style="margin:40px 0">
<form action="../AddSlideServlet" method="post" enctype="multipart/form-data">
<div id="slide">
	<div>
		<label>파일 등록:</label>
		<input type="file" name="file">		
	</div>
</div>
<div style="padding:10px 0 0 18px;">이미지 크기: 1366px x 414px</div>
	<input type="submit"class="submit" value="저장">
</form>
</div>
</div>
</body>
</html>