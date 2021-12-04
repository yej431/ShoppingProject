package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();	
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		String main=request.getParameter("main");
		String sub1=request.getParameter("sub1");
		String sub2=request.getParameter("sub2");
		String sub3=request.getParameter("sub3");
		String sub4=request.getParameter("sub4");
		
		try{					
//			Statement st=con.createStatement();
//			String sql="select * from category where id="+id;
//			ResultSet rs=st.executeQuery(sql);		
//			
//			if(rs.next()){
//				out.println("<script>");
//				out.println("alert('해당 번호는 이미 존재합니다.')");
//				out.println("history.back();");
//				out.println("</script>");
//			}else {
				String sql2="insert into category(main,sub1,sub2,sub3,sub4) values(?,?,?,?,?)";
				ps=con.prepareStatement(sql2);
				ps.setString(1, main);
				ps.setString(2, sub1);
				ps.setString(3, sub2);
				ps.setString(4, sub3);
				ps.setString(5, sub4);
				int result=ps.executeUpdate();
				
				if(result==1) {
					out.println("<script>");
					out.println("alert('카테고리가 등록되었습니다.')");
					out.println("history.back();");
					out.println("</script>");
					return;
				}else {
					out.println("<script>");
					out.println("alert('다시 시도해주세요.')");
					out.println("history.back();");
					out.println("</script>");
					return;
				}	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
