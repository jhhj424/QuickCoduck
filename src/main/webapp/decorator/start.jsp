<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
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
<style>
<style>
body {
  font-family: "Squada One",sans-serif;
  background: #000e12;
  color: #daf6ff;
}

.bluelight {
  display: table;
  width: 200px;
  height: 200px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.bluelight a {
  display: table-cell;
  font-size: 3em;
  text-decoration: none;
  text-align: center;
  vertical-align: middle;
  border-radius: 50%;
  transition: background 1s, border-width 0.5s cubic-bezier(0.075, 0.82, 0.165, 1), text-shadow 0.5s;
  color: #daf6ff;
  text-shadow: 0 0 20px #0aafe6, 0 0 20px rgba(10, 175, 230, 0);
  box-shadow: 0 0 0 rgba(10, 175, 230, 0), inset 0 0 0 rgba(10, 175, 230, 0);
  background-image: radial-gradient(ellipse cover at center, rgba(10, 175, 230, 0) 0%, rgba(10, 175, 230, 0) 90%);
  border: 0 dotted rgba(10, 175, 230, 0);
}
.bluelight a:hover {
  color: #fff;
  text-shadow: 0 0 50px #0aafe6, 0 0 50px #0aafe6;
  background-image: radial-gradient(ellipse cover at center, rgba(10, 175, 230, 0.3) 0%, rgba(10, 175, 230, 0) 60%);
}
.bluelight:before, .bluelight:after, .bluelight a:before, .bluelight a:after {
  transition: 0.2s ease-in-out;
  content: "";
  display: block;
  position: absolute;
  border-radius: 50%;
  border: 60px dashed transparent;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.bluelight:before {
  animation: rotate 20s linear 0s infinite;
  width: 180%;
  height: 180%;
  border: 3px dotted rgba(10, 175, 230, 0);
  z-index: -1;
}
.bluelight:after {
  animation: rotate 10s linear 0s infinite reverse;
  border: 80px dashed rgba(10, 175, 230, 0);
  width: 160%;
  height: 160%;
  z-index: -2;
}
.bluelight a:before {
  animation: rotate 5s ease-in-out 0s infinite alternate;
  width: 120%;
  height: 120%;
  border: 50px dashed rgba(10, 175, 230, 0);
}
.bluelight a:after {
  animation: rotate 5s linear 0s infinite;
  border: 18px dashed rgba(10, 175, 230, 0);
  width: 120%;
  height: 120%;
}
.bluelight:hover:before {
  border-color: rgba(10, 175, 230, 0.3);
}
.bluelight:hover:after {
  border-color: rgba(10, 175, 230, 0.1);
}
.bluelight:hover a:before {
  border-color: rgba(10, 175, 230, 0.3);
}
.bluelight:hover a:after {
  border-color: rgba(10, 175, 230, 0.3);
}

@keyframes rotate {
  0% {
    transform: translate(-50%, -50%) rotate(0deg);
  }
  100% {
    transform: translate(-50%, -50%) rotate(360deg);
  }
}
p.caption {
  font-size: 0.7em;
  text-align: center;
  position: fixed;
  width: 100%;
  bottom: 0;
  letter-spacing: 0.2em;
  text-shadow: 0 0 20px #0aafe6, 0 0 20px rgba(10, 175, 230, 0);
}
</style>
<body class="w3-content" style="max-width:100%;">

<!-- Header with Slideshow -->
<header class="w3-display-container w3-center" style="background-image:url( '../workpic/title1.jpg' );height:700px">
  <button class="w3-button w3-block w3-green w3-hide-large w3-hide-medium" onclick="document.getElementById('download').style.display='block'">Download <i class="fa fa-android"></i> <i class="fa fa-apple"></i> <i class="fa fa-windows"></i></button>
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/title1.jpg' );height:700px">
 
  </div>
  
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/d3.jpg' );height:700px">
  
  </div>
  <div class="mySlides w3-animate-opacity" style=" background-image:url( '../workpic/d4.png' );height:700px">
  
  </div>
  
  <div class="bluelight">
	<a href="#">Quick Coduck</a>
</div>
 <div class="w3-display-left" style="margin:10px 280px 0px -30px">
      <h1 style="margin:0px 270px -5px -140px;font-size:35px;color:#ffffff;">Welcome to the Quick Coduck</h1>
      <h1 style="margin:0px 335px 0px 76px;font-size:28px;color:#ffffff;">Provide developers with OpenSource space and</h1>
      <h1 style="margin:0px 335px 0px 0px;font-size:28px;color:#ffffff;">based on your data Platform that provides</h1>
      <h1 style="margin:0px 335px 0px -64px;font-size:28px;color:#ffffff;">outsourcing through big data analysis</h1>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey" onclick="document.getElementById('download').style.display='block'">Get for Free<i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="document.getElementById('download').style.display='block'">Get for Free<i class="fa fa-angle-right"></i></a>
    </div>
 <div class="w3-display-right" style="margin:20px 150px 0px 0px">
      <h1 style="margin:0px 0px -5px 0px;font-size:40px;color:#ffffff;">Quick Coduck is back.</h1>
      <h1 style="margin:0px 335px 0px 0px;font-size:42px;color:#ffffff;">2019</h1>
      <h1 style="margin:-60px 165px 0px 0px;font-size:21px;color:#ffffff;">Jan23</h1>
      <h1 style="margin:-10px -15px 0px 0px;font-size:21px;color:#ffffff;">Made by Quick Coduck</h1>
      <h6><button class="w3-button w3-white w3-padding-large w3-large w3-opacity w3-hover-opacity-off" onclick="document.getElementById('subscribe').style.display='block'">Get Sign Up</button></h6>
      <a class="w3-button w3-black w3-round w3-hide-small w3-hover-light-grey" onclick="plusDivs(1)">Take Tour <i class="fa fa-angle-right"></i></a>
      <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="plusDivs(1)">Take Tour <i class="fa fa-angle-right"></i></a>
    </div>
<!--aside -->

<!--//aside -->
</header>

<!-- The App Section -->
<div class="w3-padding-64 w3-white">
  <div class="w3-row-padding">
    <div class="w3-col l8 m6">
      <h1 class="w3-jumbo"><b>The App</b></h1>
      <h1 class="w3-xxxlarge w3-text-green"><b>Why buy it?</b></h1>
      <p><span class="w3-xlarge">Take photos like a pro.</span> You should buy this app because lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
        ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
      <button class="w3-button w3-light-grey w3-padding-large w3-section w3-hide-small" onclick="document.getElementById('download').style.display='block'">
        <i class="fa fa-download"></i> Download Application
      </button>
      <p>Available for <i class="fa fa-android w3-xlarge w3-text-green"></i> <i class="fa fa-apple w3-xlarge"></i> <i class="fa fa-windows w3-xlarge w3-text-blue"></i></p>
    </div>
    <div class="w3-col l4 m6">
      <img src="../workpic/QuickCoduck.jpg" class="w3-image w3-right w3-hide-small" width="335" height="471">
      <div class="w3-center w3-hide-large w3-hide-medium">
        <button class="w3-button w3-block w3-padding-large" onclick="document.getElementById('download').style.display='block'">
          <i class="fa fa-download"></i> Download Application
        </button>
        <img src="../workpic/QuickCoduck.jpg" class="w3-image w3-margin-top" width="335" height="471">
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div id="download" class="w3-modal w3-animate-opacity">
  <div class="w3-modal-content" style="padding:32px">
    <div class="w3-container w3-white">
      <i onclick="document.getElementById('download').style.display='none'" class="fa fa-remove w3-xlarge w3-button w3-transparent w3-right w3-xlarge"></i>
      <h2 class="w3-wide">로그인/회원가입</h2>
      <p>Download the app in AppStore, Google Play or Microsoft Store.</p>
      <i class="fa fa-android w3-large"></i> <i class="fa fa-apple w3-large"></i> <i class="fa fa-windows w3-large"></i>
      <p><input class="w3-input w3-border" type="text" placeholder="Enter e-mail"></p>
      <button type="button" class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('download').style.display='none'">로그인/회원가입</button>
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
  <p>This app is just so lorem ipsum.</p>

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

</body>
</html>
