package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@MultipartConfig(
		fileSizeThreshold=1024*1024,
		maxFileSize=1024*1024*50,
		maxRequestSize=1024*1024*50*5
)
@WebServlet("/AddSlideServlet")
public class AddSlideServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");    
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		StringBuilder builder = new StringBuilder();
		
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
			String sql = "insert into mainSlide(file) values(?)";
			ps=con.prepareStatement(sql);
			ps.setString(1,builder.toString());
			int result=ps.executeUpdate();
			
			if(result == 1){
				out.println("<script>");
				out.println("alert('등록되었습니다.')");
				out.println("location='/ShoppingProject/admin/addSlide.jsp'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('등록 실패')");
				out.println("location='/ShoppingProject/admin/addSlide.jsp'");
				out.println("</script>");
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
