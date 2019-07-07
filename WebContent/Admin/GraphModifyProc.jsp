<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%

	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
	
	/* 값 가져오기 */
	int num = Integer.parseInt(request.getParameter("num"));
	String company = request.getParameter("company_Value");
	String dept = request.getParameter("department_Value");
	String univ= request.getParameter("univ_Value");
	String line= request.getParameter("line_Value");
	Float score = Float.parseFloat(request.getParameter("score_Value"));
	int toeic = Integer.parseInt(request.getParameter("toeic_Value"));
	String toss = request.getParameter("toss_Value");
	String opic= request.getParameter("opic_Value");
	int awards = Integer.parseInt(request.getParameter("awards_Value"));
	int intern = Integer.parseInt(request.getParameter("intern_Value"));
	int overseas = Integer.parseInt(request.getParameter("overseas_Value"));
	int volunteer = Integer.parseInt(request.getParameter("volunteer_Value"));
	int certificate = Integer.parseInt(request.getParameter("certificate_Value"));
	

	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	
	try {
	
		
		//----------------------------JDBC 설정
		String jdbcUrl = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcId = "root";
		String jdbcPw = "rootpass";	
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);
		
		
		String query1 = "UPDATE specinfo set company=?, dept=?, univname=?, line=?, score=?, toeic=?, toss=?, opic=?, awards=?, intern=?, overseas=?, volunteer=?, certificate=? where num=?";
		pstmt = conn.prepareStatement(query1);
		
		pstmt.setString(1, company);
		pstmt.setString(2, dept);
		pstmt.setString(3, univ);
		pstmt.setString(4, line);
		pstmt.setFloat(5, score);
		pstmt.setInt(6, toeic);
		pstmt.setString(7, toss);
		pstmt.setString(8, opic);
		pstmt.setInt(9, awards);
		pstmt.setInt(10, intern);
		pstmt.setInt(11, overseas);
		pstmt.setInt(12, volunteer);
		pstmt.setInt(13, certificate);
		pstmt.setInt(14, num);
		pstmt.executeUpdate();
		//------------------객체의 종료와 페이지 이동
		
		String retUrl = "GraphPageP.jsp";
		response.sendRedirect(retUrl);
			
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 

%>