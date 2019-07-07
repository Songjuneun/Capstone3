<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<% 
 
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}  
	
	int num = Integer.parseInt(request.getParameter("num"));

	
 	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = null;
	
	try {
		
		//----------------------------JDBC 설정
		String jdbcUrl = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcId = "root";
		String jdbcPw = "rootpass";	
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		String query1 = "delete from specinfo where num= '" + num + "'"; //수정 필요
		pstmt = conn.prepareStatement(query1);
		pstmt.executeUpdate();
		

		String retUrl = "GraphPageP.jsp";
		response.sendRedirect(retUrl); 
		

	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	}


%>
