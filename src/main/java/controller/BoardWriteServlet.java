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

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
	fileSizeThreshold=1024*1024,
	maxFileSize=1024*1024*5,
	maxRequestSize=1024*1024*5*5
)
@WebServlet("/BoardWriteServlet")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = ConnectionProvider.getCon();
	PreparedStatement ps = null;
	ResultSet rs=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();		

		String idPro = request.getParameter("idPro");
		String sub = request.getParameter("sub");
		String title=request.getParameter("title");
		String userid = (String)session.getAttribute("userid");
		String content=request.getParameter("content");
		
		if(content.length() > 5000){
			out.println("<script>");
			out.println("내용의 양이 너무 많습니다.");
			out.println("history.back();");
			out.println("</script>");
			return;
		}	
		
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
		
		String sql="select ifnull(max(gid),0)+1 mygid from board";
		Statement st;
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			int mygid=rs.getInt("mygid");
			
			String sql2="insert into board(userid,productId,title,content,regdate,gid,thread,file) "
					+ "values(?,?,?,?,now(),?,'a',?)";
			ps=con.prepareStatement(sql2);
			ps.setString(1, userid);
			ps.setString(2, idPro);
			ps.setString(3, title);
			ps.setString(4, content);
			ps.setInt(5, mygid);
			ps.setString(6, builder.toString());
			int result=ps.executeUpdate();
			
			if(result==1){
				out.println("<script>");
				out.println("alert('등록되었습니다.')");
				out.println("location='/ShoppingProject/productInfo.jsp?idPro="+idPro+"&sub="+sub+"'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("저장실패\n관리자에게 연락해주세요.");
				out.println("history.back();");
				out.println("</script>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
