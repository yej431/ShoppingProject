package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddCartServlet")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();
	PreparedStatement ps;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		
		String userid=request.getParameter("userid");
		int idPro=Integer.parseInt(request.getParameter("idPro"));
		int numStock=Integer.parseInt(request.getParameter("numStock"));
		int totalStock=Integer.parseInt(request.getParameter("totalStock"));
	
		String sql1="select * from cart where userid='"+userid+"' and productId='"+idPro+"'";
		Statement st;
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql1);
			if(rs.next()) {
				String sql2="update cart set cartQuantity=? + 1, totalPrice=totalPrice+? where productId=? and userid=?";
				ps=con.prepareStatement(sql2);
				ps.setInt(1, numStock);
				ps.setInt(2, totalStock);
				ps.setInt(3, idPro);
				ps.setString(4, userid);
				ps.executeUpdate();
			}else {
				String sql3="insert into cart(userid,productId,cartQuantity,totalPrice) values(?,?,?,?)";
				ps=con.prepareStatement(sql3);
				ps.setString(1,userid);
				ps.setInt(2,idPro);
				ps.setInt(3,numStock);
				ps.setInt(4,totalStock);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
}
