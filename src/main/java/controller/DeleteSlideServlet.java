package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteSlideServlet")
public class DeleteSlideServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();
	PreparedStatement ps;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		int id=Integer.parseInt(request.getParameter("id"));	
		
		try {			
			String sql="delete from mainslide where id=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,id);
			int result=ps.executeUpdate();
			
			if(result==1) {
				out.println("<script>");
				out.println("alert('슬라이드가 삭제되었습니다.')");
				out.println("location='/ShoppingProject/admin/slideList.jsp'");
				out.println("</script>");
				return;
			}else {
				out.println("<script>");
				out.println("alert('다시 시도해주세요.')");
				out.println("history.back();");
				out.println("</script>");
				return;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
