<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="controller.SalesDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%
SalesDAO dao = new SalesDAO();
JSONObject json = dao.yearlySales();
%>
<%=json%>