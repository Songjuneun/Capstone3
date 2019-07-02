<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<html>

<head>
</head>

<body class="nav-md">
   
      <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="home.jsp" class="site_title"><i class="fa fa-paw"></i> <span> ABC </span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><%= session.getAttribute("signedUser") %></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
			<div class="menu_section">
                <h3> 메뉴 </h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="home.jsp">지역 정보</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-edit"></i> 합격 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="tables.jsp"> 합격 자소서 키워드 매칭 </a></li>
                      <li><a href="PassList.jsp"> 합격자소서 </a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-desktop"></i> 자소서 관리 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="MyForm.jsp"> 자소서 작성 </a></li>
                      
                    </ul>
                  </li>
                  <li><a><i class="fa fa-table"></i> 마이페이지 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="UserList.jsp"> 회원관리</a></li>
                      <li><a href="PassList_copy.jsp"> 합격자소서관리</a></li>
                      <li><a href="PassInsert.jsp"> 합격자소서입력</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> 스펙 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="GraphPageP.jsp"> 스펙 비교 </a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-clone"></i> 자격 정보 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="base.jsp"> 자격증 </a></li>
                    </ul>
                  </li>
                </ul>
              </div>
             </div>
            <!-- /sidebar menu -->

			<!-- 생각해보고 생략하기 -->
            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>
</body>
</html>