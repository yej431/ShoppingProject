package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.ProductEntity;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;
	ResultSet rs2=null;
	Statement st;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");	
		List<ProductEntity> productList = new ArrayList<ProductEntity>();
		
		String search=request.getParameter("search");
		String p=request.getParameter("p");
		
		int unit=7;
		
		if(p==null){
			p="1";
		}
		int v_page=Integer.parseInt(p);
		int index_no=(v_page-1)*unit;
		
		try {
			st = con.createStatement();
			String sql="select count(*) total from product where name like '%"+search+"%'";		
			rs=st.executeQuery(sql);
			rs.next();
			int total=rs.getInt("total");

			int lastpage=(int)Math.ceil((double)total/7);
			
			String sql2 = "select * from product where name like '%"+search+"%' order by id desc limit "+index_no+","+unit;	
			rs2=st.executeQuery(sql2);
			while(rs2.next()) {		
				int productId=rs2.getInt("id");
				String productName=rs2.getString("name");
				String mainCategory=rs2.getString("mainCategory");
				String subCategory=rs2.getString("subCategory");
				int price=rs2.getInt("price");
				int quantity=rs2.getInt("quantity");
				String active=rs2.getString("active");
				String file=rs2.getString("file");
				
				ProductEntity product = new ProductEntity(productId,productName,mainCategory,
						subCategory,price,quantity,active,file);
				productList.add(product);				
				request.setAttribute("list", productList);
				request.setAttribute("lastpage", lastpage);
				request.setAttribute("search", search);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		
		request.getRequestDispatcher("searchPage.jsp").forward(request, response);
	}
}
