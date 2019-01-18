<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/style/start_middle.jsp" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/WEB-INF/view/style/user_signup.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Quick Coduck</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<style>
span,label{
color:#2c2c2c;
}
</style>
<spring:url value="/resources/css/login.css" var="login" />
<spring:url value="/resources/css/full-page-scroll.css" var="mainCss" />
<spring:url value="/resources/js/full-page-scroll.js" var="jqueryJs" />

<link href="${login}" rel="stylesheet" />
<link href="${mainCss}" rel="stylesheet" />
<script src="${jqueryJs}"></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>

<style>
body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size: 16px;}
img {margin-bottom: -8px;}
.mySlides {display: none;}
span{
text-color:red;
}
</style>
</head>
<body class="w3-content" style="max-width:100%;">
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
		naverLogin.init();
		
		/* (4-1) 임의의 링크를 설정해줄 필요가 있는 경우 */
		$("#gnbLogin").attr("href", naverLogin.generateAuthorizeUrl());

		/* (5) 현재 로그인 상태를 확인 */
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) {
				if (status) {
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
<!-- Header with Slideshow -->
<div id="main" class="scroll-container">
<section class="section1">
<header class="w3-display-container w3-center" style="background-image:url( '../workpic/title7.jpg' );height:100%">
  <button class="w3-button w3-block w3-green w3-hide-large w3-hide-medium" onclick="document.getElementById('download').style.display='block'"><i class="fa fa-android"></i> <i class="fa fa-apple"></i> <i class="fa fa-windows"></i></button>
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/title1.jpg' );height:700px">
  </div>
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/d3.jpg' );height:700px">
  </div>
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/d4.png' );height:700px">
  </div>
  <!-- 화면 전환용 div -->
  <div class="bluelight">
	<a href="#">Quick Coduck</a>
  </div>
  <!-- 중앙에 아이언맨!! -->
 <div class="w3-display-left" style="margin:10px 280px 0px -30px">
      <h1 style="margin:0px 270px -5px -140px;font-size:35px;color:#000;font-weight:bold;text-shadow: -1px 2px 2px white;">Welcome to the Quick Coduck</h1>
      <h1 style="margin:0px 335px 0px 76px;font-size:28px;color:#000;font-weight:bold;text-shadow: -1px 2px 2px white;">Provide developers with OpenSource space and</h1>
      <h1 style="margin:0px 335px 0px 0px;font-size:28px;color:#000;font-weight:bold;text-shadow: -1px 2px 2px white;">based on your data Platform that provides</h1>
      <h1 style="margin:0px 335px 0px -64px;font-size:28px;color:#000;font-weight:bold;text-shadow: -1px 2px 2px white;">outsourcing through big data analysis</h1>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey"style="margin:15px 800px 0px 0px" onclick="document.getElementById('free').style.display='block'">Get for Free <i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="document.getElementById('free').style.display='block'"><i class="fa fa-angle-right"></i></a>
    </div>
 <div class="w3-display-right" style="margin:5px 150px 0px 0px">
      <h1 style="margin:0px 0px -5px 0px;font-size:42px;color:#000;font-weight:bold;text-shadow: 2px 1px 1px white;">Quick Coduck is back.</h1>
      <h1 style="margin:0px 350px 0px 0px;font-size:44px;color:#000;font-weight:bold;text-shadow: 2px 1px 1px white;">2019</h1>
      <h1 style="margin:-63px 172px 0px 0px;font-size:22px;color:#000;font-weight:bold;text-shadow: 2px 1px 1px white;">Jan23</h1>
      <h1 style="margin:-10px -15px 0px 0px;font-size:22px;color:#000;font-weight:bold;text-shadow: 2px 1px 1px white;">Made by Quick Coduck</h1>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey"style="margin:50px 260px 0px 0px" onclick="document.getElementById('login').style.display='block'">Get Login & SignUp<i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="plusDivs(1)"><i class="fa fa-angle-right"></i></a><br>
    </div>
</header>
</section>
<!-- The App Section -->
<section class="section2">
<div class="w3-padding-64 w3-white" style="height:970px;">
  <div class="w3-row-padding"style="padding-top:180px;">
    <div class="w3-col l8 m6">
      <h1 class="w3-jumbo"><b>The Web</b></h1>
      <h1 class="w3-xxxlarge w3-text-green"><b>Why Use it?</b></h1>
	   <p><span class="w3-xlarge">We Provide OpenSource Cloud.</span>
	    We provide opensource space for developers.Based on the data,
	    We provide better talent for clients. 
	    We reorganize and satisfy both sides with brokerage service.</p>
	  <button class="w3-button w3-light-grey w3-padding-large w3-section w3-hide-small" onclick="document.getElementById('free').style.display='block'">
        <i class="fa fa-download"></i>Get For Free
      </button>
      <p> Available for
       <i class="fa fa-github w3-xlarge"></i><i class="fa fa-git-square w3-xlarge"></i><i class="fa fa-github-alt w3-xlarge"></i>
       <i class="fa fa-windows w3-xlarge"></i><i class="fa fa-codepen w3-xlarge"></i><i class="fa fa-chrome w3-xlarge"></i>
       <i class="fa fa-internet-explorer w3-xlarge"></i><i class="fa fa-html5 w3-xlarge"></i><i class="fa fa-linux w3-xlarge"></i>
       <i class="fa fa-firefox w3-xlarge"></i><i class="fa fa-dropbox w3-xlarge"></i><i class="fa fa-mixcloud w3-xlarge"></i> <i class="fa fa-share-alt-square w3-xlarge"></i>
	  </p>
    </div>
    <div class="w3-col l4 m6">
      <img src="../workpic/QuickCoduck.jpg" class="w3-image w3-right w3-hide-small" width="335" height="471">
    </div>
  </div>
</div>
</section>

<!-- Clarity Section -->
<section class="section3">
<div class="w3-padding-64 w3-light-grey" style="height:970px;">
  <div class="w3-row-padding"style="padding-top:200px;">
    <div class="w3-col l4 m6">
      <img class="w3-image w3-round-large w3-hide-small w3-grayscale" src="../workpic/title3.jpg" alt="App" width="335" height="471">
    </div>
    <div class="w3-col l8 m6">
      <h1 class="w3-jumbo"><b>Clarity</b></h1>
      <h1 class="w3-xxxlarge w3-text-red"><b>Pixels, who?</b></h1>
      <p><span class="w3-xlarge">A revolution in resolution.</span> Sharp and clear photos with the world's best photo engine, incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
        ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
    </div>
  </div>
</div>
</section>
<!-- Features Section -->
<section class="section4">
<div class="w3-container w3-padding-64 w3-dark-grey w3-center" style="height:970px;">
  <h1 class="w3-jumbo"><b>Features</b></h1>
  <p>This web is easy to use.</p>

  <div class="w3-row" style="margin-top:64px">
    <div class="w3-col s3">
      <i class="fa fa-bolt w3-text-orange w3-jumbo"></i>
      <p>Fast</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-heart w3-text-red w3-jumbo"></i>
      <p>Loved</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-camera w3-text-yellow w3-jumbo"></i>
      <p>Clarity</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-battery-full w3-text-green w3-jumbo"></i>
      <p>Power</p>
    </div>
  </div>

  <div class="w3-row" style="margin-top:64px">
    <div class="w3-col s3">
      <i class="fa fa-diamond w3-text-white w3-jumbo"></i>
      <p>Sharp</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-cloud w3-text-blue w3-jumbo"></i>
      <p>Cloud</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-globe w3-text-amber w3-jumbo"></i>
      <p>Global</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-hdd-o w3-text-cyan w3-jumbo"></i>
      <p>Storage</p>
    </div>
  </div>
  
  <div class="w3-row" style="margin-top:64px">
    <div class="w3-col s3">
      <i class="fa fa-user w3-text-sand w3-jumbo"></i>
      <p>Safe</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-shield w3-text-orange w3-jumbo"></i>
      <p>Stabile</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-wifi w3-text-grey w3-jumbo"></i>
      <p>Connected</p>
    </div>
    <div class="w3-col s3">
      <i class="fa fa-image w3-text-pink w3-jumbo"></i>
      <p>HD</p>
    </div>
  </div>
</div>
</section>
<!-- Footer -->

<footer class="w3-container w3-padding-32 w3-light-grey w3-center w3-xlarge">
  <div class="w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
  <p class="w3-medium">Made by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank" class="w3-hover-text-green">w3.css</a></p>
</footer>
</div>

<!-- Modal -->
<div id="login" class="w3-modal w3-animate-opacity">
<div class="box1"style="text-align:left;">
   <section id="formHolder">
         <!-- Form Box -->
         <div class="col-sm-6 form" style="max-width:80%;left: 50%;top: 50%;transform: translate(-50%, -50%);">

            <!-- Login Form -->
            <div class="login form-peice"style="border: 1px solid #444444;">
            <i onclick="document.getElementById('login').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge" style="color:#000000;"></i>
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
            <i onclick="document.getElementById('login').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge" style="color:#000000;"></i>
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
<!-- 비회원 입장용 모달 -->
<div id="free" class="w3-modal w3-animate-opacity">
  <div class="w3-modal-content" style="padding:32px">
    <div class="w3-container w3-white">
      <i onclick="document.getElementById('free').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge"></i>
      <h2 class="w3-wide">비회원 입장</h2>
      <p>비회원으로 접근시 사용이 제한됩니다.</p>
      <p><i class="fa fa-copyright"></i>2019 QuickCoduck Corp</p>
      <button type="button" style="background-color:#f95959;color:#fff" class="w3-button w3-block w3-padding-large w3-margin-bottom" onclick="goReplace('../user/main.duck')">비회원 입장하기</button>
    </div>
  </div>
</div>
<!-- onclick 이벤트 스크립트 -->
<script type="text/javascript">
function goReplace(str) { location.replace(str); }
</script>
<!-- 페이징 스크롤 스크립트 -->
<script src="${jqueryJs}"></script>
<script type="text/javascript">
		new fullScroll({
			displayDots: true,
			dotsPosition: 'left',
			animateTime: 0.7,
			animateFunction: 'ease'
		});
	</script>
</body>
</html>
