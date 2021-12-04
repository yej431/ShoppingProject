<%@page import="entity.CategoryEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="productHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%	
Connection con = ConnectionProvider.getCon();
Statement st = con.createStatement();

int productId=Integer.parseInt(request.getParameter("productId"));
String productName=request.getParameter("productName");
int price=Integer.parseInt(request.getParameter("price"));
String file=request.getParameter("file");

List<CategoryEntity> categoryList = new ArrayList<CategoryEntity>();

String sql="select * from category";
ResultSet rs=st.executeQuery(sql);
while(rs.next()){
	String main=rs.getString("main");
	String sub1=rs.getString("sub1");	
	String sub2=rs.getString("sub2");	
	String sub3=rs.getString("sub3");	
	String sub4=rs.getString("sub4");	
	
	CategoryEntity category = new CategoryEntity();
	category.setMain(main);
	category.setSub1(sub1);
	category.setSub2(sub2);
	category.setSub3(sub3);
	category.setSub4(sub4);
	
	categoryList.add(category);	
	request.setAttribute("categoryList",categoryList);
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
    <script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>

<div class="wrap">
<form action="../EditProductServlet" method="post" enctype="multipart/form-data">
<div id="add-product">
	<input type="hidden" name="productId" value="<%=productId%>">
	<div class="txt-style">
		<label>상품 이름: </label>
		<input class="input-style" type="text" name="name" value="<%=productName%>" required> 
	</div>
	<div class="txt-style">
		<label>카테고리: </label>
		
		<div class="category-select">
		<select class="input-style" id="main" name="main">
			<option value="">선택: </option>
			<c:forEach var="c" items="${categoryList}">
				<option value="${c.main}">${c.main}</option>
			</c:forEach>
		</select>
		<select id="sub" name="sub"></select>
		</div>
		
	</div>
	<div class="txt-style">
		<label>상품 가격</label>
		<input class="input-style" type="text" name="price" value="<%=price%>" required> 
	</div>
	<div class="txt-style">
		<label>상태</label>
		<div class="status-select">
			<select class="input-style" name="active">
				<option value="판매가능">판매가능</option>
				<option value="품절">품절</option>
			</select>   
		</div>
	</div>
	<div class="txt-style">
		<label>상품 수량: </label>
		<input class="input-style" type="text" name="quantity" placeholder="상품수량 입력" required> 
	</div>
	<div class="txt-style">
		<label>현재 파일: </label>
		<img src="../upload/<%=file%>" style="width:100px;">
	</div>
	<div class="txt-style">
		<label>파일 선택: </label>
		<input type="file" name="file">		
	</div>
	<button type="submit" class="btn" onclick="return confirm('정말 수정하시겠습니까?')">수정</button>
</div>
</form>
</div>

<script>
$(document).ready(function(){
	$("#main").on("change", function(){
		var main=$("#main").val();
		
		$.ajax({
			method:'POST',
			url:'../GetSubServlet',
			data:{
				main : main
			},
			success: function(data){
				$("#sub").html(data);
			}
		})
	})
})
</script>
</body>
</html>