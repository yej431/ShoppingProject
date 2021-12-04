<%@page import="entity.ProductEntity"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@include file="footer.jsp" %>
<%@page import="java.sql.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="mainHeader.jsp" %>
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
</head>
<body>
<div class="wrap">
<%
String search=request.getParameter("search");
PreparedStatement ps = null;

int unit=5;

String p=request.getParameter("p");
if(p==null){
	p="1";
}
int v_page=Integer.parseInt(p);
int index_no=(v_page-1)*unit;

String sql="select count(*) total from product where name like '%"+search+"%'";		
rs2=st.executeQuery(sql);
rs2.next();
int total=rs2.getInt("total");

int lastpage=(int)Math.ceil((double)total/5);

String sql3 = "select * from product where name like '%"+search+"%' order by id desc limit "+index_no+","+unit;	
ps=con.prepareStatement(sql3);
rs2=ps.executeQuery();
while(rs2.next()) {
	int productId=rs2.getInt("id");
	String productName=rs2.getString("name");
	String main=rs2.getString("mainCategory");
	String sub=rs2.getString("subCategory");
	int price=rs2.getInt("price");
	int quantity=rs2.getInt("quantity");
	String active=rs2.getString("active");
	String file=rs2.getString("file");
%>
<div class="clearfix" style="margin:40px 0">
<div style="padding:0 100px">
<div style="float:left;"><img src="./upload/<%=file%>" width="100px"></div>
<div style="float:left; margin-left:100px;margin-top:10px;">
	<div><a style="font-size:1em;font-weight:bold" href="productInfo.jsp?idPro=<%=productId%>&sub=<%=sub%>">
		<%=productName%></a>
	</div>
	<div style="font-size:0.7em;margin-top:5px;"><label><%=main%> > <%=sub%></label></div><br>
	<div><label style="font-size:1em;color:#c0392b"><fmt:formatNumber value="<%=price%>"/>원</label></div>
</div>
</div>
</div>
<%
}
%>
<c:set var="page" value="${(empty param.p)? 1:param.p}"/>
<c:set var="startNum" value="${page-(page-1)%5}"/>
<c:set var="lastNum" value="<%=lastpage%>"/>
<div class="board-number">
	<div class="prev">
		<c:if test="${startNum>1}">
			<a href="?p=${startNum-1}&t=&q=">이전</a>
		</c:if>
		<c:if test="${startNum<=1}">
			<span onclick="alert('이전 페이지가 없습니다.');">이전</span>
		</c:if>
	</div>		
	<ul class="number">
		<c:forEach var="i" begin="0" end="4">
		<c:if test="${(startNum+i) <= lastNum}">
			<li><a style="${(page==(startNum+i))?'color:#c0392b':''}" 
				href="search.jsp?p=${startNum+i}&search=<%=search%>">${startNum+i}</a></li>
		</c:if>
		</c:forEach>	
	</ul>
	<div class="next">
		<c:if test="${startNum+4<lastNum}">
			<a href="?p=${startNum+5}">다음</a>
		</c:if>
		<c:if test="${startNum+4>=lastNum}">
			<span onclick="alert('다음 페이지가 없습니다.');">다음</span>
		</c:if>
	</div>
</div>
</div>
</body>
</html>