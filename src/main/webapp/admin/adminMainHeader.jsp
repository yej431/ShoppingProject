<%@page import="java.util.ArrayList"%>
<%@page import="entity.CategoryEntity"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>
<%
List<CategoryEntity> categoryList = new ArrayList<CategoryEntity>();
Connection con2 = ConnectionProvider.getCon();
Statement st2=con2.createStatement();

String sql="select * from category";
ResultSet rs=st2.executeQuery(sql);
while(rs.next()){
	int id=rs.getInt("id");
	String main=rs.getString("main");
	String sub1=rs.getString("sub1");	
	String sub2=rs.getString("sub2");	
	String sub3=rs.getString("sub3");	
	String sub4=rs.getString("sub4");	
	
	CategoryEntity category = new CategoryEntity(id,main,sub1,sub2,sub3,sub4);
	
	categoryList.add(category);	
	request.setAttribute("categoryList",categoryList);
}
%>
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
                <a href="/ShoppingProject/admin/adminMain.jsp" class="logo">쇼핑is</a>
                <form action="/ShoppingProject/search.jsp" method="get">
                <div class="search">
                    <input type="text" name="search" placeholder="Search">
                    <button type="submit"><i class="bx bx-search-alt"></i></button>
                </div>
                </form>
                <ul class="user-menu">
                	<li>
                		<a href="/ShoppingProject/admin/adminMain.jsp" style="font-size:16px; padding-top:10px;">${userid}님</a>            
                	</li>
                    <li>
                    	<a href="/ShoppingProject/LogoutServlet" style="font-size:16px; padding-top:10px">로그아웃<i class='bx bx-log-out-circle'></i></a>
                    </li> 
                </ul>
            </div>
        </div>      
        <div class="bg-second">
            <div class="bottom-header wrap">
                <ul class="main-menu">
                    <li><a href="/ShoppingProject/admin/adminMain.jsp">home</a></li>
                    <li class="mega-dropdown"> 
                        <a href="/ShoppingProject/admin/adminMain.jsp">카테고리<i class="bx bxs-chevron-down"></i></a>
                        <div class="mega-content">
							<div class="row">
							<c:forEach var="c" items="${categoryList}">
								<div class="col-3">
								<div class="box">
									<h3>${c.main}</h3>
									<ul>
										<li>
											<a href="/ShoppingProject/category.jsp?main=${c.main}&sub=${c.sub1}">${c.sub1}</a>
										</li>
										<li>
											<a href="/ShoppingProject/category.jsp?main=${c.main}&sub=${c.sub2}">${c.sub2}</a>
										</li>
										<li>
											<a href="/ShoppingProject/category.jsp?main=${c.main}&sub=${c.sub3}">${c.sub3}</a>
										</li>
										<li>
											<a href="/ShoppingProject/category.jsp?main=${c.main}&sub=${c.sub4}">${c.sub4}</a>
										</li>
									</ul>
								</div>                                        
	                            </div> 
							</c:forEach>                            
                            </div>
                        </div>
                    </li>
                    <li><a href="/ShoppingProject/admin/addCategory.jsp">카테고리 관리</a></li>                    
                    <li><a href="/ShoppingProject/admin/addProduct.jsp">상품관리</a></li>
                    <li><a href="/ShoppingProject/admin/orderList.jsp">주문관리</a></li>
                    <li><a href="/ShoppingProject/admin/salesManage.jsp">매출현황</a></li>
                    <li><a href="/ShoppingProject/admin/addSlide.jsp">파일등록</a></li>
                </ul>
            </div>            
        </div>
    </div>
</header>
