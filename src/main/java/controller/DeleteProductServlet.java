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

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		String productId=request.getParameter("productId");			
		
		try {
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps;
			String query="delete from product where id=?";
			ps=con.prepareStatement(query);
			ps.setString(1,productId);
			int row=ps.executeUpdate();
			
			if(row>0) {
				out.println("<script>");
				out.println("alert('상품이 삭제되었습니다.')");
				out.println("location='/ShoppingProject/admin/productList.jsp'");
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
