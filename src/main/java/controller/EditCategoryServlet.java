package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();
	PreparedStatement ps;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		int id=Integer.parseInt(request.getParameter("id"));
		String main=request.getParameter("main");
		String sub1=request.getParameter("sub1");	
		String sub2=request.getParameter("sub2");	
		String sub3=request.getParameter("sub3");	
		String sub4=request.getParameter("sub4");	
		
		try {			
			String sql="update category set main=?,sub1=?,sub2=?,sub3=?,sub4=? where id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1,main);
			ps.setString(2,sub1);
			ps.setString(3,sub2);
			ps.setString(4,sub3);
			ps.setString(5,sub4);
			ps.setInt(6,id);
			int result=ps.executeUpdate();
			
			if(result==1) {
				out.println("<script>");
				out.println("alert('카테고리가 수정되었습니다..')");
				out.println("location='/ShoppingProject/admin/categoryList.jsp'");
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
