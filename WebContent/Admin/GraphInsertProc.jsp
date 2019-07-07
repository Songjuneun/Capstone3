<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
			String jdbcID = "root";
			String jdbcPW = "rootpass";
			
			conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
			 
			//--------------db에 저장될 변수
			String school = request.getParameter("school_Value");
			String company = request.getParameter("company_Value");
			String dept = request.getParameter("department_Value");
			String univname = request.getParameter("univ_Value");
			String line = request.getParameter("line_Value");
			float score = Float.parseFloat(request.getParameter("score_Value"));
			int toeic = Integer.parseInt(request.getParameter("toeic_Value"));
			String toss = request.getParameter("toss_Value");
			String opic = request.getParameter("opic_Value");
			int awards = Integer.parseInt( request.getParameter("awards_Value") );
			int intern = Integer.parseInt (request.getParameter("intern_Value") );
			int overseas = Integer.parseInt( request.getParameter("overseas_Value") );
			int volunteer = Integer.parseInt( request.getParameter("volunteer_Value") );
			String certificate =  request.getParameter("certificate_Value") ;
			
			
			//------------------전송된 아이디와 동일한 아이디 추출, 아이디 중복 검사
				// 회원가입 db 저장
			String Query1 = "insert into specInfo(company, dept, univname, line, score, toeic, toss, opic, certificate, awards, intern, overseas, volunteer) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(Query1);
			pstmt.setString(1, company);
			pstmt.setString(2, dept);
			pstmt.setString(3, univname);
			pstmt.setString(4, line);
			pstmt.setFloat(5, score);
			pstmt.setInt(6,toeic);
			pstmt.setString(7, toss);
			pstmt.setString(8, opic);
			pstmt.setString(9, certificate);
			pstmt.setInt(10, awards);
			pstmt.setInt(11, intern);
			pstmt.setInt(12, overseas);
			pstmt.setInt(13, volunteer);
			
			pstmt.executeUpdate();
			
			out.println("<script language=\"javascript\">");
    		out.println("location.replace('GraphPageP.jsp')");
    		out.println("</script>");
    		out.flush();
			
		} catch(SQLException e) {
			e.printStackTrace();
			out.println("DB Driver Error!");
			
		}  
		
%>

