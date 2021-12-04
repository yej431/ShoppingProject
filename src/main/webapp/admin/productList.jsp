<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="productHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<%@page import="controller.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑is - 상품목록</title>
</head>
<body>
<div class="wrap">
<div style="margin:45px auto;">
<%	
Connection con = ConnectionProvider.getCon();
Statement st = con.createStatement();
PreparedStatement ps = null;

int unit=7;

String p=request.getParameter("p");
if(p==null){
	p="1";
}
int v_page=Integer.parseInt(p);
int index_no=(v_page-1)*unit;


%>
<div class="clearfix" style="background:#f5f5f5;padding:10px 0">
<form>
<div style="float:left;">
<span style="margin-right:30px;vertical-align:middle;padding-left:10px;">상품검색</span>
	<select name="key" style="height:30px;width:120px;">
  		<option ${(param.key=="subCategory")?"selected":""} value="subCategory">카테고리</option>
  		<option ${(param.key=="name")?"selected":""} value="name">상품명</option>
  		<option ${(param.key=="price")?"selected":""} value="price">가격</option>
  		<option ${(param.key=="quantity")?"selected":""} value="quantity">수량</option>
  		<option ${(param.key=="atcive")?"selected":""} value="atcive">상태</option>
  	</select>
    <input type="search" placeholder="Search" name="word" value="${param.word}" style="height:30px;width:250px;"/>
</div>
<button style="margin-left:5px; height:30px;width:40px;" type="submit">검색</button>
</form>
</div>
<table>
<tr>
	<th>상품번호</th>
	<th>이미지</th>	
	<th>카테고리</th>
	<th>상품명</th>
	<th>가격</th>
	<th>수량</th>
	<th>상태</th>
	<th>수정</th>
	<th>삭제</th>
</tr>
<%
String key=request.getParameter("key");
String word=request.getParameter("word");
String data;
if(word != null && !word.equals("")){
	String sqlTot="select count(*) total from product where "+key+" like '%"+word+"%'";	
	ResultSet rsTot=st.executeQuery(sqlTot);
	rsTot.next();
	int total=rsTot.getInt("total");
	int lastpage=(int)Math.ceil((double)total/7);
	
	data="select * from product where "+key+" like '%"+word+"%' order by id desc limit "+index_no+","+unit;	
	
	request.setAttribute("lastpage",lastpage);
}else{
	String sqlTot="select count(*) total from product";	
	ResultSet rsTot=st.executeQuery(sqlTot);
	rsTot.next();
	int total=rsTot.getInt("total");
	int lastpage=(int)Math.ceil((double)total/7);
	
	data = "select * from product order by id desc limit "+index_no+","+unit;
	
	request.setAttribute("lastpage",lastpage);
}
ResultSet rsPro=st.executeQuery(data);
while(rsPro.next()) {
	int productId=rsPro.getInt("id");
	String productName=rsPro.getString("name");
	String mainCategory=rsPro.getString("mainCategory");
	String subCategory=rsPro.getString("subCategory");
	int price=rsPro.getInt("price");
	int quantity=rsPro.getInt("quantity");
	String active=rsPro.getString("active");
	String file=rsPro.getString("file");
%>
<tr>	
	<td style="width:10%"><%=productId%></td>
	<td style="width:16.25%"><img src="../upload/<%=file%>" onerror="this.style.display='none'" alt=""/></td>
	<td style="width:16.25%"><%=mainCategory%> > <%=subCategory%></td>
	<td style="width:16.25%"><%=productName%></td>
	<td style="width:10%"><fmt:formatNumber value="<%=price%>"/></td>
	<td style="width:5%"><%=quantity%></td>
	<td style="width:16.25%"><%=active%></td>
	<td style="width:5%"><a href="editProduct.jsp?productId=<%=productId%>&productName=<%=productName%>&file=<%=file%>
		&mainCategory=<%=mainCategory%>&subCategory=<%=subCategory%>&price=<%=price%>">수정</a></td>
	<td style="width:5%"><a href="../DeleteProductServlet?productId=<%=productId%>" 
		onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
</tr>
<%
}
%>
</table>
<c:set var="page" value="${(empty param.p)? 1:param.p}"/>
<c:set var="startNum" value="${page-(page-1)%5}"/>
<c:set var="lastNum" value="${lastpage}"/>
<div class="board-number">
	<div class="prev">
		<c:if test="${startNum>1}">
			<a href="productList.jsp?p=${startNum-1}&t=&q=">이전</a>
		</c:if>
		<c:if test="${startNum<=1}">
			<span onclick="alert('이전 페이지가 없습니다.');">이전</span>
		</c:if>
	</div>		
	<ul class="number">
		<c:forEach var="i" begin="0" end="4">
		<c:if test="${(startNum+i) <= lastNum}">
			<li><a style="${(page==(startNum+i))?'color:#c0392b':''}" 
				href="productList.jsp?p=${startNum+i}&word=${param.word}&key=${param.key}">${startNum+i}</a></li>
		</c:if>
		</c:forEach>	
	</ul>
	<div class="next">
		<c:if test="${startNum+4<lastNum}">
			<a href="productList.jsp?p=${startNum+5}">다음</a>
		</c:if>
		<c:if test="${startNum+4>=lastNum}">
			<span onclick="alert('다음 페이지가 없습니다.');">다음</span>
		</c:if>
	</div>
</div>
</div>
</div>
</body>
</html>