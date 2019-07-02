<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
</head>
<body>
	<div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/img.jpg" alt=""> <%= session.getAttribute("signedUser") %>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>설정</span>
                      </a>
                    </li>
                    <li><a href="javascript:;"> 회원 정보 수정 </a></li>
                    <li><a href="logout.jsp"><i class="fa fa-sign-out pull-right"></i> 로그아웃 </a></li>
                  </ul>
                </li>
                
              </ul>
            </nav>
          </div>
    </div>
</body>
</html>