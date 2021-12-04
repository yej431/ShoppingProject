package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.ProductEntity;

@WebServlet("/SearchProductServlet")
public class SearchProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<ProductEntity> list = new ArrayList<ProductEntity>();
		
		String index_no=request.getParameter("index_no");
		String unit=request.getParameter("unit");
		String select=request.getParameter("select");
		String search=request.getParameter("search");
		
		String sql = "select * from product where "+select+" like ? order by id desc limit "+1+","+7;
		
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, '%'+search+'%');
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int productId=rs.getInt("id");
				String productName=rs.getString("name");
				String mainCategory=rs.getString("mainCategory");
				String subCategory=rs.getString("subCategory");
				int price=rs.getInt("price");
				int quantity=rs.getInt("quantity");
				String active=rs.getString("active");
				String file=rs.getString("file");
				
				ProductEntity product = new ProductEntity(productId,productName,mainCategory,subCategory,
					price,quantity,active,file);
				
				list.add(product);
				request.setAttribute("list", list);
			}
			request.getRequestDispatcher("/ShoppingProject/admin/productList.jsp")
			.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
