<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/style/start_middle.jsp" %>
<%@include file="/WEB-INF/view/style/start_signup.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<style>
body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size: 16px;}
img {margin-bottom: -8px;}
.mySlides {display: none;}
</style>
<body class="w3-content" style="max-width:100%;">
<!-- Header with Slideshow -->
<header class="w3-display-container w3-center" style="background-image:url( '../workpic/title1.jpg' );height:700px">
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
      <h1 style="margin:0px 270px -5px -140px;font-size:35px;color:#ffffff;">Welcome to the Quick Coduck</h1>
      <h1 style="margin:0px 335px 0px 76px;font-size:28px;color:#ffffff;">Provide developers with OpenSource space and</h1>
      <h1 style="margin:0px 335px 0px 0px;font-size:28px;color:#ffffff;">based on your data Platform that provides</h1>
      <h1 style="margin:0px 335px 0px -64px;font-size:28px;color:#ffffff;">outsourcing through big data analysis</h1>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey"style="margin:15px 800px 0px 0px" onclick="document.getElementById('free').style.display='block'">Get for Free <i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="document.getElementById('free').style.display='block'"><i class="fa fa-angle-right"></i></a>
    </div>
 <div class="w3-display-right" style="margin:5px 150px 0px 0px">
      <h1 style="margin:0px 0px -5px 0px;font-size:42px;color:#ffffff;">Quick Coduck is back.</h1>
      <h1 style="margin:0px 350px 0px 0px;font-size:44px;color:#ffffff;">2019</h1>
      <h1 style="margin:-63px 172px 0px 0px;font-size:22px;color:#ffffff;">Jan23</h1>
      <h1 style="margin:-10px -15px 0px 0px;font-size:22px;color:#ffffff;">Made by Quick Coduck</h1>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey"style="margin:15px 320px 0px 0px" onclick="document.getElementById('login').style.display='block'">Get Login<i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="plusDivs(1)"><i class="fa fa-angle-right"></i></a><br>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey"style="margin:15px 305px 0px 0px"onclick="document.getElementById('signup').style.display='block'">Get Sign Up <i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="document.getElementById('signup').style.display='block'"><i class="fa fa-angle-right"></i></a>
    </div>
</header>
<!-- The App Section -->
<div class="w3-padding-64 w3-white">
  <div class="w3-row-padding">
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
      <p>Available for <i class="fa fa-android w3-xlarge w3-text-green"></i> <i class="fa fa-apple w3-xlarge"></i> <i class="fa fa-windows w3-xlarge w3-text-blue"></i></p>
    </div>
    <div class="w3-col l4 m6">
      <img src="../workpic/QuickCoduck.jpg" class="w3-image w3-right w3-hide-small" width="335" height="471">
    </div>
  </div>
</div>

<!-- Modal -->
<div id="login" class="w3-modal w3-animate-opacity">
<section class="container">
		    <article class="half">
			        <h1>Quick Coduck</h1>
			        <div class="tabs">
				            <span class="tab signin active"><a href="#signin">Login</a></span>
			        </div>
			        <div class="content">
				            <div class="signin-cont cont">
					                <form action="#" method="post" enctype="multipart/form-data">
						                    <input type="email" name="userid" id="userid" class="inpt" required="required" placeholder="User ID">
						                    <label for="email">Your id</label>
						                    <input type="password" name="pass" id="password" class="inpt" required="required" placeholder="Password">
                						    <label for="password">Your password</label>
						                    <input type="checkbox" id="remember" class="checkbox" checked>
						                    <div class="submit-wrap">
							                        <input type="submit" value="Sign in" class="submit">
							                        <a href="#" class="more">Forgot your password?</a>
						                    </div>
        					        </form>
    				        </div>
			        </div>
		    </article>
		    <i onclick="document.getElementById('login').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge" style="color:#000000;"></i>
		    <div class="half bg"></div>
	</section>
</div>


