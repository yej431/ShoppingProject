package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.BoardEntity;

@WebServlet("/boardText")
public class BoardText extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idB=Integer.parseInt(request.getParameter("idB"));		
		int idPro=Integer.parseInt(request.getParameter("idPro"));		
		String sub=request.getParameter("sub");		
		
		try {
			String sql="select * from board where id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, idB);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String title=rs.getString("title");
				String userid=rs.getString("userid");
				String content=rs.getString("content");
				Date regdate=rs.getDate("regdate");
				int hit=rs.getInt("hit");
				String files=rs.getString("file");
				
				BoardEntity board = new BoardEntity(idB,title,userid,content,regdate,hit,files);
				request.setAttribute("b", board);
				
				request.getRequestDispatcher("boardModify.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
