package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
		fileSizeThreshold=1024*1024,
		maxFileSize=1024*1024*50,
		maxRequestSize=1024*1024*50*1 //50메가 크기를 1개 입력
)
@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		StringBuilder builder = new StringBuilder();
		
		String id=request.getParameter("productId");
		String name=request.getParameter("name");
		String main=request.getParameter("main");
		String sub=request.getParameter("sub");
		String price=request.getParameter("price");
		String quantity=request.getParameter("quantity");
		String active=request.getParameter("active");		
		
		Part filePart = request.getPart("file");	
		if(filePart.getSize()==0) {
			builder.append("null");
		}else {
			String fileName = filePart.getSubmittedFileName();
			InputStream fis = filePart.getInputStream();
			builder.append(fileName);
				
			String realPath = request.getServletContext().getRealPath("./upload");
			System.out.println(realPath);
				
			String filePath = realPath + File.separator + fileName;
			FileOutputStream fos = new FileOutputStream(filePath);
				
			byte[] buf=new byte[1024];
			int size=0;
			while((size=fis.read(buf)) != -1) {
				fos.write(buf,0,size);			
			}
			fos.close();
			fis.close();
		}	
		
		try {
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps;
			String query="update product set name=?,mainCategory=?,subCategory=?,price=?,quantity=?,active=?,file=?"
					+ " where id=?";
			ps=con.prepareStatement(query);
			ps.setString(1,name);
			ps.setString(2,main);
			ps.setString(3,sub);
			ps.setString(4,price);
			ps.setString(5,quantity);
			ps.setString(6,active);		
			ps.setString(7,builder.toString());
			ps.setString(8,id);
			int row=ps.executeUpdate();
			
			if(row>0) {
				out.println("<script>");
				out.println("alert('상품이 수정되었습니다.')");
				out.println("location='/ShoppingProject/admin/productList.jsp'");
				out.println("</script>");
				return;
			}else {
				out.println("<script>");
				out.println("alert('다시 시도해주세요.')");
				out.println("history.back();");
				out.println("</script>");
				return;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
