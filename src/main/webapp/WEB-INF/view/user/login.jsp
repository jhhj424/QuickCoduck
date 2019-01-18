<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_signup.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<spring:url value="/resources/css/login.css" var="login" />
<link href="${login}" rel="stylesheet" />
<style>
span,label{
color:#2c2c2c;
}
</style>
</head>
<body>

<div style="height:600px;">

<div class="box1"style="text-align:left;">
   <section id="formHolder">
         <!-- Form Box -->
         <div class="col-sm-6 form" style="max-width:80%;left: 50%;top: 50%;transform: translate(-50%, -50%);">
            <!-- Login Form -->
            <div class="login form-peice"style="border: 1px solid #444444;">
               <form class="login-form" action="login.duck" method="post">
                  <div class="form-group">
                     <label for="loginid">Id</label>
                     <input type="text" name="userid" id="loginid" required style="border-bottom:1px solid #000">
                  </div>

                  <div class="form-group">
                     <label for="loginPassword">Password</label>
                     <input type="password" name="pass" id="loginPassword" required style="border-bottom:1px solid #000">
                  </div>

                  <div class="CTA">
                     <input type="submit" value="Login" class="login">
                     <a href="#" class="switch">SignUp</a>
                  </div>
				</form>
            </div><!-- End Login Form -->

            <!-- Signup Form -->
            <div class="signup form-peice switched"style="border: 1px solid #444444;">
               <form class="signup-form" action="userEntry.duck" method="post">
               <label for="type">Type</label>
                  <div class="form-group"style="text-align:center;">
					<input type="radio" name="type" id="user_type" class="input-hidden" value="1" checked="checked" />
					<label for="user_type"> <img src="../workpic/d3.jpg" /></label>
					<span>&nbsp;<i class="fa fa-user"></i> User</span>&nbsp;
					<input type="radio" name="type" id="client_type"class="input-hidden" value="2" />
					<label for="client_type"> <img src="../workpic/d3.jpg" /></label>
					<span>&nbsp;<i class="fa fa-user-secret"></i> Client</span>&nbsp;
                  </div><br>
				  <div class="form-group">
                     <label for="id">ID</label>
                     <input type="text" name="userid" id="user_id" class="name" style="border-bottom:1px solid #000">
                     <span class="error"></span>
                  </div>

                  <div class="form-group">
                     <label for="email">Email Adderss</label>
                     <input type="email" name="email" id="user_email" class="email" style="border-bottom:1px solid #000">
                     <span class="error"></span>
                  </div>

                  <div class="form-group">
                     <label for="password">Password</label>
                     <input type="password" name="pass" id="user_password" class="pass" style="border-bottom:1px solid #000">
                     <span class="error"></span>
                  </div>

                  <div class="form-group">
                     <label for="passwordCon">Confirm Password</label>
                     <input type="password" name="pass2" id="user_passwordCon" class="passConfirm" style="border-bottom:1px solid #000">
                     <span class="error"></span>
                  </div>
                  <div class="CTA">
                     <input type="submit" value="Signup Now" class="signup">
                     <a href="#" class="switch">Login</a>
                  </div>
               </form>
            </div><!-- End Signup Form -->
         </div>         
   </section>   
</div>
</div>

</body>
</html>