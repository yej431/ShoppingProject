package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FindPassword")
public class FindPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String userid = request.getParameter("userid");
		String securityQuestion=request.getParameter("security-question");
		String answer=request.getParameter("answer");
		String newPassword=request.getParameter("new-password");

		try{
			Connection con=ConnectionProvider.getCon();
			String sql = "select * from user where userid=? and securityquestion=? and answer=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, securityQuestion);
			ps.setString(3, answer);
			rs=ps.executeQuery();
			if(rs.next()){
				String sql2 = "update user set password=? where userid=?";
				ps=con.prepareStatement(sql2);
				ps.setString(1, newPassword);
				ps.setString(2, userid);
				ps.executeUpdate();
				request.getSession().setAttribute("userid",userid);
				response.sendRedirect("findPassword.jsp?msg=done");
			}else{
				response.sendRedirect("findPassword.jsp?msg=invalid");
			}
		}catch(Exception e){
			System.out.println(e);
		}
	}

}
