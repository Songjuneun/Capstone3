<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}

	/* 값 가져오기 */
	String company = request.getParameter("company");
	int gno = Integer.parseInt(request.getParameter("gno"));
	int year = Integer.parseInt(request.getParameter("year"));
	String dept = request.getParameter("dept");
	
	/* 수정 내용 불러오기 */
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs1 = null;
	String query1 = "";
	
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcID = "root";
		String jdbcPW = "rootpass";
		
		conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
		query1 = "select * from passInfo where pass_company = '" + company + "' and pass_gno = " + gno;
		
		stmt = conn.createStatement();
		rs1 = stmt.executeQuery(query1);
		
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> 취업 </title>

    <!-- Bootstrap -->
    <link href="./Resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->f
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="./Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Dropzone.js -->
    <link href="./Resources/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="./Resources/build/css/custom.min.css" rel="stylesheet">

<!-- 내용추가 -->
	<script>
		var arrInput = new Array(0);
		var arrInputValue = new Array(0);
		 
		function addInput() {
		  arrInput.push(arrInput.length);
		  arrInputValue.push("");
		  display();
		}
		 
		function display() {
		  document.getElementById('here').innerHTML="";
		  for (intI=0;intI<arrInput.length;intI++) {
		    document.getElementById('here').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
		  }
		}
		 
		function saveValue(intId,strValue) {
		  arrInputValue[intId]=strValue;
		  	  
		}  
		 
		function createInput(id,value) {
			
			var titile;
			var line;
			
			if(id%2 == 0){
				title = "질문";
				line = 2;
			}
			else {
				title = "내용";
				line = 10;
			}
			
			return  "<br><div class='form-group' >" +
						"<label  class='control-label col-md-3 col-sm-3 col-xs-12'>"+ title + "<span  class='required'>*</span></label>" +
						"<div class='col-md-9 col-sm-9 col-xs-12'>" +
							"<textarea class='form-control' rows=" + line + " id='text" + id + "' onChange='javascript:saveValue(" + id + ",this.value)' value='" + value + "'></textarea>" +
						"</div>" +
					"</div>" +
					"<div class='col-md-9 col-sm-9 col-xs-12 col-md-offset-3'>" +
				       	"<button  class='btn btn-dark'  onclick='deleteInput();'> 삭제</button>" +
					"</div>"
					;}
		 
		function deleteInput() {
		  if (arrInput.length > 0) { 
		     arrInput.pop(); 
		     arrInputValue.pop();
		  }
		  display(); 
		}
	</script>

  </head>

  <body class="nav-md">
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
                <h3> 수정 </h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <!-- ------------------------------------양식 삽입------------------------------------------------- -->
       			<div class="x_panel">
				<div class="x_title">
					<h2> <small></small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
						<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
							<ul class="dropdown-menu" role="menu">
							<li><a href="#">Settings 1</a>
							</li>
							<li><a href="#">Settings 2</a>
							 </li>
							</ul>
						</li>
						<li><a class="close-link"><i class="fa fa-close"></i></a></li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<br>
					<form class="form-horizontal form-label-left">
	
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12">연도</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name = "companyContent" class="form-control" value=<%=year %>>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12">기업명</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name = "companyContent" class="form-control" value=<%=company %>>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12">분야</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="deptContent" class="form-control" value=<%=dept %>>
							</div>
						</div>
	
						<%
							while( rs1.next() ) {
								String question = rs1.getString("pass_question");
								String answer = rs1.getString("pass_answer");
						%>
	
						<div class="form-group" >
							<label class="control-label col-md-3 col-sm-3 col-xs-12">질문<span class="required">*</span>
							</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
							<textarea class="form-control" name = "qContent" rows="2"> <%=question %> </textarea>
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-md-3 col-sm-3 col-xs-12">내용<span class="required">*</span>
							</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
							<textarea class="form-control" rows="10" name="aContent"> <%=answer %> </textarea>
							</div>
						</div>
						
						
						<% } %>
						
						<div id="here"></div>
						
					</form>
					
					<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
						<button  class="btn btn-default"  onclick="addInput()"> 내용추가 </button>
						<button  class="btn btn-dark" onClick="javascript:location.repalce('PassModifyProc.jsp')"> 저장 </button>
                    	<button  class="btn btn-dark" onClick="javascript:location.replace('PassList_copy.jsp')"> 취소</button>
					</div>
					
				</div>
				</div>
            <!-- 양식 끝/// -->
            
          </div>
        </div> 
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            	한국교통대학교 <a href="https://colorlib.com"> 소프트웨어학과 </a>
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
    
    
    <%
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	}
	%>  
  
  </body>
</html>