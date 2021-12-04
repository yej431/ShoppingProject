package controller;

import java.io.IOException;
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

@WebServlet("/ProductListServlet")
public class ProductListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	ResultSet rs=null;
	PreparedStatement ps = null;
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");		
		
		int unit=7;

		String p=request.getParameter("p");
		String key=request.getParameter("key");
		String word=request.getParameter("word");
		
		if(p==null){
			p="1";
		}
		int v_page=Integer.parseInt(p);
		int index_no=(v_page-1)*unit;
		
		if(word != null && !word.equals("")){
			Statement st;
			try {
				st = con.createStatement();
				String sqlTot="select count(*) total from product where "+key+" like '%"+word+"%'";	
				ResultSet rsTot=st.executeQuery(sqlTot);
				rsTot.next();
				int total=rsTot.getInt("total");

				int lastpage=(int)Math.ceil((double)total/7);
				
				String sql="select * from product where "+key+" like '%"+word+"%' order by id desc limit "+index_no+","+unit;
				
				ResultSet rsPro=st.executeQuery(sql);
				while(rsPro.next()) {
					int productId=rsPro.getInt("id");
					String productName=rsPro.getString("name");
					String mainCategory=rsPro.getString("mainCategory");
					String subCategory=rsPro.getString("subCategory");
					int price=rsPro.getInt("price");
					int quantity=rsPro.getInt("quantity");
					String active=rsPro.getString("active");
					String file=rsPro.getString("file");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}else{
			Statement st;
			try {
				st = con.createStatement();
				String sqlTot="select count(*) total from product";	
				ResultSet rsTot=st.executeQuery(sqlTot);
				rsTot.next();
				int total=rsTot.getInt("total");

				int lastpage=(int)Math.ceil((double)total/7);
				
				String sql = "select * from product order by id desc limit "+index_no+","+unit;
				
				ResultSet rsPro=st.executeQuery(sql);
				while(rsPro.next()) {
					int productId=rsPro.getInt("id");
					String productName=rsPro.getString("name");
					String mainCategory=rsPro.getString("mainCategory");
					String subCategory=rsPro.getString("subCategory");
					int price=rsPro.getInt("price");
					int quantity=rsPro.getInt("quantity");
					String active=rsPro.getString("active");
					String file=rsPro.getString("file");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
	}
}
