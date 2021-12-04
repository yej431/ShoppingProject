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

@WebServlet("/EditOrderServlet")
public class EditOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		String userid=request.getParameter("userid");
		String orderDate=request.getParameter("orderDate");
		String proId=request.getParameter("proId");
		String status=request.getParameter("status");

		try {
			String sql = "update orders set status=? where userid=? and productId=? and orderDate=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, status);
			ps.setString(2, userid);
			ps.setString(3, proId);
			ps.setString(4, orderDate);		
			int result=ps.executeUpdate();
			
			if(result == 1){
				out.println("<script>");
				out.println("alert('수정완료')");
				out.println("location='/ShoppingProject/admin/orderList.jsp'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('수정실패')");
				out.println("location='/ShoppingProject/admin/editOrder.jsp?userid='"+userid+"'&orderDate='"+orderDate+"'");
				out.println("</script>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
