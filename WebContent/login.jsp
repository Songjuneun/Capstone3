<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("utf-8"); %>


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
    <!-- Font Awesome -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="./Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="./Resources/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="./Resources/build/css/custom.min.css" rel="stylesheet">
  	
  	<script type = "text/javascript">
  		function CheckForm(form) {
  			
  			if(!form.id_Value.value) {
  				alert("아이디를 입력하세요.");
  				form.id_Value.focus();
  				return true;
  			}
  			if(!form.pass_Value.value){
  				alert("패스워드를 입력하세요.");
  				form.pass_Value.focus();
  				return true;
  			}
  			form.submit();
  		}
  		
		function CheckForm2(form) {
  			
  			if(!form.id_Value2.value) {
  				alert("아이디를 입력하세요.");
  				form.id_Value2.focus();
  				return true;
  			}
  			if(!form.pass_Value2.value){
  				alert("패스워드를 입력하세요.");
  				form.pass_Value2.focus();
  				return true;
  			}
  			if(!form.department_Value.value){
  				alert("전공을 입력하세요.");
  				form.department_Value.focus();
  				return true;
  			}
  			if(!form.score_Value.value){
  				alert("학점을 입력하세요.");
  				form.score_Value.focus();
  				return true;
  			}
  			if(!form.toeic_Value.value){
  				alert("토익 점수를 입력하세요.");
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

  <body class="login">
  
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form name = "login" action="authentication.jsp" method="post">
              <h1>로그인</h1>
              <div>
                <input type="text" name = "id_Value" class="form-control" placeholder="아이디" required="" />
              </div>
              <div>
                <input type="password" name = "pass_Value" class="form-control" placeholder="비밀번호" required="" />
              </div>
              <div>
                <a class="btn btn-default submit" onClick="javascript:CheckForm(login)">로그인</a>
                <a class="reset_pass" href="#">패스워드를 잃어버리셨습니까?</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">계정을 만들고 싶다면?
                  <a href="#signup" class="to_register"> 회원가입 </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> 원터치!</h1>
                  <p>©2019 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form name="signup" action="signupDB.jsp" method="post">
              <h1>회원가입</h1>
              <div>
             	<input type="text" name = "id_Value2" class="form-control" placeholder="아이디" required="" />
              </div>
              <div>
                <input type="password" name = "pass_Value2" class="form-control" placeholder="패스워드" required="" />
              </div>
              <small>- 획득하지 못하였거나 없을 시, 0으로 기재해세요. - </small>
              <div>
                <input type="text" name = "department_Value" class="form-control" placeholder="전공" required="" />
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
              <div>
                <a class="btn btn-default submit" onClick="javascript:CheckForm2(signup)">회원가입</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">이미 회원입니까?
                  <a href="#signin" class="to_register"> 로그인 </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> 원터치!</h1>
                  <p>©2019 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
    
  </body>
</html>
