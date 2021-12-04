<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@page import="entity.MainSlideEntity"%>
<%@page import="entity.OrderEntity"%>
<%@page import="entity.ProductEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
List<ProductEntity> productList = new ArrayList<ProductEntity>();
List<OrderEntity> orderList = new ArrayList<OrderEntity>();
List<MainSlideEntity> slideList = new ArrayList<MainSlideEntity>();
PreparedStatement ps = null;

String sql1="select * from mainslide";
ResultSet rs1=st.executeQuery(sql1);
while(rs1.next()){
	String file=rs1.getString("file");
	
	MainSlideEntity slide = new MainSlideEntity();
	slide.setFile(file);
	
	slideList.add(slide);	
	request.setAttribute("slideList",slideList);
}

String sqlO="select p.id, p.subCategory, o.productName, count(o.productName) cnt, p.file from orders as o" 
	+" inner join product as p on o.productId=p.id group by o.productName order by cnt desc limit 3";
ResultSet rsO=st.executeQuery(sqlO);
while(rsO.next()){
	int productId=rsO.getInt("id");
	String subCategory=rsO.getString("subCategory");
	String productName=rsO.getString("productName");
	String file=rsO.getString("file"); 
		
	OrderEntity order = new OrderEntity();
	order.setProductId(productId);
	order.setSubCategory(subCategory);
	order.setProductName(productName);	
	order.setFile(file);	
		
	orderList.add(order);	
	request.setAttribute("orderList",orderList);
}

String sqlP="select * from product order by id desc limit 3";
ResultSet rs3=st.executeQuery(sqlP);
while(rs3.next()){
	int productId=rs3.getInt("id");
	String subCategory=rs3.getString("subCategory");
	String productName=rs3.getString("name");
	String file=rs3.getString("file"); 	
	
	ProductEntity product = new ProductEntity();
	product.setProductId(productId);	
	product.setSubCategory(subCategory);
	product.setProductName(productName);	
	product.setFile(file);	
	
	productList.add(product);	
	request.setAttribute("productList",productList);
}
%>
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
</head>
<body>
<div class="wrap">
<div style="margin:40px 0;">

<!-- mainSlide -->
<div style="overflow:hidden;">
<div class="mainSlide">
	<c:forEach var="s" items="${slideList}">
		<div class="inner"><img src="./upload/${s.file}"></div>
	</c:forEach>
</div>
</div>
<div class="slideButton">
	<button class="button1"></button>
	<button class="button2"></button>
	<button class="button3"></button>
</div>

<!-- best product -->
<div class="best-top clearfix">
<div class="title"><span>BEST PRODUCT</span></div>
<c:forEach var="o" items="${orderList}">
<div class="best-latest clearfix">
	<div class="latest-best-box">
		<div class="text">
			<h3>${o.productName}</h3>
			 <button class="btn-flat btn-hover" 
			 	onclick="location.href='./productInfo.jsp?idPro=${o.productId}&sub=${o.subCategory}'">
			 	<span>자세히 보기</span>
			 </button>
		</div>
		<img src="./upload/${o.file}" alt=""/>
	</div>
</div>
</c:forEach>
</div>

<!-- latest product -->
<div class="latest-top clearfix">
<div class="title"><span>LATEST PRODUCT</span></div>
<c:forEach var="p" items="${productList}">
<div class="best-latest clearfix">
	<div class="latest-best-box">
		<div class="text">
			<h3>${p.productName}</h3>
			 <button class="btn-flat btn-hover"
			 	onclick="location.href='./productInfo.jsp?idPro=${p.productId}&sub=${p.subCategory}'">
			 	<span>자세히 보기</span>
			 </button>
		</div>
		<img src="./upload/${p.file}" alt="">
	</div>
</div>
</c:forEach>
</div>
</div>
</div>

<script>
document.querySelector('.button2').addEventListener('click', function(){
	document.querySelector('.mainSlide').style.transform = 'translate(-1366px)';
});
	
document.querySelector('.button3').addEventListener('click', function(){
	document.querySelector('.mainSlide').style.transform = 'translate(-2732px)';
});
	
document.querySelector('.button1').addEventListener('click', function(){
	document.querySelector('.mainSlide').style.transform = 'translate(0)';
});
</script>
</body>
</html>