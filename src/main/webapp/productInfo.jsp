<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="controller.ConnectionProvider"%>
<%@ include file="mainHeader.jsp" %>
<%@ include file="footer.jsp" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<div id="p-info">
<%	
	int quantity=1;

	String idPro=request.getParameter("idPro");
	String sub=request.getParameter("sub");	
	
	String sqlPro="select max(price) total,id,name,price,active,file from product where active='판매가능' and id='"+idPro+"'";
	ResultSet rsPro=st.executeQuery(sqlPro);
	rsPro.next(); 	
	String name=rsPro.getString("name");
	int price=rsPro.getInt("price");
	String active=rsPro.getString("active");
	String file=rsPro.getString("file");
	int total=rsPro.getInt("total");
%>
<div class="p-info-top clearfix" style="padding-top:40px;">		
	<input type="hidden" name="idPro" id="idPro" value="<%=idPro%>">
	<input type="hidden" name="userid" id="userid" value="${userid}">
	<input type="hidden" name="file" id="file" value="<%=file%>">
	<input type="hidden" name="idPro" id="idPro" value="<%=idPro%>">
	<input type="hidden" name="productName" id="productName" value="<%=name%>">
	<input type="hidden" name="productPrice" id="productPrice" value="<%=price%>">
	<div>
		<img src="./upload/<%=file%>" style="width:300px;float:left">
	</div>
	<div style="float:left;margin:15px 0 0 500px;">
		<h1><%=name%></h1><br>	
		<div><span style="color:#c0392b;font-size:1.5em">가격: <fmt:formatNumber value="<%=price%>"/>원</span></div>
		<div style="margin:40px 0;">
			<button type=button id="minus"><i class='bx bxs-minus-circle'></i></button>
				<input type="number" name="numBox" id="numBox" value="1" readonly="readonly">
			<button type=button id="plus"><i class='bx bxs-plus-circle'></i></button> 
		</div>
		<div>
			<div style="margin-bottom:5px">
				<input type="number" name="totalBox" id="totalBox" value="<%=total%>" readonly="readonly">
			</div>
			<button type="submit" id="addCart">장바구니로 이동</button>
		</div>
	</div>
</div>
<div class="p-info-middle">
	<div class="p-detail">
		<label>내용</label>
	</div>
</div>
<%	
	int unit=6;

	String p=request.getParameter("p");
	if(p==null){
		p="1";
	}
	int v_page=Integer.parseInt(p);
	int index_no=(v_page-1)*unit;

	String sqlTot="select count(*) total2 from board where productId='"+idPro+"'";	
	ResultSet rsTot=st.executeQuery(sqlTot);
	rsTot.next();
	int total2=rsTot.getInt("total2");
	int rownumber=total2-index_no;	
	
	int lastpage=(int)Math.ceil((double)total2/6);
	
	request.setAttribute("total2",total2);
	
	String sqlB = "select id,userid,title,content,regdate,hit,gid,thread from board where productId='"+idPro
			+"' order by gid desc, thread asc limit "+index_no+","+unit;
	ResultSet rsB = st.executeQuery(sqlB);
%>
<div class="p-info-bottom">
<div class="board">
	<div class="notice margin-top">
		<div class="clearfix">
			<span style="font-size:18px;font-weight:bold;">문의사항</span>
			<span style="font-size:14px;padding-left:20px;">전체 목록 개수: 총 <%=total2%>개</span>
			<span style="float:right;">
			<button type="button" style="width:70px; height:28px;" 
				onclick="location.href='boardWrite.jsp?idPro=<%=idPro%>&sub=<%=sub%>'">글쓰기</button>
			</span>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th width="10%">번호</th>
					<th width="50%">제목</th>
					<th width="15%">작성자</th>
					<th width="15%">작성일</th>
					<th width="10%">조회수</th>
				</tr>
			</thead>
			<tbody>		
<%
	while(rsB.next()){
		int idB=rsB.getInt("id");
		String title=rsB.getString("title");
		String user=rsB.getString("userid");
		String rdate=rsB.getString("regdate");
		int hit=rsB.getInt("hit");
		String thread=rsB.getString("thread");
		int len = thread.length();
		String re="";
		if(len > 1) re="[re]";			
%>
		<tr>
			<td><%=rownumber%></td>
			<td>
<%
			for(int i=1; i<len; i++){
				out.print("&nbsp;&nbsp;");
%>
			<%=re%>
<%
			}
%>
			<a href="/ShoppingProject/boardDetail.jsp?idB=<%=idB%>&idPro=<%=idPro%>&sub=<%=sub%>"><%=title%></a>
			</td>
			<td><%=user%></td>
			<td><%=rdate%></td>
			<td><%=hit%></td>
		</tr>	
<%
	rownumber--;
	}
%>			
		</tbody>
	</table>		
	</div>
	
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
					href="productInfo.jsp?p=${startNum+i}&idPro=<%=idPro%>&sub=<%=sub%>">${startNum+i}</a></li>
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
</div>
</div>
</div>

<script>
$('#plus').click(function(){
	var num=$('#numBox').val();
	var totalNum=$('#totalBox').val();
	var plus = Number(num)+1;
	var totalPlus= Number(totalNum)+Number(<%=price%>);
	$('#numBox').val(plus);
	$('#totalBox').val(totalPlus);
});
$('#minus').click(function(){
	var num=$('#numBox').val();
	var totalNum=$('#totalBox').val();
	var minus=Number(num)-1;
	var totalMinus= Number(totalNum)-Number(<%=price%>);
		
	if(minus<=0){
		$('#numBox').val(num);
	}else{
		$('#numBox').val(minus);
		$('#totalBox').val(totalMinus);
	}
});

$('#addCart').click(function(){
	if($('#userid').val() != ''){
		var numStock=$('#numBox').val();
		var totalStock=$('#totalBox').val();
		var idPro=$('#idPro').val();
		var userid=$('#userid').val();
		var file=$('#file').val();
		var productName=$('#productName').val();
		var productPrice=$('#productPrice').val();
		$.ajax({
			url:'./AddCartServlet',
			type:'POST',		
			data: {
				numStock : numStock,
				totalStock : totalStock,
				idPro:idPro,
				userid : userid,
				files : file,
				productName : productName,
				productPrice : productPrice
			},			
			success : function(result){	
				alert('장바구니로 이동하였습니다.');		
			},
			error : function(result){
				alert('장바구니로 이동 실패');
			}
		});
	}else{
		alert('로그인 해주세요.');
	}
}); 
</script>
</body>
</html>