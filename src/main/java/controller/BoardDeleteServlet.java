package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BoardDeleteServlet")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		Connection con=ConnectionProvider.getCon();
		
		PrintWriter out = response.getWriter();
		
		String idB=request.getParameter("idB");
		String idPro=request.getParameter("idPro");
		String sub=request.getParameter("sub");
		
		if(idB==null && idPro==null && sub==null){
			out.println("<script>");
			out.println("alert('잘못된 경로로의 접근!!')");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
		
		Statement st;
		try {
			st = con.createStatement();
			String sql = "select gid,thread from board where id='"+idB+"'";
			ResultSet rs=st.executeQuery(sql);
			rs.next();
			int gid=rs.getInt("gid");
			String thread=rs.getString("thread");
			
			String sql2="select count(*) cnt from board where gid='"+gid+"' and thread like '"+thread+"_'";
			ResultSet rs2=st.executeQuery(sql2);
			rs2.next();
			int cnt=rs2.getInt("cnt");
			
			int result=0;
			if(cnt > 0){
				String sql3="update board set title='작성자에 의해 삭제되었습니다.',content='' where id='"+idB+"'";
				result=st.executeUpdate(sql3);
			}else{
				String sql4="delete from board where id='"+idB+"'";
				result=st.executeUpdate(sql4);
			}
			
			if(result == 1){
				out.println("<script>");
				out.println("alert('삭제되었습니다.')");
				out.println("location='productInfo.jsp?idPro="+idPro+"&sub="+sub+"'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('삭제실패')");
				out.println("location='productInfo.jsp?idPro="+idPro+"&sub="+sub+"'");
				out.println("</script>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
