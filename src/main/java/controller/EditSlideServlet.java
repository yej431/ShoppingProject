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
@WebServlet("/EditSlideServlet")
public class EditSlideServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		StringBuilder builder = new StringBuilder();
		
		String id=request.getParameter("id");	
		
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
			String sql="update mainSlide set file=? where id=?";
			ps=con.prepareStatement(sql);	
			ps.setString(1,builder.toString());
			ps.setString(2,id);
			int result=ps.executeUpdate();
			
			if(result == 1) {
				out.println("<script>");
				out.println("alert('슬라이드가 수정되었습니다.')");
				out.println("location='/ShoppingProject/admin/slideList.jsp'");
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
