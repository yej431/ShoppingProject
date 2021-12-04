package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.CartEntity;

@WebServlet("/UserOrderServlet")
public class UserOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();	
	PreparedStatement ps = null;	
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		List<CartEntity> cartList = new ArrayList<CartEntity>();
		
		String userid=request.getParameter("userid");
		String paymentMethod = request.getParameter("paymentMethod");
		String status="결제완료";

		try {
			Statement st = con.createStatement();
			
			String sql="select * from cart inner join product on cart.productId=product.id where userid='"+userid+"'";
			ResultSet rs=st.executeQuery(sql);
			while(rs.next()){ 	
				int productId=rs.getInt("productId");
				String productName=rs.getString("name");
				int quantity=rs.getInt("cartQuantity");
				int price=rs.getInt("price");
				int totalPrice=rs.getInt("totalPrice");
				String file=rs.getString("file");				
				
				CartEntity cart = new CartEntity();
				cart.setUserid(userid);
				cart.setProductId(productId);
				cart.setProductName(productName);				
				cart.setQuantity(quantity);
				cart.setPrice(price);
				cart.setTotalPrice(totalPrice);
				cart.setFiles(file);
				cart.setPaymentMethod(paymentMethod);
				
				cartList.add(cart);	
			}	
			
			int result=0;
			String sql2="insert into orders(userid,productId,productName,orderQuantity,totalPrice,paymentMethod,orderDate,"
					+ "deliveryDate,status) values(?,?,?,?,?,?,date_format(now(),'%Y-%m-%d'),"
					+ "date_format(date_add(orderDate,interval 3 day),'%Y-%m-%d'),?)";
			ps=con.prepareStatement(sql2);
			for(int i=0; i<cartList.size(); i++) {
				ps.setString(1, cartList.get(i).getUserid());
				ps.setInt(2, cartList.get(i).getProductId());
				ps.setString(3, cartList.get(i).getProductName());
				ps.setInt(4, cartList.get(i).getQuantity());
				ps.setInt(5, cartList.get(i).getTotalPrice());
				ps.setString(6, cartList.get(i).getPaymentMethod());
				ps.setString(7, status);
				result=ps.executeUpdate();
			}
			
			if(result == 1) {
				String sql3="delete from cart where userid=? and productId=?";
				ps=con.prepareStatement(sql3);
				for(int i=0; i<cartList.size(); i++) {
					ps.setString(1, cartList.get(i).getUserid());
					ps.setInt(2, cartList.get(i).getProductId());
					ps.executeUpdate();
				}
				request.getSession().setAttribute("msg","결제 완료");
				response.sendRedirect("cart.jsp");
			}else { 
				request.getSession().setAttribute("msg","결제 실패");
				response.sendRedirect("cart.jsp");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
