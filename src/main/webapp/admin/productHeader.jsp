<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>
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
<header>
    <div class="header-wrapper" id="header-wrapper">
        <div class="bg-main">
            <div class="mid-header wrap">
                <a href="adminMain.jsp" class="logo">쇼핑is</a>
                <form action="/ShoppingProject/search.jsp" method="get">
                <div class="search">
                    <input type="text" name="search" placeholder="Search">
                    <button type="submit"><i class="bx bx-search-alt"></i></button>
                </div>
                </form>
                <ul class="user-menu">
                	<li>
                		<a href="login.jsp" style="font-size:16px; padding-top:10px;">${userid} 님</a>            
                	</li>
                    <li>
                    	<a href="/ShoppingProject/LogoutServlet" style="font-size:16px; padding-top:10px">로그아웃<i class='bx bx-log-out-circle'></i></a>
                    </li> 
                </ul>
            </div>
        </div>      
        <div class="bg-second">
            <div class="bottom-header container">
                <ul class="main-menu">
                    <li><a href="adminMain.jsp">home</a></li>                    
                    <li><a href="addProduct.jsp">상품 등록</a></li>
                    <li><a href="productList.jsp">상품 목록</a></li>
                </ul>
            </div>            
        </div>
    </div>
</header>