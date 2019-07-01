<%@ page language="java" contentType="text/html; charset=UTF-8"	 pageEncoding="UTF-8"%>
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
	ResultSet rs = null;
	
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
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		
		while(rs.next()) {
			String dbUser = rs.getString("userId");
			String dbPass = rs.getString("userPass");
			
			if( dbUser.equals(id) && dbPass.equals(pw) ) {
				/* 인증되었음을 세션에 알림 */
				session.setAttribute("signedUser", id);	
				redirectURL = "base.jsp";	
				break;
			}
		}
		
	
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} finally {
		stmt.close();
		conn.close();
		rs.close();
		out.println("<script language=\"javascript\">");
		out.println("location.replace('" + redirectURL + "')");	    		
		out.println("</script>");
	}

%>