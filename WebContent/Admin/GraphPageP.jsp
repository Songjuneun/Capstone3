<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
%>

<%
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String num = "";
		String company = "";
		String dept = "";
		Float score = (float)0; 
		int toeic = 0;
		int toss = 0;
		int opic = 0;
	
		int certificate = 0;
		int awards = 0;
		int intern = 0;
		int overseas = 0;
		int volunteer = 0;
		
		//---------------------- 페이지의 크기와 페이지 집합의 크기 지정
		int TotalRecord = 0;
		int TotalPage =0;	//전체 페이지 수
		int TotalPageSet = 0;	// 전체 페이지 집합의 수
		int CurrentPageSet = 0;	// 현재 페이지 집합
		int CurrentPage=0;	// 현재 페이지
		
		int PageRecord = 10;	//한 페이지에 띄워지는 목록 수
		int PageSet = 5;		//한 집합의 페이지 수
		
		//----------페이지 번호 전달이 없을 경우 페이지 번호의 지정
		if( request.getParameter("CurrentPage") == null ) {
			CurrentPage = 1;
		} else{
			CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));
		}
		
		//----------------------------------페이지별 시작 레코드 인덱스 추출
		int FirstRecord = PageRecord*(CurrentPage - 1);
		
		
	
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
			String jdbcID = "root";
			String jdbcPW = "rootpass";
			
			conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
			
			String sql = "select num, company, dept, score, toeic, toss, opic, certificate, awards, intern, overseas, volunteer from specinfo group by num desc limit 10";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> 취업 </title>

	<!-- ChartJS -->
	<script src="//www.google-analytics.com/analytics.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<script src="../Resources/utils.js"></script>
	
	<style>
	canvas{
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
	
	<style type="text/css">/* Chart.js */
		@keyframes chartjs-render-animation{
		from{opacity:.99}to{opacity:1}}.chartjs-render-monitor{animation:chartjs-render-animation 1ms}.chartjs-size-monitor,.chartjs-size-monitor-expand,.chartjs-size-monitor-shrink{position:absolute;direction:ltr;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1}.chartjs-size-monitor-expand>div{position:absolute;width:1000000px;height:1000000px;left:0;top:0}.chartjs-size-monitor-shrink>div{position:absolute;width:200%;height:200%;left:0;top:0}
	</style>

    <!-- Bootstrap -->
    <link href="../Resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Dropzone.js -->
    <link href="../Resources/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Custom Theme Style -->
    <link href="../Resources/build/css/custom.min.css" rel="stylesheet">
    
    <script>
	    /* 정보전달 */
		function CheckForm(form) {
			form.submit();
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
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                      <button type="button" class="btn btn-default" onClick="javascript:location.replace('GraphInsert.jsp')"> 추가 </button>
                    </span> 
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

			<%
                  	while(rs.next()) {
                  	
	                  	num = Integer.toString(rs.getInt("num"));
	       				company = rs.getString("company");
	       				dept = rs.getString("dept");
	       				score = rs.getFloat("score"); /* /4.5*100 */
	       				toeic = rs.getInt("toeic");
	       				toss = Integer.parseInt(rs.getString("toss").replaceAll("[^0-9]", ""));
	       				opic = 0;
	       				
	       				if(rs.getString("opic").equals("AL")){
	       					opic = 10;
	       				} else if(rs.getString("opic").equals("IH")){
	       					opic = 6/7 * 10;
	       				} else if(rs.getString("opic").equals("IM")){
	       					opic = 5/7 * 10;
	       				} else if(rs.getString("opic").equals("IL")){
	       					opic = 4/7 * 10;
	       				} else if(rs.getString("opic").equals("NH")){
	       					opic = 3/7 * 10;
	       				} else if(rs.getString("opic").equals("NM")){
	       					opic = 2/7 * 10;
	       				} else if(rs.getString("opic").equals("NL")){
	       					opic = 1/7 * 10;
	       				}
	       				
	       				certificate = rs.getInt("certificate");
	       				awards = rs.getInt("awards");
	       				intern = rs.getInt("intern");
	       				overseas = rs.getInt("overseas");
	       				volunteer = rs.getInt("volunteer");
	       				System.out.println(num + " " + company + " " + dept + "  " + score + " " + opic + " " + volunteer );
       		%>

                <!-- ------------------------------------양식 삽입------------------------------------------------- -->
                <div class="col-md-6 col-sm-6 col-xs-12">	
                    <div class="x_panel">
                        <div class="x_title">
                            <h2> <%=company %>
                                <small><%=dept %></small>
                            </h2>&nbsp&nbsp
                    		<button type="button" class="btn btn-default" onClick="javascript:location.replace('GraphModify.jsp?num=<%=num%>')"> 수정</button>
                            <button type="button" class="btn btn-dark" onClick="javascript:location.replace('GraphDelete.jsp?num=<%=num%>')"> 삭제 </button>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                       aria-expanded="false"><i class="fa fa-wrench"></i></a>
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

                        <!-- 그래프 삽입 -->
                        <div class="x_content">
                            <div style="width:75%;">
                                <div class="chartjs-size-monitor">
                                    <div class="chartjs-size-monitor-expand">
                                        <div class=""></div>
                                    </div>
                                    <div class="chartjs-size-monitor-shrink">
                                        <div class=""></div>
                                    </div>
                                </div>
                                <canvas id=<%=num %> style="display: block; width: 1428px; height: 714px;" width="1428" height="714" class="chartjs-render-monitor"></canvas>
                            </div>

                        </div>
                        <!-- 그래프 end -->
						
						
						
                    </div>
                </div>               	
               	
               	<script>
				var ctx = document.getElementById(<%=num%>).getContext('2d');
				    var config = new Chart(ctx, {
				        type: 'line',
				        data: {
				            labels: ['학점', '토익', '토스', '오픽', '자격증', '수상', '인턴', '해외경험', '봉사'],
				            datasets: [{
				                label: '평균',
				                backgroundColor: window.chartColors.gray,
				                borderColor: window.chartColors.gray,
				                data: [
				                	<%=score%>/4.5 * 10,
									<%=toeic%>/990 * 10,
									<%=toss%>/7 * 10,
									<%=opic%>/7 * 10,
									<%=certificate%>,
									<%=awards%>,
									<%=intern%>,
									<%=overseas%>,
									<%=volunteer%>
				                ],
				                fill: false,
				            }]
				        },
				        options: {
				            responsive: true,
				            title: {
				                display: true,
				                text: ''
				            },
				            tooltips: {
				                mode: 'index',
				                intersect: false,
				            },
				            hover: {
				                mode: 'nearest',
				                intersect: true
				            },
				            scales: {
				                xAxes: [{
				                    display: true,
				                    scaleLabel: {
				                        display: true,
				                        labelString: '평균'
				                    }
				                }],
				                yAxes: [{
				                    display: true,
				                    scaleLabel: {
				                        display: true,
				                        labelString: '(%)'
				                    }
				                }]
				            }
				        }
				    });  
			</script>
               	
               	<%   	
					}	
				%>
				
		        <!-- 페이지 넘버 -->
                  	<div class="row">
                  	<div class="col-sm-7">
                   	<div class="dataTables_paginate paging_simple_numbers" id="datatable-fixed-header_paginate">
                    	<ul class="pagination">
                    		
                    		<%
                    			TotalPage  = (int) Math.ceil( (double)TotalRecord/PageRecord );
                    			TotalPageSet = (int) Math.ceil( (double)TotalPage/PageSet );
                    			CurrentPageSet = (int) Math.ceil( (double)CurrentPage/PageSet );
                    			
                    			if( CurrentPageSet > 1) {
                    				int BeforePageSetLastPage = PageSet * (CurrentPageSet-1);
                    				String retUrl = "GraphPageP.jsp?CurrentPage=" + BeforePageSetLastPage;
                    		%>		                    	
	                    	<li class="paginate_button next" id="datatable-fixed-header_next">
	                    	<a href=<%=retUrl %> aria-controls="datatable-fixed-header" data-dt-idx="0" tabindex="0">Previous</a>
	                    	</li>
	                    	
	                    	
	                    	<%
								}
	                    		
                    			int FirstPage = PageSet * (CurrentPageSet - 1);
                    			int LastPage = PageSet * CurrentPageSet;
                    			
                    			if(CurrentPageSet == TotalPageSet) {
                    				LastPage = TotalPage;
                    			}
                    			
                    			for( int i = FirstPage + 1; i <= LastPage; i++) {
                    				
                    				if( CurrentPage == i ) {	
                    		%>
                    		
                    		<!-- 현재 페이지 집합 띄우기 -->
                    		<li>
	                    	<a href="#" aria-controls="datatable-fixed-header" data-dt-idx="1" tabindex="0"> <b> <%=i %></b></a>
	                    	</li>
                    					
                    		<%
                    				} else {
                    					String retUrl = "GraphPageP.jsp?CurrentPage="+i;
                    					%>
                    		
                    					<!-- 현재 페이지 집합 띄우기 -->
		                    		<li class="paginate_button active">
			                    	<a href=<%=retUrl %> aria-controls="datatable-fixed-header" data-dt-idx="1" tabindex="0"><%=i %></a>
			                    	</li>
                    					
                    		<%	
                    				}
                    				
                    			}
	                    	%>
	                    	
	                    	
	                    	
	                    	<li class="paginate_button next" id="datatable-fixed-header_next">
		                    	<%
		                    		if(TotalPageSet > CurrentPageSet) {
		                    			int NextPageSet = PageSet * CurrentPageSet + 1;
		                    			String retUrl = "GraphPageP.jsp?CurrentPage=" + NextPageSet;
		                		%>
	                    		<a href=<%=retUrl %> aria-controls="datatable-fixed-header" data-dt-idx="7" tabindex="0">Next</a>
	                    		<%
	                    			}
		                    	%>
	                    	</li>
	                    	
                    	</ul>
                   	</div>
                  	</div>
                  	</div>
                  	<!-- 페이지 넘버 끝 -->
                    	
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


<%
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} 
%>

</body>
</html>