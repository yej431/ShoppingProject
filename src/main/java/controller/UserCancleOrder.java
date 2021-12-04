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

@WebServlet("/UserCancleOrder")
public class UserCancleOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();
	PreparedStatement ps;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		String userid=request.getParameter("userid");
		int productId=Integer.parseInt(request.getParameter("productId"));	
		String status=request.getParameter("status");
		String cancle="주문취소";
		
		try {	
			if(status.equals("주문취소")) {
				out.println("<script>");
				out.println("alert('이미 취소되었습니다.')");
				out.println("history.back();");
				out.println("</script>");
				return;
			}else {
				String sql="update orders set status=? where userid=? and productId=?";
				ps=con.prepareStatement(sql);
				ps.setString(1,cancle);
				ps.setString(2,userid);
				ps.setInt(3,productId);
				int result=ps.executeUpdate();
				
				if(result==1) {
					out.println("<script>");
					out.println("alert('주문이 취소되었습니다.')");
					out.println("location='userOrderInfo.jsp'");
					out.println("</script>");
					return;
				}else {
					out.println("<script>");
					out.println("alert('다시 시도해주세요.')");
					out.println("history.back();");
					out.println("</script>");
					return;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
