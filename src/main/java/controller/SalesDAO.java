package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import entity.CartEntity;
import entity.OrderEntity;

public class SalesDAO {
	
	Connection con=null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql="";
	
	public JSONObject productSales() {		
		List<OrderEntity> orderList = new ArrayList<OrderEntity>();
		JSONObject data = new JSONObject();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject(); 
		JSONArray ajaxArryCols = new JSONArray();
		JSONArray ajaxArryRows = new JSONArray();
		try {
			con=ConnectionProvider.getCon();
			sql="select productName,count(productName) as cnt from orders group by productName order by cnt limit 0,4";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();			
			while(rs.next()) {
				String productName=rs.getString("productName");
				int cnt=rs.getInt("cnt");				
				
				OrderEntity order = new OrderEntity();
				order.setProductName(productName);
				order.setCnt(cnt);
				
				orderList.add(order);	
			}
			
			ajaxObjCols1.put("type", "string");
			ajaxObjCols2.put("type", "number");
			
			ajaxArryCols.add(ajaxObjCols1);
			ajaxArryCols.add(ajaxObjCols2);
			
			for(int i=0; i<orderList.size(); i++) {
				JSONObject legend = new JSONObject();
				legend.put("v", orderList.get(i).getProductName());
			    legend.put("f", null);
			    
			    JSONObject value = new JSONObject();
			    value.put("v", orderList.get(i).getCnt());
			    value.put("f", null);
			    
			    JSONArray cValueArry = new JSONArray();
			    cValueArry.add(legend);
			    cValueArry.add(value);
			 
			    JSONObject cValueObj = new JSONObject();
			    cValueObj.put("c", cValueArry);
			 
			    ajaxArryRows.add(cValueObj);			    
			}
			data.put("cols", ajaxArryCols);
		    data.put("rows", ajaxArryRows);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONObject dailySales() {		
		List<OrderEntity> orderList = new ArrayList<OrderEntity>();
		JSONObject data = new JSONObject();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject(); 
		JSONArray ajaxArryCols = new JSONArray();
		JSONArray ajaxArryRows = new JSONArray();
		try {
			con=ConnectionProvider.getCon();
			sql="select date_format(orderDate,'%m/%d') as date, "
				+ "sum(totalPrice) as sum from orders group by date order by date desc limit 0,6";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();			
			while(rs.next()) {
				String orderDate=rs.getString("date");
				int sum=rs.getInt("sum");				
				
				OrderEntity order = new OrderEntity();
				order.setOrderDate(orderDate);
				order.setSum(sum);
				
				orderList.add(order);	
			}
			
			ajaxObjCols1.put("type", "string");
			ajaxObjCols2.put("type", "number");
			
			ajaxArryCols.add(ajaxObjCols1);
			ajaxArryCols.add(ajaxObjCols2);
			
			for(int i=0; i<orderList.size(); i++) {
				JSONObject legend = new JSONObject();
				legend.put("v", orderList.get(i).getOrderDate());
			    legend.put("f", null);
			    
			    JSONObject value = new JSONObject();
			    value.put("v", orderList.get(i).getSum());
			    value.put("f", null);
			    
			    JSONArray cValueArry = new JSONArray();
			    cValueArry.add(legend);
			    cValueArry.add(value);
			 
			    JSONObject cValueObj = new JSONObject();
			    cValueObj.put("c", cValueArry);
			 
			    ajaxArryRows.add(cValueObj);			    
			}
			data.put("cols", ajaxArryCols);
		    data.put("rows", ajaxArryRows);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONObject yearlySales() {		
		List<OrderEntity> orderList = new ArrayList<OrderEntity>();
		JSONObject data = new JSONObject();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject(); 
		JSONArray ajaxArryCols = new JSONArray();
		JSONArray ajaxArryRows = new JSONArray();
		try {
			con=ConnectionProvider.getCon();
			sql="select sum(totalPrice) as sum, date_format(orderDate,'%m') as date "
				+"from orders where year(orderDate) = year(now()) group by date order by date asc";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();			
			while(rs.next()) {
				String date=rs.getString("date");	
				int sum=rs.getInt("sum");							
				
				OrderEntity order = new OrderEntity();
				order.setOrderDate(date);
				order.setSum(sum);
				
				orderList.add(order);	
			}
			
			ajaxObjCols1.put("type", "string");
			ajaxObjCols2.put("type", "number");
			
			ajaxArryCols.add(ajaxObjCols1);
			ajaxArryCols.add(ajaxObjCols2);
			
			for(int i=0; i<orderList.size(); i++) {
				JSONObject legend = new JSONObject();
				legend.put("v", orderList.get(i).getOrderDate());
			    legend.put("f", null);
			    
			    JSONObject value = new JSONObject();
			    value.put("v", orderList.get(i).getSum());
			    value.put("f", null);
			    
			    JSONArray cValueArry = new JSONArray();
			    cValueArry.add(legend);
			    cValueArry.add(value);
			 
			    JSONObject cValueObj = new JSONObject();
			    cValueObj.put("c", cValueArry);
			 
			    ajaxArryRows.add(cValueObj);			    
			}
			data.put("cols", ajaxArryCols);
		    data.put("rows", ajaxArryRows);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}
}