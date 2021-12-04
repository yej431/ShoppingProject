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

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String userid=request.getParameter("userid");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String number1=request.getParameter("number1");	
		String number2=request.getParameter("number2");	
		String number3=request.getParameter("number3");	
		String securityquestion=request.getParameter("securityquestion");
		String password=request.getParameter("password");
		String password2=request.getParameter("password2");
		String answer=request.getParameter("answer");	
		String address=request.getParameter("address");	
		String address2=request.getParameter("address2");	
		String mobileNumber=number1+number2+number3;
		
		if(!password.equals(password2)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","비밀번호가 서로 일치하지 않습니다.");
			response.sendRedirect("signup.jsp");
			return;
		}
		
		int registerCheck=registerCheck(userid);
		if(registerCheck == 0) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","이미 존재하는 아이디입니다.");
			response.sendRedirect("signup.jsp");
			return;
		}
		
		int register=register(userid,name,email,mobileNumber,securityquestion,answer,password,address,address2);
		if(register == 1) {
			request.getSession().setAttribute("messageType","성공 메시지");
			request.getSession().setAttribute("messageContent","회원가입에 성공했습니다.");
			response.sendRedirect("signup.jsp");
			return;
		}else {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","회원가입에 실패했습니다.");
			response.sendRedirect("signup.jsp");
			return;
		}
		
	}

	public int register(String userid, String name, String email, String mobileNumber, 
			String securityquestion, String answer, String password, String address, String address2) {		
		String sql = "insert into user values(?,?,?,?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, name);
			ps.setString(3, email);
			ps.setString(4, mobileNumber);
			ps.setString(5, securityquestion);
			ps.setString(6, answer);
			ps.setString(7, password);
			ps.setString(8, address);
			ps.setString(9, address2);
			return ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int registerCheck(String userid) {
		String sql="select * from user where userid=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			if(rs.next() || userid.equals("")) {
				return 0;
			}else {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
