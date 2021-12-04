<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
	Connection con = ConnectionProvider.getCon();
	request.setCharacterEncoding("utf-8");
	Statement st = con.createStatement();
	
	String id=request.getParameter("id");
	String userid=request.getParameter("userid");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String files=request.getParameter("files");
	String idPro = request.getParameter("idPro");
	String sub = request.getParameter("sub");
	
	String sql = "select gid,thread from board where id='"+id+"'";
	ResultSet rs=st.executeQuery(sql);
	rs.next();
	String p_gid=rs.getString("gid");
	String p_thread=rs.getString("thread");
	
	String sql2 = "select ifnull(max(thread),'없음') as mThread from board where gid='"+p_gid
			+"' and thread like '"+p_thread+"_'";
	ResultSet rs2=st.executeQuery(sql2);
	rs2.next();
	String mThread = rs2.getString("mThread");
	String myThread="";
	
	if(mThread.equals("없음")){
		myThread=p_thread + "a";
	}else{
		char a1 = mThread.charAt(mThread.length()-1); //맨 마지막 값
		a1++;
		String a2 = mThread.substring(0,mThread.length()-1);
		myThread=a2+a1;
	}
	String sql3="insert into board(userid,title,content,regdate,gid,thread) values('"+userid+"','"+title
			+"','"+content+"',now(),'"+p_gid+"','"+myThread+"')";
	int result = st.executeUpdate(sql3);
	if(result==1){
%>
<script>
	alert("답변완료");
	location="productInfo.jsp?idPro=<%=idPro%>&sub=<%=sub%>";
</script>
<%
	}else{
%>
<script>
	alert("답변실패");
	location="productInfo.jsp?idPro=<%=idPro%>&sub=<%=sub%>";
</script>
<%
	}
%>