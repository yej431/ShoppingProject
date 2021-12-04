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

@WebServlet("/DeleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		String userid=request.getParameter("userid");
		String productId=request.getParameter("productId");
		String orderDate=request.getParameter("orderDate");
		
		try {
			String sql = "delete from orders where userid=? and productId=? and orderDate=? ";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, productId);
			ps.setString(3, orderDate);		
			int result=ps.executeUpdate();
			
			if(result == 1){
				out.println("<script>");
				out.println("alert('삭제되었습니다.')");
				out.println("location='/ShoppingProject/admin/orderList.jsp'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('삭제 실패')");
				out.println("location='/ShoppingProject/admin/orderLsist.jsp");
				out.println("</script>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
