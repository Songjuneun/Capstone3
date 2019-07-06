<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%

	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
	
	//--------------------------전달된 레코드 식별자 추출 (num자동)
	int gno = Integer.parseInt(request.getParameter("gno"));
	int year = Integer.parseInt(request.getParameter("yearContent"));
	String company = request.getParameter("companyContent");
	String dept = request.getParameter("deptContent");
	String[] question = request.getParameterValues("qContent");
	String[] answer = request.getParameterValues("aContent");
	
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
	
		
		//--------------------------------------- 데이터베이스 갱신
		String query1 = "select pass_num, pass_question from infoinfo where pass_company='" + company + "' and pass_gno = " + gno ;  /* 첫번째부터 rs.next 순차적으로 해서 배열에 들어가있는데 q&a와 같이 짝짝꿍한다  */
		String query3 = "select count(pass_question) from infoinfo where pass_company='" + company + "' and pass_gno = " + gno;	// 새로 추가된 내용이있나 확인하기 위한 카운트
		
		int cnt = 0;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query1);
		
		while(rs.next()){
		
			int n = rs.getInt("pass_num");
			String q = rs.getString("pass_question");
			
			String query2 = "UPDATE infoinfo set pass_gno=?, pass_year=?, pass_company=?, pass_dept=?, pass_question=?, pass_answer=? where pass_num=?";
			pstmt = conn.prepareStatement(query2);
			pstmt.setInt(1, gno);
			pstmt.setInt(2, year);
			pstmt.setString(3, company);
			pstmt.setString(4, dept);
			pstmt.setString(5, question[cnt]);
			pstmt.setString(6, answer[cnt]);
			pstmt.setInt(7, n);
			pstmt.executeUpdate();
			cnt++;
			
		}
		
		//------------------객체의 종료와 페이지 이동
		rs.close();
		pstmt.close();
		conn.close();
		
		
		String retUrl = "PassContent_copy.jsp?gno=" + gno + "&company=" + company + "&dept=" + dept + "&year=" + year;
		response.sendRedirect(retUrl);
			
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 

%>