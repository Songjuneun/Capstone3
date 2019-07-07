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
			String id = request.getParameter("id_Value2");
			String pass = request.getParameter("pass_Value2");
			String dept = request.getParameter("department_Value");
			float score = Float.parseFloat(request.getParameter("score_Value"));
			int toeic = Integer.parseInt(request.getParameter("toeic_Value"));
			String toss = request.getParameter("toss_Value");
			String opic = request.getParameter("opic_Value");
			int awards = Integer.parseInt( request.getParameter("awards_Value") );
			int intern = Integer.parseInt (request.getParameter("intern_Value") );
			int overseas = Integer.parseInt( request.getParameter("overseas_Value") );
			int volunteer = Integer.parseInt( request.getParameter("volunteer_Value") );
			int certificate =  Integer.parseInt( request.getParameter("certificate_Value") );
			
			
			//------------------전송된 아이디와 동일한 아이디 추출, 아이디 중복 검사
			String Query1 = "select count(userId) from userInfo where userId = '" + id + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Query1);	
			rs.next();
			
			int same_id = rs.getInt(1);
			
			if( same_id != 0 ) {
				
				rs.close();
				conn.close();
				stmt.close();
				
				out.println("<script language=\"javascript\">");
	    		out.println("alert('동일한 아이디가 존재합니다.')");
	    		out.println("location.replace('login.jsp')");	    		
	    		out.println("</script>");
	    		out.flush();
				
			} else {
				
				// 회원가입 db 저장
				String Query2 = "insert into userInfo values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(Query2);
				pstmt.setString(1, id);	
				pstmt.setString(2, pass);	
				pstmt.setString(3, dept);
				pstmt.setFloat(4, score);
				pstmt.setInt(5,toeic);
				pstmt.setString(6, toss);
				pstmt.setString(7, opic);
				pstmt.setInt(8, awards);
				pstmt.setInt(9, intern);
				pstmt.setInt(10, overseas);
				pstmt.setInt(11, volunteer);
				pstmt.setInt(12, certificate);
				
				pstmt.executeUpdate();
				
				rs.close();
				pstmt.close();
				conn.close();
				stmt.close();
				
				out.println("<script language=\"javascript\">");
	    		out.println("alert('회원가입이 완료되었습니다.\\n 아이디와 패스워드로 로그인하세요.')");
	    		out.println("location.replace('login.jsp')");
	    		out.println("</script>");
	    		out.flush();
				
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
			out.println("DB Driver Error!");
			
		}  
		
%>

