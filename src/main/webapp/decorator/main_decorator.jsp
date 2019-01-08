<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/start_signup.jsp" %>
<%@include file="/WEB-INF/view/style/user_main.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet'href='https://fonts.googleapis.com/css?family=Roboto'>
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">

<decorator:head/>
<!-- decorator head 삽입 부분 -->
<body><!-- body 시작부분 -->

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-card" id="myNavbar" style="background-color:rgba(255, 255, 255, 0.7);height:50%">
    <!-- 상단 아이콘-->
    <div class="w3-hide-small">
    <a href="../user/main.duck" class="w3-left w3-bar-item w3-button w3-wide"> Quick Coduck
    <img src="../workpic/QuickCoduck.jpg" class="w3-circle" style="height:23px;width:23px" alt="Avatar"></a>
    </div>
    <div class="w3-right w3-hide-small">
      <a href="../board/find.duck?type=1" class="w3-bar-item w3-button"><i class="fa fa-info"></i> 이용방법</a>
      <c:if test="${sessionScope.loginUser.type == '1'}">
      <a href="../board/find.duck?type=1" class="w3-bar-item w3-button"><i class="fa fa-search"></i> opensource 찾기</a>
      </c:if>
      <c:if test="${sessionScope.loginUser.type == '2'}">
      <a href="../board/find.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 프로젝트 찾기</a>
      </c:if>
      <a href="../board/list.duck?type=2" class="w3-bar-item w3-button"><i class="fa fa-newspaper-o"></i> 자유게시판</a>
      <a href="../user/mypage_main.duck?id=${sessionScope.loginUser.userid}" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="../user/login.duck" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i>로그인/회원가입</a>
      </c:if>
      <c:if test="${!empty sessionScope.loginUser}">
      <a href="../user/logout.duck" class="w3-bar-item w3-button"><i class="fa fa-unlock-alt"></i> 로그아웃</a>
      </c:if>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>
<!-- 상단 이미지 AD-->
<header class="bgimg-1 w3-display-container w3-grayscale-min" id="home">
  <div class="w3-display-left" style="padding:48px; top:55%;">
    <span class="w3-jumbo w3-hide-small w3-text-white">Welcome to Quick Coduck</span><br>
    <span class="w3-xxlarge w3-hide-large w3-hide-medium w3-text-white"></span><br>
    <span class="w3-large w3-text-white">Provide developers with
				OpenSource space and based on your data Platform that provides
				outsourcing through big data analysis</span><br>
    <p></p>
  </div> 
  <div class="w3-display-bottomleft w3-text-white w3-large" style="padding:24px 48px">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
    <i class="fa fa-android w3-hover-opacity"></i>
    <i class="fa fa-apple w3-hover-opacity"></i>
    <i class="fa fa-windows w3-hover-opacity"></i>
  </div>
</header>

<!-- 공고 글 수 보여주는 영역 -->
<div class="project w3-container w3-row w3-center"style="margin-bottom:40px;border-bottom:1px solid grey;background-color:#ffffff;padding:10px;">
 <div class="w3-col s4 w3-center"style="border-right:1px solid grey">
 <span class="w3-large">등록된 프로젝트</span><br>
    <span class="w3-xlarge"style="font-weight:bold;">15,400 개</span>
  </div>
  <div class="w3-col s4 w3-center" style="border-right:1px solid grey">
  <span class="w3-large"> 프로젝트 등록금액</span><br>
    <span class="w3-xlarge"style="font-weight:bold;">157,096,566 원</span>
  </div>
 <div class="w3-col s4 w3-center">
 <span class="w3-large">Client & 개발자</span><br>
    <span class="w3-xlarge"style="font-weight:bold;">57,603 명</span>
  </div>
</div>
<div class="w3-center">
<decorator:body />
</div>

<!-- 아이콘 보여주면서 회사 설명 파트-->
<div class="w3-container" style="padding:100px 16px;border:1px solid grey;" id="about">
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
<footer class="w3-center w3-black w3-padding-32">
  <div class="w3-xlarge w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i><br>
  </div>
  <p>Quick Coduck<a href="#home"class="w3-hover-text-green">  <i class="fa fa-arrow-up w3-margin-right">Up to top</i></a></p>
</footer>

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
					                <form action="login.duck" method="post" enctype="multipart/form-data">
						                    <input type="text" name="userid" id="userid" class="inpt" required="required" placeholder="User ID">
						                    <label for="text">Your id</label>
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
					                <form action="signup.duck" method="post" enctype="multipart/form-data">
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
                <form action="signup.duck" method="post" enctype="multipart/form-data">
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
<!-- 사진 확대해서 보이는 script -->
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
<!-- 모달 로그인창 스크립트 -->
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
