<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<% 
 
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}  
	
	String id_value = request.getParameter("user");
	String[] idArr = id_value.split(","); /* 콤마구분 */

	for (String wo : idArr ){
        System.out.println(wo);
    }
	
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
		
		/* if (arrInput.length > 0) { 
		     arrInput.pop(); 
		     arrInputValue.pop();
		} */
		
		for( int i = 0; i < idArr.length; i++) {
			String query1 = "delete from userinfo where userId= '" + idArr[i] + "'";
			pstmt = conn.prepareStatement(query1);
			pstmt.executeUpdate();
		}
		
		String retUrl = "UserList.jsp";
		response.sendRedirect(retUrl); 
		

	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 


%>
	<!-- $('input:radio[name=이름]').is(':checked');
$('input:checkbox[name=이름]').is(':checked');
-->
	