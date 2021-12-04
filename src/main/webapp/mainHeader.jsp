<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.CategoryEntity"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.sql.*"%>
<%@page import="controller.ConnectionProvider"%>
<%
List<CategoryEntity> categoryList2 = new ArrayList<CategoryEntity>();
Connection con = ConnectionProvider.getCon();
Statement st=con.createStatement();

String sql2="select * from category";
ResultSet rs2=st.executeQuery(sql2);
while(rs2.next()){
	int id=rs2.getInt("id");
	String main=rs2.getString("main");
	String sub1=rs2.getString("sub1");	
	String sub2=rs2.getString("sub2");	
	String sub3=rs2.getString("sub3");	
	String sub4=rs2.getString("sub4");	
	
	CategoryEntity category = new CategoryEntity(id,main,sub1,sub2,sub3,sub4);
	
	categoryList2.add(category);	
	request.setAttribute("categoryList2",categoryList2);
}
%>
<c:choose>
<c:when test="${userid=='관리자'}">
<%@ include file="admin/adminMainHeader.jsp" %>
</c:when>
        
<c:otherwise>
<header>
    <div class="header-wrapper" id="header-wrapper">   
		<div class="bg-main">
            <div class="mid-header wrap">
                <a href="main.jsp" class="logo">쇼핑is</a>
                <form action="search.jsp" method="get">
                <div class="search">
                    <input type="text" name="search" placeholder="Search">
                    <button type="submit"><i class="bx bx-search-alt"></i></button>
                </div>
                </form>
                <ul class="user-menu">  
					<c:if test="${userid==null}">
						<a style="font-size:16px; padding-top:10px;padding-right:10px;" href="login.jsp">로그인</a>
						<a style="font-size:16px; padding-top:10px" href="signup.jsp">회원가입</a>
					</c:if>
					<c:if test="${userid != null}">
						<li class="n-list">
						<a style="font-size:16px; padding-top:10px" href="#">${userid}님</a>
						<ul class="drop-down">
	                		<li><a href="userInfo.jsp">마이페이지</a></li>
	                	</ul>  
	                	</li>  
	                	<li><a href="./LogoutServlet" style="font-size:16px; padding-top:10px">로그아웃<i class='bx bx-log-out-circle'></i></a></li> 
                    	<li><a href="cart.jsp"><i class="bx bx-cart"></i></a></li>
            		</c:if>   
                </ul>
            </div>
        </div>        
        <div class="bg-second">
            <div class="bottom-header wrap">
                <ul class="main-menu">
                    <li><a href="main.jsp">home</a></li>
                    <li class="mega-dropdown"> 
                        <a href="#">카테고리<i class="bx bxs-chevron-down"></i></a>
                        <div class="mega-content">
							<div class="row">
							<c:forEach var="c" items="${categoryList2}">
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
                    <li><a href="#">베스트</a></li>
                    <li><a href="#">신상품</a></li>
                </ul>
            </div>            
        </div>
    </div>
</header>
</c:otherwise>
</c:choose>
