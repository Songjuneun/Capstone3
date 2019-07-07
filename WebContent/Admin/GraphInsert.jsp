<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>

<%
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
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
    <link href="../Resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Dropzone.js -->
    <link href="../Resources/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../Resources/build/css/custom.min.css" rel="stylesheet">
	
	<script>
		/* 정보전달 */
		function CheckForm(form) {
			if(!form.department_Value.value) {
				alert("전공을 입력하세요.");
				form.department_Value.focus();
				return true;
			}
			if(!form.score_Value.value) {
				alert("학점을 입력하세요.");
				form.score_Value.focus();
				return true;
			}
			if(!form.toeic_Value.value) {
				alert("토익을 입력하세요.");
				form.toeic_Value.focus();
				return true;
			}
			if(!form.awards_Value.value){
  				alert("수상 횟수를 입력하세요.");
  				form.awards_Value.focus();
  				return true;
  			}
  			if(!form.intern_Value.value){
  				alert("인턴 횟수을 입력하세요.");
  				form.intern_Value.focus();
  				return true;
  			}
  			
  			if(!form.overseas_Value.value){
  				alert("해외경험 횟수를 입력하세요.");
  				form.overseas_Value.focus();
  				return true;
  			}
  			if(!form.volunteer_Value.value){
  				alert("봉사 횟수를 입력하세요.");
  				form.volunteer_Value.focus();
  				return true;
  			}
  			if(!form.certificate_Value.value){
  				alert("자격증을 입력하세요.");
  				form.certificate_Value.focus();
  				return true;
  			}
			form.submit();
  		}
		
		function onlyNumber(event){
  		    event = event || window.event;
  		    var keyID = (event.which) ? event.which : event.keyCode;
  		    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 110) 
  		        return;
  		    else
  		        return false;
  		}
  		function removeChar(event) {
  		    event = event || window.event;
  		    var keyID = (event.which) ? event.which : event.keyCode;
  		    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 110) 
  		        return;
  		    else
  		        event.target.value = event.target.value.replace(/[^0-9>]/g, "");
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
                <h3> 스펙 </h3>
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
            <div class="col-md-12 col-sm-12 col-xs-12"  style="width:80%;padding-left:20%">
	             <div class="x_panel">
		             <div class="x_title">
		               <h2>스펙관리 <small>스펙 정보</small></h2>
		               <ul class="nav navbar-right panel_toolbox">
		                 <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
		                 </li>
		                 <li class="dropdown">
		                   <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
		                   <ul class="dropdown-menu" role="menu">
		                     <li><a href="#">Settings 1</a>
		                     </li>
		                     <li><a href="#">Settings 2</a>
		                     </li>
		                   </ul>
		                 </li>
		                 <li><a class="close-link"><i class="fa fa-close"></i></a>
		                 </li>
		               </ul>
		               <div class="clearfix"></div>
		             </div>
		             
	           		 <div class="x_content">
	            
			            <div  style="width:80%; padding-left:20%">
					      <section class="login_content" >
					        <form name="GraphInsert" action="GraphInsertProc.jsp" method="post">
					          <div >
					            <input type="text" name = "company_Value" class="form-control" placeholder="기업명" required="" />
					          </div>
					          <div>
					            <input type="text" name = "department_Value" class="form-control" placeholder="분야" required="" />
					          </div>
					          <div>
					            <input type="text" name = "univ_Value" class="form-control" placeholder="대학교" required="" />
					          </div>
					           <div>
					            <input type="text" name = "line_Value" class="form-control" placeholder="학과" required="" />
					          </div>
					          <div>
					            <input type="text" name = "score_Value" class="form-control" placeholder="학점" required="" style ='ime-mode:inactive'/>
					          </div>
					          <div>
					            <input type="text" name = "toeic_Value" class="form-control" placeholder="토익" required=""	onkeydown='return onlyNumber(event)'  onkeyup='removeChar(event)'/>
					          </div>
					          <table>
					          	<tr>
					          		<td>토스</td>
					           	<td><input type="radio" name="toss_Value" value="없음" checked>없음</td>
					           	<td><input type="radio" name="toss_Value" value="L1">L1</td>
					           	<td><input type="radio" name="toss_Value" value="L2">L2</td>
					           	<td><input type="radio" name="toss_Value" value="L3">L3</td>
					           	<td><input type="radio" name="toss_Value" value="L4">L4</td>
					           	<td><input type="radio" name="toss_Value" value="L5">L5</td>
					           	<td><input type="radio" name="toss_Value" value="L6">L6</td>
					           	<td><input type="radio" name="toss_Value" value="L7">L7</td>
					           	<td><input type="radio" name="toss_Value" value="L8">L8</td>
					          	</tr>
					          	<tr><td><br></td></tr>
					          	<tr>
					           	<td>오픽</td>
					           	<td><input type="radio" name="opic_Value" value="없음">없음</td>
					           	<td><input type="radio" name="opic_Value" value="NL" checked>NL</td>
					           	<td><input type="radio" name="opic_Value" value="NM">NM</td>
					           	<td><input type="radio" name="opic_Value" value="NH">NH</td>
					           	<td><input type="radio" name="opic_Value" value="IL">IL</td>
					           	<td><input type="radio" name="opic_Value" value="IM">IM</td>
					           	<td><input type="radio" name="opic_Value" value="IH">IH</td>
					           	<td><input type="radio" name="opic_Value" value="AL">AL</td>
					          	</tr>
					          </table>
					          <BR>
					          <div>
					            <input type="text" name = "awards_Value" class="form-control" placeholder="수상횟수" required="" 	onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'/>
					          </div>
					          <div>
					            <input type="text" name = "intern_Value" class="form-control" placeholder="인턴횟수" required=""   onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' />
					          </div>
					          <div>
					            <input type="text" name = "overseas_Value" class="form-control" placeholder="해외경험 횟수" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' >
					          </div>
					          <div>
					            <input type="text" name = "volunteer_Value" class="form-control" placeholder="봉사횟수" required="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' />
					          </div>
					          <div>
					            <input type="text" name = "certificate_Value" class="form-control" placeholder="자격증" required="" />
					          </div>
					          <button  class="btn btn-dark" onClick="javascript:CheckForm(GraphInsert)"> 저장 </button>
					        </form>
					      </section>
					    </div>
			           
			         </div>
			     </div>
		     </div>
            
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
    <script src="../Resources/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../Resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../Resources/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../Resources/vendors/nprogress/nprogress.js"></script>
    <!-- Dropzone.js -->
    <script src="../Resources/vendors/dropzone/dist/min/dropzone.min.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="../Resources/build/js/custom.min.js"></script>
  </body>
</html>