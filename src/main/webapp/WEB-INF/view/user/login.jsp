<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_signup.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<spring:url value="/resources/css/login.css" var="login" />
<link href="${login}" rel="stylesheet" />
<style>
span,label{
color:#2c2c2c;
}
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- (2) LoginWithNaverId Javscript SDK -->
	<script src="/js/naveridlogin_js_sdk_2.0.0.js"></script>

	<!-- (3) LoginWithNaverId Javscript 설정 정보 및 초기화 -->
	<script>
		var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "hZgcybLLosz6OTLjGrZm",
				callbackUrl: "http://localhost:8080/quickcoduck/user/main.duck",
				isPopup: true,
				loginButton: {color: "green", type: 3, height: 45}
			}
		);
		/* (4) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
		//alert(naverLogin)
		naverLogin.init();
		
		/* (4-1) 임의의 링크를 설정해줄 필요가 있는 경우 */
		$("#gnbLogin").attr("href", naverLogin.generateAuthorizeUrl());

		/* (5) 현재 로그인 상태를 확인 */
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) {
				if (status) {
					alert(status)
					/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고 사용자 정보를 출력합니다. */
					setLoginStatus();
				}
			});
		});

		/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고 사용자 정보를 출력합니다. */
		function setLoginStatus() {
			var profileImage = naverLogin.user.getProfileImage();
			var uniqId = naverLogin.user.getId();
			$("#naverIdLogin_loginButton").html('<br><br><img src="' + profileImage + '" height=50 /> <p>' + uniqId + '님 반갑습니다.</p>');
			$("#gnbLogin").html("Logout");
			$("#gnbLogin").attr("href", "${url}");
			/* (7) 로그아웃 버튼을 설정하고 동작을 정의합니다. */
			$("#gnbLogin").click(function () {
				naverLogin.logout();
				location.reload();
			});
		}
	</script>

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
                  <br>
				  <div id="naverIdLogin" align="center">
				  	<a id="naverIdLogin_loginButton" href="${url}" role="button">
				  		<img src="https://static.nid.naver.com/oauth/big_g.PNG" width="250" height="45" >
				  	</a>
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