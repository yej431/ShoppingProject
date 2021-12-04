<%@page import="entity.CommentEntity"%>
<%@page import="controller.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@include file="mainHeader.jsp" %>
<%@page import="java.sql.*"%>
<%
int idB=Integer.parseInt(request.getParameter("idB"));
String sub=request.getParameter("sub");
String idPro=request.getParameter("idPro");

String sqlCount="update board set hit=hit+1 where id='"+idB+"'";
st.executeUpdate(sqlCount);
	
String sqlB="select title,userid,content,regdate,file from board where id='"+idB+"'";	
ResultSet rsB=st.executeQuery(sqlB);
	
String title="";
String user="";
String content="";
String file="";
Date regdate;
if(rsB.next()){
	title = rsB.getString("title");
	user = rsB.getString("userid");
	content = rsB.getString("content");
	content=content.replace("\n","<br>");
	content=content.replace(" ","&nbsp;");
	regdate = rsB.getDate("regdate");
	file = rsB.getString("file");
}else{
%>
<script>
	alert("잘못된 접근입니다!!");
	history.back();
</script>
<%
	return;
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
    <style>
    	th{width:20%;text-align:center}
    	td{text-align:left; padding-left:17px;}
    </style>
</head>
<body>
<div class="wrap">
<div style="margin:45px 0;">
<table>
	<tbody>
	<tr>
		<th>제목</th>
		<td><%=title%></td>
	</tr>
	<tr>
		<th>작성일</th>
		<td><%=regdate%></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=user%></td>
	</tr>
	<tr class="content">
		<th>내용</th>
		<td>
			<img src="./upload/<%=file%>" style="width:200px;display:block;" onerror="this.style.display='none'"alt="">
			<%=content%>
		</td>
	</tr>
	</tbody>
</table>

</div>
<div style="margin-top:10px;">
	<button style="width:70px;height:28px;" 
		onclick="location='productInfo.jsp?idPro=<%=idPro%>&sub=<%=sub%>'">목록</button>
	<button class="clearfix" style="width:70px;height:28px;margin-left:7px" 
		onclick="location='replyWrite.jsp?idB=<%=idB%>&idPro=<%=idPro%>&sub=<%=sub%>'">답변</button>	
<%	
if(session.getAttribute("userid") != null){
	String userid=(String)session.getAttribute("userid");
	String sqlB2="select * from board where id='"+idB+"' and userid='"+userid+"'";	
	ResultSet rsB2=st.executeQuery(sqlB2);

	if(rsB2.next() || userid.equals("관리자")){
%>		
	<div class="clearfix" style="float:right;">	
		<button style="width:70px;height:28px;"
			onclick="location='boardModify.jsp?idB=<%=idB%>&idPro=<%=idPro%>&sub=<%=sub%>'">수정</button>
		<button style="width:70px;height:28px;" 
			onclick="location='BoardDeleteServlet?idB=<%=idB%>&idPro=<%=idPro%>&sub=<%=sub%>'">삭제</button>	
	</div>	
<%
	}
}
%>
</div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>