<div id="signup" class="w3-modal w3-animate-opacity">
<section class="container">
		    <article class="half">
			        <h1>Quick Coduck</h1>
			        <div class="tabs">
				            <span class="tab signin active"><a href="#signin">User</a></span>
				            <span class="tab signup"><a href="#signup">Client</a></span>
			        </div>
			        <div class="content">
				            <div class="signin-cont cont">
					                <form action="#" method="post" enctype="multipart/form-data">
					                        <input type="text" name="userid" id="id" class="inpt" required="required" placeholder="User Id">
						                    <label for="name"></label>
						                    <input type="email" name="email" id="email" class="inpt" required="required" placeholder="User Email">
						                    <label for="email"></label>
						                    <input type="password" name="pass" id="password" class="inpt" required="required" placeholder="Password">
                						    <label for="password"></label>
                						    <input type="password" name="pass2" id="password2" class="inpt" required="required" placeholder="Re Password">
                						    <label for="password"></label>
                						    <input type="hidden" name="type" value="1" id="user" class="inpt">
						                    <div class="submit-wrap">
							                        <input type="submit" value="Sign up" class="submit">
							                        <a href="#" class="more">Forgot your password?</a>
						                    </div>
        					        </form>
    				        </div>
    				        <div class="signup-cont cont">
                <form action="#" method="post" enctype="multipart/form-data">
						                    <input type="text" name="userid" id="id" class="inpt" required="required" placeholder="User Id">
						                    <label for="name"></label>
                                            <input type="email" name="email" id="email" class="inpt" required="required" placeholder="User Email">
						                    <label for="email"></label>
						                    <input type="password" name="pass" id="password" class="inpt" required="required" placeholder="Password">
                						    <label for="password"></label>
                						    <input type="password" name="pass2" id="password2" class="inpt" required="required" placeholder="Re Password">
                						    <label for="password"></label>
                						    <input type="hidden" name="type" value="2" id="client" class="inpt">
						                    <div class="submit-wrap">
							                        <input type="submit" value="Sign up" class="submit">
							                        <a href="#" class="more">Terms and conditions</a>
						                    </div>
        					        </form>
            </div>
			        </div>
		    </article>
		    <i onclick="document.getElementById('signup').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge" style="color:#000000;"></i>
		    <div class="half bg"></div>
	</section>
</div>

<div id="free" class="w3-modal w3-animate-opacity">
  <div class="w3-modal-content" style="padding:32px">
    <div class="w3-container w3-white">
      <i onclick="document.getElementById('free').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge"></i>
      <h2 class="w3-wide">비회원 입장</h2>
      <p>비회원으로 접근시 사용이 제한됩니다.</p>
      <i class="fa fa-android w3-large"></i> <i class="fa fa-apple w3-large"></i> <i class="fa fa-windows w3-large"></i>
      <p></p>
      <button type="button" class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('free').style.display='none'">비회원 입장하기</button>
    </div>
  </div>
</div>


<!-- Clarity Section -->
<div class="w3-padding-64 w3-light-grey">
  <div class="w3-row-padding">
    <div class="w3-col l4 m6">
      <img class="w3-image w3-round-large w3-hide-small w3-grayscale" src="../workpic/d3.jpg" alt="App" width="335" height="471">
    </div>
    <div class="w3-col l8 m6">
      <h1 class="w3-jumbo"><b>Clarity</b></h1>
      <h1 class="w3-xxxlarge w3-text-red"><b>Pixels, who?</b></h1>
      <p><span class="w3-xlarge">A revolution in resolution.</span> Sharp and clear photos with the world's best photo engine, incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
        ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
    </div>
  </div>
</div>

<!-- Features Section -->
<div class="w3-container w3-padding-64 w3-dark-grey w3-center">
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
  <p class="w3-medium">Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank" class="w3-hover-text-green">w3.css</a></p>
</footer>

<script>
// Slideshow
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> 
<script type="text/javascript">
$('.tabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
</script>
</body>
</html>
