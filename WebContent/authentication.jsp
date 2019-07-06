<%@ page language="java" contentType="text/html; chars1et=UTF-8"	 pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%
	// --------- 로그인 입력값 추출
	String id = request.getParameter("id_Value");
	String pw = request.getParameter("pass_Value");
	String redirectURL = "login.jsp";

	Connection conn = null;
	Statement stmt = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcID = "root";
		String jdbcPW = "rootpass";
		
		conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
		/* out.println("db connection ok!");
		out.println("");
		 */
		String sql = "select userId, userPass from userInfo";
		String query = "select adminrId, adminPass from adminInfo";
		
		stmt = conn.createStatement();
		rs1 = stmt.executeQuery(sql);
	

		if (rs1.next()) {
			String dbUser = rs1.getString("userId");
			String dbPass = rs1.getString("userPass");
			
			if( dbUser.equals(id) && dbPass.equals(pw) ) {
				/* 인증되었음을 세션에 알림 */
				session.setAttribute("signedUser", id);	
				redirectURL = "base.jsp";	
			}
		}
		

		rs2 = stmt.executeQuery(query);
 		if (rs2.next()) {
			String dbUser = rs2.getString("adminrId");
			String dbPass = rs2.getString("adminPass");
			
			if( dbUser.equals(id) && dbPass.equals(pw) ) {
				session.setAttribute("signedUser", id);	
				redirectURL = "./Admin/base.jsp";	
				
			}
		} 
 		
	
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} finally {
		stmt.close();
		conn.close();
		rs1.close();
		rs2.close();
		out.println("<script language=\"javascript\">");
		out.println("location.replace('" + redirectURL + "')");	    		
		out.println("</script>");
	}

%>