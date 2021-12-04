package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import entity.CategoryEntity;

@WebServlet("/GetSubServlet")
public class GetSubServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=ConnectionProvider.getCon();
	PreparedStatement ps;
	ResultSet rs=null;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String main=request.getParameter("main");
		
		try {
			String sql="select * from category where main='"+main+"'";
			Statement st = con.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {				
				String sub1=rs.getString("sub1");
				String sub2=rs.getString("sub2");
				String sub3=rs.getString("sub3");
				String sub4=rs.getString("sub4");
				
				out.print("<option value='"+sub1+"'>"+sub1+"</option>");
				out.print("<option value='"+sub2+"'>"+sub2+"</option>");
				out.print("<option value='"+sub3+"'>"+sub3+"</option>");
				out.print("<option value='"+sub4+"'>"+sub4+"</option>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
}
