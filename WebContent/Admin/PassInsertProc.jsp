<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%

	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
	
	//--------------------------전달된 레코드 식별자 추출 (num자동)
	int year = Integer.parseInt(request.getParameter("yearContent"));
	String company = request.getParameter("companyContent");
	String dept = request.getParameter("deptContent");
	String[] question = request.getParameterValues("qContent");
	String[] answer = request.getParameterValues("aContent");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 = null;
	Statement stmt = null;
		
	try {
			
			//----------------------------JDBC 설정
			String jdbcUrl = "jdbc:mysql://localhost:3306/capstonedb";
			String jdbcId = "root";
			String jdbcPw = "rootpass";	
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);
		
			
			//--------------------------------------- 데이터베이스 갱신
			String query1 = "select pass_gno from passInfo order by pass_gno desc limit 1;";  
			
			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(query1);
			
			int gno = 0;
			if (rs1.next()){
				gno = rs1.getInt(1) +1;
			}
			
			
			for (int i = 0; i < answer.length; i++) {
				String query2 = "insert into infoinfo(pass_gno, pass_year, pass_company, pass_dept, pass_question, pass_answer) values(?,?,?,?,?,?)";	/* gno 값 정해주기 */
				pstmt = conn.prepareStatement(query2);
				
				pstmt.setInt(1,gno);
				pstmt.setInt(2,year);
				pstmt.setString(3,company);
				pstmt.setString(4,dept);
				pstmt.setString(5,question[i]);
				pstmt.setString(6,answer[i]);
				pstmt.executeUpdate();
			}
			
			//------------------객체의 종료와 페이지 이동
			rs1.close();
			pstmt.close();
			conn.close();
			
			
			String retUrl = "PassList_copy.jsp";
			response.sendRedirect(retUrl);
				
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 

%>