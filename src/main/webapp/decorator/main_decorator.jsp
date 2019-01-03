<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}

body, html {
  height: 100%;
  line-height: 1.8;
}

/* Full height image header */
.bgimg-1 {
  background-position: center;
  background-size: cover;
  background-image: url("../workpic/d4.png");
  min-height: 60%;
}
.project {
 border-color: 1px solid gray;
}

.w3-bar .w3-button {
  padding: 16px;
}
</style>
<decorator:head/>
<!-- decorator head 삽입 부분 -->
<body><!-- body 시작부분 -->

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-card" id="myNavbar">
    <a href="#home" class="w3-bar-item w3-button w3-wide">Quick Coduck</a>
    <!-- Right-sided navbar links -->
    <div class="w3-right w3-hide-small">
      <a href="#about" class="w3-bar-item w3-button">이용방법</a>
      <c:if test="${sessionScope.loginUser.type == '1'}">
      <a href="#team" class="w3-bar-item w3-button"><i class="fa fa-user"></i>opensource 찾기</a>
      </c:if>
      <c:if test="${sessionScope.loginUser.type == '2'}">
      <a href="#team" class="w3-bar-item w3-button"><i class="fa fa-user"></i>프로젝트 찾기</a>
      </c:if>
      <a href="#work" class="w3-bar-item w3-button"><i class="fa fa-th"></i>자유게시판</a>
      <a href="#pricing" class="w3-bar-item w3-button"><i class="fa fa-usd"></i>Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="#contact" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i>로그인/회원가입</a>
      </c:if>
      <c:if test="${!empty sessionScope.loginUser}">
      <a href="#contact" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i>로그아웃</a>
      </c:if>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>

<!-- 상단 아이콘 버트 -->
<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a>
  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">이용방법</a>
  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">프로젝트 찾기/opensource 찾기</a>
  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">자유게시판</a>
  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">Mypage</a>
  <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button">로그인/회원가입</a>
</nav>

<!-- 상단 이미지 AD-->
<header class="bgimg-1 w3-display-container w3-grayscale-min" id="home">
  <div class="w3-display-left" style="padding:48px">
    <span class="w3-jumbo w3-hide-small w3-text-white">Welcome to Quick Coduck</span><br>
    <span class="w3-xxlarge w3-hide-large w3-hide-medium w3-text-white"></span><br>
    <span class="w3-large w3-text-white">Provide developers with
				OpenSource space and based on your data Platform that provides
				outsourcing through big data analysis</span><br>
    <p><a href="#about" class="w3-button w3-white w3-padding-large w3-large w3-margin-top w3-opacity w3-hover-opacity-off">Learn more and start today</a></p>
  </div> 
  <div class="w3-display-bottomleft w3-text-grey w3-large" style="padding:24px 48px">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
</header>

<!-- 공고 글 수 보여주는 영역 -->
<div class="project w3-container w3-row w3-center w3-padding-32"style="margin-bottom:40px;">
 <h3  style="margin-bottom:45px;text-align:center">OUR WORK<br></h3>
 <div class="w3-col s4 w3-center">
     등록된 프로젝트<br>
    <span class="w3-xxlarge">15.400 개</span>
  </div>
  <div class="w3-col s4 w3-center">
   프로젝트 등록금액<br>
    <span class="w3-xxlarge">157,096,566 원</span>
  </div>
 <div class="w3-col s4 w3-center">
  개발회사 & 프리랜서<br>
    <span class="w3-xxlarge">57,603 명</span>
  </div>
</div>
<decorator:body />

<!-- 아이콘 보여주면서 회사 설명 파트-->
<div class="w3-container" style="padding:128px 16px;border:1px solid grey;" id="about">
  <h3 class="w3-center">ABOUT THE COMPANY</h3>
  <p class="w3-center w3-large">Key features of our company</p>
  <div class="w3-row-padding w3-center" style="margin-top:64px">
    <div class="w3-quarter">
      <i class="fa fa-desktop w3-margin-bottom w3-jumbo w3-center"></i>
      <p class="w3-large">Responsive</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
    </div>
    <div class="w3-quarter">
      <i class="fa fa-heart w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Passion</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
    </div>
    <div class="w3-quarter">
      <i class="fa fa-diamond w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Design</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
    </div>
    <div class="w3-quarter">
      <i class="fa fa-cog w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Support</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
    </div>
  </div>
</div>
<!-- Team Section -->
<div class="w3-container" style="padding:128px 16px" id="team">
  <h3 class="w3-center">THE TEAM</h3>
  <p class="w3-center w3-large">The ones who runs this company</p>
  <div class="w3-row-padding w3-grayscale" style="margin-top:64px">
    <div class="w3-col l3 m6 w3-margin-bottom">
      <div class="w3-card">
        <img src="../workpic/h3.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
        <div class="w3-container">
          <h3>CM</h3>
          <p class="w3-opacity">Programer</p>
          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
        </div>
      </div>
    </div>
    <div class="w3-col l3 m6 w3-margin-bottom">
      <div class="w3-card">
        <img src="../workpic/h4.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
        <div class="w3-container">
          <h3>jiho</h3>
          <p class="w3-opacity">Director</p>
          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
        </div>
      </div>
    </div>
    <div class="w3-col l3 m6 w3-margin-bottom">
      <div class="w3-card">
        <img src="../workpic/h1.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
        <div class="w3-container">
          <h3>doorong</h3>
          <p class="w3-opacity">Web Designer</p>
          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
        </div>
      </div>
    </div>
    <div class="w3-col l3 m6 w3-margin-bottom">
      <div class="w3-card">
        <img src="../workpic/h2.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
        <div class="w3-container">
          <h3>Beom</h3>
          <p class="w3-opacity">Programer</p>
          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Work Section -->

<!-- Modal for full size images on click-->
<div id="modal01" class="w3-modal w3-black" onclick="this.style.display='none'">
  <span class="w3-button w3-xxlarge w3-black w3-padding-large w3-display-topright" title="Close Modal Image">×</span>
  <div class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
    <img id="img01" class="w3-image">
    <p id="caption" class="w3-opacity w3-large"></p>
  </div>
</div>
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i><br>
    <i class="fa fa-map-marker"></i> Chicago, US<br>
    <i class="fa fa-phone"></i> Phone: +00 151515<br>
    <i class="fa fa-envelope"></i> Email: mail@mail.com<br>
  </div>
  <p>Quick Coduck<a href="https://www.w3schools.com/w3css/default.asp" title="W3.CSS" target="_blank" class="w3-hover-text-green">Quick</a></p>
</footer>
<script>
// Modal Image Gallery
function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
  var captionText = document.getElementById("caption");
  captionText.innerHTML = element.alt;
}


// Toggle between showing and hiding the sidebar when clicking the menu icon
var mySidebar = document.getElementById("mySidebar");

function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
  } else {
    mySidebar.style.display = 'block';
  }
}

// Close the sidebar with the close button
function w3_close() {
    mySidebar.style.display = "none";
}
</script>
</body>
</html>
