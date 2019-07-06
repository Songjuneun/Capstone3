<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<% 
 
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}  
	
	String company_Value = request.getParameter("list1");
	String gno_Value = request.getParameter("list2");
	
	String[] companyArr = company_Value.split(",");
	String[] gnoArr = gno_Value.split(","); 
	int[] gno = new int [gnoArr.length];
	
	for(int i =0; i < gnoArr.length; i++) {
		gno[i] = Integer.parseInt(gnoArr[i]);
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
		
		for( int i = 0; i < companyArr.length; i++) {
			String query1 = "delete from infoinfo where pass_company= '" + companyArr[i] + "' and pass_gno = " + gno[i];
			pstmt = conn.prepareStatement(query1);
			pstmt.executeUpdate();
		}
		
		String retUrl = "PassList_copy.jsp";
		response.sendRedirect(retUrl); 
		

	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 


%>