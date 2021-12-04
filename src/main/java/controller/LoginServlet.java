package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.CategoryEntity;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String userid=request.getParameter("userid");
		String password=request.getParameter("password");
		
		if("admin".equals(userid) && "1234".equals(password)){
			request.getSession().setAttribute("userid", "관리자");
			response.sendRedirect("admin/adminMain.jsp");
		}else {
			String sql="select * from user where userid=? and password=?";
			try {
				ps=con.prepareStatement(sql);
				ps.setString(1, userid);
				ps.setString(2, password);
				rs=ps.executeQuery();
				if(rs.next()) {
					request.getSession().setAttribute("userid",userid);
					response.sendRedirect("main.jsp");
				}else{
					response.sendRedirect("login.jsp?msg=notexist");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("login.jsp?msg=invalid");
			}
		}
	}

}
