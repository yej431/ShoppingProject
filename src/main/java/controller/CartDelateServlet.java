package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CartDelateServlet")
public class CartDelateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		Connection con=ConnectionProvider.getCon();		
		PrintWriter out = response.getWriter();
		
		String userid=request.getParameter("userid");
		String proId=request.getParameter("proId");
		
		if(userid==null && proId==null){
			out.println("<script>");
			out.println("alert('잘못된 경로로의 접근!!')");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
		
		PreparedStatement ps;
		try {
			String sql = "delete from cart where userid=? and productId=?";
			ps=con.prepareStatement(sql);
			ps.setString(1,userid);
			ps.setString(2,proId);
			int result=ps.executeUpdate();
			if(result==1){
				out.println("<script>");
				out.println("alert('삭제되었습니다.');");
				out.println("location='cart.jsp?userid="+userid+"&proId="+proId+"'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("다시 시도해주세요.");
				out.println("history.back();");
				out.println("</script>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
