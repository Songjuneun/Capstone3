<%@ page language="java" contentType="text/html; charset=utf-8" 	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%request.setCharacterEncoding("utf-8"); %>

<%
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>취업</title>

<!-- Bootstrap -->
<link href="./Resources/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="./Resources/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<!-- Dropzone.js -->
<link href="./Resources/vendors/dropzone/dist/min/dropzone.min.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="./Resources/build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">

	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;

		try {

			Class.forName("com.mysql.jdbc.Driver");
			String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
			String jdbcID = "root";
			String jdbcPW = "rootpass";

			conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
			/* out.println("db connection ok!");
			out.println("");
			 */
			
			//합격 자소서 불러오기
			String sqlps = "select pword,pfreq,num from passkeywordinfo ";

			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(sqlps);

			//사용자 자소서 불러오기
			String sqlsam = "select sword,sfreq from samplekeywordinfo ";
			
			stmt = conn.createStatement();
			rs2 = stmt.executeQuery(sqlsam);
			
			//같은 단어 추출
			 String sqlpc = "select p.num, p.pword,s.sword from passKeywordinfo as p , sampleKeywordinfo as s where p.pword=s.sword order by p.num asc";

				stmt = conn.createStatement();
				rs3 = stmt.executeQuery(sqlpc);
	%>

	<div class="container body">
		<div class="main_container">
			
			<!-- side -->
			<jsp:include page="sidebar.jsp" flush="false"/>

			<!-- top navigation -->
			<jsp:include page="topnav.jsp" flush="false"/>

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3></h3>
						</div>

						<div class="title_right">
							<div
								class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Search for..."> <span
										class="input-group-btn">
										<button class="btn btn-default" type="button">Go!</button>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="clearfix"></div>

					<!----------------------- 양식 삽입 ---------------------------------->
					<div class="x_panel">
						<div class="x_title">
							<h2>Star Rating</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-expanded="false"><i
										class="fa fa-wrench"></i></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#">Settings 1</a></li>
										<li><a href="#">Settings 2</a></li>
									</ul></li>
								<li><a class="close-link"><i class="fa fa-close"></i></a></li>
							</ul>
							<div class="clearfix"></div>
						</div>

						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Company List<small>Choose your company</small>
									</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>
										<li class="dropdown"><a href="#" class="dropdown-toggle"
											data-toggle="dropdown" role="button" aria-expanded="false"><i
												class="fa fa-wrench"></i></a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="#">Settings 1</a></li>
												<li><a href="#">Settings 2</a></li>
											</ul></li>
										<li><a class="close-link"><i class="fa fa-close"></i></a>
										</li>
									</ul>
									<div class="clearfix"></div>
								</div>

								<div class="x_content">

									<p>
										Add class
										<code>bulk_action</code>
										to table for bulk actions options on row select
									</p>

									<div class="table-responsive">
										<table class="table table-striped jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th class="column-title">Num</th>
													<th class="column-title"> 매칭 완료 단어 </th>
													

												</tr>
											</thead>

											<tbody>
												<%
													String compare;
														int i = 0;
														int num = 0;
														String pword;
														String sword;
														while (rs3.next()){
														    num+=1;
															%>
															
												<tr>
													<td><%=rs3.getString("p.num") %></td>
													

													<td  >
														<%=rs3.getString("p.pword") %>
													</td>
													

												</tr>
												<%
														}
													%>
												


											</tbody>
										</table>
										<div>
											<h3>매칭 카운트 = <%=num%></h3>

										</div>
									</div>


								</div>
							</div>
						</div>


					</div>
	<% 
													} catch (SQLException e) {
														e.printStackTrace();
														out.println("DB Driver Error!");

													}
		
												%>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">
					한국교통대학교 <a href="https://colorlib.com">소프트웨어학과</a>
				</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>

	<!-- jQuery -->
	<script src="./Resources/vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="./Resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="./Resources/vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="./Resources/vendors/nprogress/nprogress.js"></script>
	<!-- Dropzone.js -->
	<script src="./Resources/vendors/dropzone/dist/min/dropzone.min.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="./Resources/build/js/custom.min.js"></script>

</body>
</html>