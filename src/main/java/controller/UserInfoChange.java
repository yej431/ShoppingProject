package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserInfoChange")
public class UserInfoChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("userid");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String address2=request.getParameter("address2");
		
		try{			
			String sql2="update user set name=?,email=?,mobileNumber=?,address=?,address2=? where userid=?";
			ps=con.prepareStatement(sql2);
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, phone);
			ps.setString(4, address);
			ps.setString(5, address2);
			ps.setString(6, userid);
			int result=ps.executeUpdate();
			
			if(result == 1){
				out.println("<script>");
				out.println("alert('수정되었습니다.')");
				out.println("location='userInfo.jsp'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('다시 시도해주세요')");
				out.println("history.back();");
				out.println("</script>");
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
