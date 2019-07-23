<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%	

	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
		//----------------------------JDBC 설정
		String jdbcUrl = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcId = "root";
		String jdbcPw = "rootpass";	
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);
	
		
		System.out.println( session.getAttribute("signedUser").toString() );
		
		String query2 = "UPDATE idInfo set userid=? where userid=?";
		pstmt = conn.prepareStatement(query2);
		pstmt.setString(1, null);
		pstmt.setString(2, session.getAttribute("signedUser").toString());
		pstmt.executeUpdate();
	
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} finally {
		pstmt.close();
		conn.close();
	}
	
	
    // 1: 기존의 세션 데이터를 모두 삭제
    session.invalidate();
    // 2: 로그인 페이지로 이동시킴.
    response.sendRedirect("login.jsp");
%>
