<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	if(session.getAttribute("signedUser") == null) { 
		response.sendRedirect("logout.jsp");
	}
	
	String search_Input = request.getParameter("search_Input");
	String encoded_search = "";
	if (search_Input != null) {
	    encoded_search = URLEncoder.encode(search_Input,"utf-8");
	} else {
	    search_Input ="";
	}	


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


	Connection conn = null;
	Statement stmt = null;
	ResultSet rs1 = null;
	ResultSet rs2= null;
	String query1 = "";
	String query2 = "";
	
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcURL = "jdbc:mysql://localhost:3306/capstonedb";
		String jdbcID = "root";
		String jdbcPW = "rootpass";
		
		conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
		
		if (search_Input.equals("")){
			query1 = "select distinct pass_gno, pass_company, pass_dept, pass_year from passInfo order by pass_gno asc limit " + FirstRecord + ", " + PageRecord;
			query2 = "select count(pass_gno) from passInfo";
		} else {
			query1 = "select distinct pass_gno, pass_company, pass_dept, pass_year from passInfo where pass_company like '%" + search_Input + "%'  order by pass_gno asc limit " + FirstRecord + ", " + PageRecord;
			query2 = "select count(pass_gno) from passInfo  where pass_company like '%" + search_Input + "%'";
		}
		
		
		
		stmt = conn.createStatement();
		rs1 = stmt.executeQuery(query1);
		
		stmt = conn.createStatement();
		rs2 = stmt.executeQuery(query2);
		rs2.next();
		
		TotalRecord = rs2.getInt(1);
			
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> 취업 </title>

    <!-- Bootstrap -->
    <link href="./Resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="./Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Dropzone.js -->
    <link href="./Resources/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="./Resources/build/css/custom.min.css" rel="stylesheet">
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
                  <form name="Search" action="PassList.jsp" method="post">
                  <div class="input-group">
                    <input type="text" name="search_Input" class="form-control" placeholder="기업명 검색">
                    <span class="input-group-btn">
                      <button class="btn btn-default">Go!</button>
                    </span>
                  </div>  
             	</form>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <!----------------------- 양식 삽입 ---------------------------------->		<!-- 그룹사, 제목, 지원분야 -->
        	<div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>합격 자소서 <small>상위 10대 기업</small></h2>
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
                    <div id="datatable-fixed-header_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                    <div class="col-sm-12">
	                    <table id="datatable-fixed-header" class="table table-striped table-bordered dataTable no-footer" role="grid" aria-describedby="datatable-fixed-header_info">
	            		<center>
	                    <thead>
	                        <tr role="row">
	                        <th class="sorting_asc" tabindex="0" aria-controls="datatable-fixed-header" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >..</th>
	                        <th class="sorting_asc" tabindex="0" aria-controls="datatable-fixed-header" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 189px;">기업명</th>
	                        <th class="sorting" tabindex="0" aria-controls="datatable-fixed-header" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 310px;">연도</th>
	                        <th class="sorting" tabindex="0" aria-controls="datatable-fixed-header" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 143px;">분야</th>
	                        </tr>
	                   	</thead>
	
	                      	<tbody>	        
		                      	<% 
							        while(rs1.next()) {
							        	int gno = rs1.getInt("pass_gno");
										String company = rs1.getString("pass_company");
										String dept = rs1.getString("pass_dept");
										int year = rs1.getInt("pass_year");
								%>                   
	                      	<tr role="row" class="even">			<!-- gno같을경우 하나만 나오게 만들기 -->
	                      	  <td><input type="checkbox" name="toss_Value" value="L1"></td>
	                          <td class="sorting_1"> <%=company %> </td>
	                          <td>	<!------- page, 목록 번호(pass_num), encoded_key(fhrmdls) ------->
	                          		<a href = "PassContent.jsp?CurrentPage=<%=CurrentPage%>&search_Input=<%=encoded_search %>&company=<%=company%>&dept=<%=dept%>&gno=<%=gno%>">
	                          			<%=year%>년도 합격자소서
	                          		</a>
		                           <%-- <A HREF="BoardContent.jsp?column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage %>">
		                           <%=year%>년도 합격자소서
		                           </A>  --%>
 	                          </td>
	                          <td> <%=dept %> </td>   
	                          <% } %>
	                        </tr>
	                        </tbody>
	                        </center>
	                        
	                    </table>
                    </div>
                    </div>
                    	<!-- 페이지 넘버 -->
                    	<div class="row">
                    	<div class="col-sm-7">
                    	<button type="button" class="btn btn-dark"> 추가 </button>
                    	<button type="button" class="btn btn-dark"> 수정 </button>
                    	<button type="button" class="btn btn-default"> 삭제</button>
	                    	<div class="dataTables_paginate paging_simple_numbers" id="datatable-fixed-header_paginate">
		                    	<ul class="pagination">
		                    		
		                    		<%
		                    			TotalPage  = (int) Math.ceil( (double)TotalRecord/PageRecord );
		                    			TotalPageSet = (int) Math.ceil( (double)TotalPage/PageSet );
		                    			CurrentPageSet = (int) Math.ceil( (double)CurrentPage/PageSet );
		                    			
		                    			if( CurrentPageSet > 1) {
		                    				int BeforePageSetLastPage = PageSet * (CurrentPageSet-1);
		                    				String retUrl = "PassList.jsp?CurrentPage=" + BeforePageSetLastPage;
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
		                    					String retUrl = "PassList.jsp?CurrentPage="+i;
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
				                    			String retUrl = "PassList.jsp?CurrentPage=" + NextPageSet;
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

<%
	} catch(SQLException e) {
		e.printStackTrace();
		out.println("DB Driver Error!");
	} finally {
        rs1.close();
        rs2.close();
        conn.close();
        stmt.close();
    }
%>
</body>
</html>