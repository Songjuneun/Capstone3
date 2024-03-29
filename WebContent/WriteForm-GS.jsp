<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*, java.util.*"%>

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
		String sqlps = "select qgs_question from qgs where qgs_num <=5 ";

		stmt = conn.createStatement();
		rs1 = stmt.executeQuery(sqlps);

		//사용자 자소서 불러오기
		String sqlsam = "select qgs_question from qgs where 11 <= qgs_num and qgs_num <= 15 ";
		
		stmt = conn.createStatement();
		rs2 = stmt.executeQuery(sqlsam);
		
	
		
		
	%>


	<div class="container body">
		<div class="main_container">

			<!-- 사이드바 -->
			<jsp:include page="sidebar.jsp" flush="false"/>
		
			<!-- top navigation -->
			<jsp:include page="topnav.jsp" flush="false"/>

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>자소서 작성</h3>
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
					<!-- Tab 목록 구현 -->
					<div class="x_content">

						<div class="" role="tabpanel" data-example-id="togglable-tabs">
							<ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
	
								<li role="presentation" class="active"><a
									href="#tab_content1" role="tab" id="profile-tab1"
									data-toggle="tab" aria-expanded="true">인사 총무 부분 채용형 인턴 모집 </a></li>

								<li role="presentation" class=""><a
									href="#tab_content2" role="tab" id="profile-tab2"
									data-toggle="tab" aria-expanded="flase">[신입]H&B 사업부문(lalvla)인턴 사원 모집</a></li>
			
		</ul>
						</div>
					</div>
					<div id="myTabContent" class="tab-content">
						<!-- Tab 1번 목록 구현 TextArea-->

						<div role="tabpanel" class="tab-pane fade active in" id="tab_content1"
							aria-labelledby="profile-tab1">
							<div class="col-md-12 col-sm-12 col-xs-12">
						     <% 
						       while(rs1.next()){
						     
						     %>
								<div class="x_panel">
									<div class="x_title">
										<h2>
											<%=rs1.getString("qgs_question")%><small>Sessions</small>
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
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div class="x_panel">

											<div class="x_content">
												<div id="alerts"></div>
												<div class="btn-toolbar editor" data-role="editor-toolbar"
													data-target="#editor-one">
													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Font"><i class="fa fa-font"></i><b
															class="caret"></b></a>
														<ul class="dropdown-menu">
														</ul>
													</div>

													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Font Size"><i class="fa fa-text-height"></i>&nbsp;<b
															class="caret"></b></a>
														<ul class="dropdown-menu">
															<li><a data-edit="fontSize 5">
																	<p style="font-size: 17px">Huge</p>
															</a></li>
															<li><a data-edit="fontSize 3">
																	<p style="font-size: 14px">Normal</p>
															</a></li>
															<li><a data-edit="fontSize 1">
																	<p style="font-size: 11px">Small</p>
															</a></li>
														</ul>
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
															class="fa fa-bold"></i></a> <a class="btn" data-edit="italic"
															title="Italic (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
														<a class="btn" data-edit="strikethrough"
															title="Strikethrough"><i class="fa fa-strikethrough"></i></a>
														<a class="btn" data-edit="underline"
															title="Underline (Ctrl/Cmd+U)"><i
															class="fa fa-underline"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="insertunorderedlist"
															title="Bullet list"><i class="fa fa-list-ul"></i></a> <a
															class="btn" data-edit="insertorderedlist"
															title="Number list"><i class="fa fa-list-ol"></i></a> <a
															class="btn" data-edit="outdent"
															title="Reduce indent (Shift+Tab)"><i
															class="fa fa-dedent"></i></a> <a class="btn"
															data-edit="indent" title="Indent (Tab)"><i
															class="fa fa-indent"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn btn-info" data-edit="justifyleft"
															title="Align Left (Ctrl/Cmd+L)"><i
															class="fa fa-align-left"></i></a> <a class="btn"
															data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i
															class="fa fa-align-center"></i></a> <a class="btn"
															data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i
															class="fa fa-align-right"></i></a> <a class="btn"
															data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
															class="fa fa-align-justify"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Hyperlink"><i class="fa fa-link"></i></a>
														<div class="dropdown-menu input-append">
															<input class="span2" placeholder="URL" type="text"
																data-edit="createLink">
															<button class="btn" type="button">Add</button>
														</div>
														<a class="btn" data-edit="unlink" title="Remove Hyperlink"><i
															class="fa fa-cut"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn"
															title="Insert picture (or just drag &amp; drop)"
															id="pictureBtn"><i class="fa fa-picture-o"></i></a> <input
															type="file" data-role="magic-overlay"
															data-target="#pictureBtn" data-edit="insertImage">
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
															class="fa fa-undo"></i></a> <a class="btn" data-edit="redo"
															title="Redo (Ctrl/Cmd+Y)"><i class="fa fa-repeat"></i></a>
													</div>
												</div>

												<div id="editor-one" class="editor-wrapper placeholderText"
													contenteditable="true">
												</div>

												<textarea name="descr" id="descr" style="display: none;"></textarea>

												<br>

												<div class="ln_solid"></div>


											</div>
										</div>
									</div>
								</div>
								<% } %>
							</div>
						</div>

						<!-- Tab 1번 목록 끝 -->
						<!-- Tab 2번 목록 구현 -->

						<div role="tabpanel" class="tab-pane fade" id="tab_content2"
							aria-labelledby="profile-tab2">
							<div class="col-md-12 col-sm-12 col-xs-12">
							<% 
						       while(rs2.next()){
						     
						     %>
								<div class="x_panel">
									<div class="x_title">
										<h2>
											<%=rs2.getString("qgs_question") %><small>Sessions</small>
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
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div class="x_panel">

											<div class="x_content">
												<div id="alerts"></div>
												<div class="btn-toolbar editor" data-role="editor-toolbar"
													data-target="#editor-one">
													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Font"><i class="fa fa-font"></i><b
															class="caret"></b></a>
														<ul class="dropdown-menu">
														</ul>
													</div>

													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Font Size"><i class="fa fa-text-height"></i>&nbsp;<b
															class="caret"></b></a>
														<ul class="dropdown-menu">
															<li><a data-edit="fontSize 5">
																	<p style="font-size: 17px">Huge</p>
															</a></li>
															<li><a data-edit="fontSize 3">
																	<p style="font-size: 14px">Normal</p>
															</a></li>
															<li><a data-edit="fontSize 1">
																	<p style="font-size: 11px">Small</p>
															</a></li>
														</ul>
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
															class="fa fa-bold"></i></a> <a class="btn" data-edit="italic"
															title="Italic (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
														<a class="btn" data-edit="strikethrough"
															title="Strikethrough"><i class="fa fa-strikethrough"></i></a>
														<a class="btn" data-edit="underline"
															title="Underline (Ctrl/Cmd+U)"><i
															class="fa fa-underline"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="insertunorderedlist"
															title="Bullet list"><i class="fa fa-list-ul"></i></a> <a
															class="btn" data-edit="insertorderedlist"
															title="Number list"><i class="fa fa-list-ol"></i></a> <a
															class="btn" data-edit="outdent"
															title="Reduce indent (Shift+Tab)"><i
															class="fa fa-dedent"></i></a> <a class="btn"
															data-edit="indent" title="Indent (Tab)"><i
															class="fa fa-indent"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn btn-info" data-edit="justifyleft"
															title="Align Left (Ctrl/Cmd+L)"><i
															class="fa fa-align-left"></i></a> <a class="btn"
															data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i
															class="fa fa-align-center"></i></a> <a class="btn"
															data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i
															class="fa fa-align-right"></i></a> <a class="btn"
															data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
															class="fa fa-align-justify"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn dropdown-toggle" data-toggle="dropdown"
															title="Hyperlink"><i class="fa fa-link"></i></a>
														<div class="dropdown-menu input-append">
															<input class="span2" placeholder="URL" type="text"
																data-edit="createLink">
															<button class="btn" type="button">Add</button>
														</div>
														<a class="btn" data-edit="unlink" title="Remove Hyperlink"><i
															class="fa fa-cut"></i></a>
													</div>

													<div class="btn-group">
														<a class="btn"
															title="Insert picture (or just drag &amp; drop)"
															id="pictureBtn"><i class="fa fa-picture-o"></i></a> <input
															type="file" data-role="magic-overlay"
															data-target="#pictureBtn" data-edit="insertImage">
													</div>

													<div class="btn-group">
														<a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
															class="fa fa-undo"></i></a> <a class="btn" data-edit="redo"
															title="Redo (Ctrl/Cmd+Y)"><i class="fa fa-repeat"></i></a>
													</div>
												</div>

												<div id="editor-one" class="editor-wrapper placeholderText"
													contenteditable="true">
													
												</div>

												<textarea name="descr" id="descr" style="display: none;"></textarea>

												<br>

												<div class="ln_solid"></div>


											</div>
										</div>
									</div>
								</div>
								<% } %>
							</div>
						</div>
						<!-- Tab 2번 목록 끝 -->
					</div>
					<!-- Tab 전체 목록 구현 끝 -->

				</div>
			</div>
			<% 
		
													} catch (SQLException e) {
														e.printStackTrace();
														out.println("DB Driver Error!");

													}
		
												%>
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