<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/user_mypage.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.w3-badge, .w3-tag{
margin-bottom:5px;
}
.leftdiv{
width:33.3333%;
float:left;
max-height:100%;
text-align:center;
border:1px solid #000;
}
.centerdiv{
width:33.3333%;
margin:0 auto;
text-align:center;
max-height:100%;
border:1px solid #000;
max-width:300px;
}
.rightdiv{
width:33.3333%;
float:right;
max-height:100%;
text-align:center;
border:1px solid #000;
}
</style>
<style>
.card {
  background-color: #f3f5f7;
  box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  max-width: 500px;
  height: 300px;
  border-radius: 10px;
  overflow: hidden;
}

.card .about {
  height: 150px;
  padding: 20px;
  box-sizing: border-box;
}

.card .about h3,
.card .about .lead {
  font-weight: 300;
  margin: 0;
}

.card .about h3 {
  font-size: 24px;
}

.card .about .lead {
  color: #aaa;
}
.tooltip-placeholder {
  background-color: #fff;
  border-radius: 4px;
  color: #aaa;
  font-size: 15px;
  position: fixed;
  padding: 4px 0;
  display: none;
  z-index: 2;
}

</style>
<decorator:head/>
<body id="home"style="background-color:#FEFEFE;">
<div class="w3-top" >
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
      <a href="../board/find.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 공고 프로젝트 찾기</a>
      </c:if>
      <c:if test="${sessionScope.loginUser.type == '2'}">
      <a href="../board/find.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 프로젝트 찾기</a>
      </c:if>
      <a href="../board/list.duck?type=2" class="w3-bar-item w3-button"><i class="fa fa-newspaper-o"></i> 자유게시판</a>
      <a href="../user/mypage_main.duck?id=${sessionScope.loginUser.userid}" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="../user/loginForm.duck" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i>로그인/회원가입</a>
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
<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px">    
  <!-- The Grid -->
  <div class="w3-row"style="margin-bottom:50px;margin-top:50px;">
    <!-- Left Column -->
    <div class="w3-third"
				style="padding:10px 50px 0px 50px;">

      <!-- Profile -->
      <div class="w3-card w3-round w3-white" style="text-align:center;">
        <div class="w3-container" style="padding:0 0 0 0;">
         <c:if test="${!empty loginUser.fileurl }">
         <p class="w3-center"><img src="../file/${loginUser.fileurl }" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         </c:if>
         <c:if test="${empty loginUser.fileurl }">
           <c:if test="${loginUser.type == '1' }">
           <p class="w3-center"><i class="fa fa-user-circle-o" style="font-size:100px;color:#7d97a5;"></i></p>
           </c:if>
           <c:if test="${loginUser.type == '2' }">
           <p class="w3-center"><i class="fa fa-user-secret" style="font-size:100px;color:#7d97a5;"></i></p>
           </c:if>
         </c:if>
         <c:if test="${loginUser.type == '1' }">
         <h4 class="w3-center">개발자 : ${user.userid } 님</h4>
         </c:if>
         <c:if test="${loginUser.type == '2' }">
         <h4 class="w3-center">Client : ${user.userid } 님</h4>
         </c:if>
         <c:if test="${loginUser.type == '3' }">
         <h4 class="w3-center">관리자 : ${user.userid } 님</h4>
         </c:if>
         <div style="text-align:left;">
         <button onclick="location.href='../user/mypage_info.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-address-book fa-fw w3-margin-right"></i> 회원정보 보기</button>
         <button onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-edit fa-fw w3-margin-right"></i> 회원정보 수정</button>
         <c:if test="${loginUser.type == '1' }">
         <button onclick="location.href='../board/find.duck?type=5'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-cloud-upload fa-fw w3-margin-right"></i> 나만의 소스보기</button>
         <button onclick="location.href='../user/mypage_ducklist.duck?id=${loginUser.userid}&ducktype=1&boardtype=1'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-cloud-upload fa-fw w3-margin-right"></i> 'Duck' 한 오픈소스</button>

         </c:if>
         <button onclick="location.href='../user/mypage_delete.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-user-times fa-fw w3-margin-right"></i> 회원탈퇴</button>
         </div>
        </div>
      </div>
      <br>
      
      <!-- Accordion -->
      <!-- 받은 인재 추천 목록
대기중인 프로젝트
진행중인 프로젝트
완료한 프로젝트 -->
      <div class="w3-card w3-round">
        <div class="w3-white">
        <c:if test="${loginUser.type == '1'}">
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=1&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 관심프로젝트</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=2&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 지원내역</button>
		  <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=3&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 지원선택된 프로젝트</button>
		  <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=5&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 지원탈락된 프로젝트</button>
          <button onclick="location.href='../user/mypage_suggestlist.duck?id=${loginUser.userid}&ducktype=6'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 제안받은 프로젝트</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=4&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트</button>
          <button onclick="location.href='../user/mypage_developcomplete.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트</button>

        </c:if>
        <c:if test="${loginUser.type == '2'}">
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=1&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 추천인재 목록</button>
          <button onclick="location.href='../user/mypage_recmdlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 추천인재 목록test</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 대기중인 프로젝트</button>
          <button onclick="location.href='../user/mypage_waitlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 대기중인 프로젝트test</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=3&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트</button>
          <button onclick="location.href='../user/mypage_proceedlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트test</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&type=4'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트</button>
          <button onclick="location.href='../user/mypage_completelist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트test</button>
        </c:if>
        <c:if test="${loginUser.type == '3'}">
          <button onclick="location.href='../admin/list.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 회원 목록</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=2&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 대기중인 프로젝트</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=3&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트</button>
          <button onclick="location.href='../user/myduck.duck?id=${user.userid}&ducktype=4&type=3'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트</button>
        </c:if>
        </div>      
      </div>
      <br>
      <!-- Interests -->
      <div class="w3-card w3-round w3-white w3-hide-small">
		<div class="w3-container">
		<c:if test="${loginUser.type == '1' }">
			<h2 class="w3-text-grey w3-padding-16" style="text-align:left;"><i class="fa fa-user fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 보유기술</h2>
			<c:if test="${empty loginUser.usetech }">
			<h5 class="w3-opacity"><i class="fa fa-briefcase fa-fw w3-margin-right"></i><b>보유기술 미등록</b></h5>
			<button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
			</c:if>
			<c:if test="${!empty loginUser.usetech }">
			<c:forEach var="usetech" items="${loginUser.usetech}" varStatus="g" begin="0">
			<span class="w3-tag w3-theme-d3">${usetech}</span>
			<c:out value="${g.end}" />
			</c:forEach>
			</c:if>
		</c:if>
		
		<c:if test="${loginUser.type == '2' }">
		<h2 class="w3-text-grey w3-padding-16" style="text-align:left;"><i class="fa fa-briefcase fa-fw w3-xxlarge w3-text-teal"></i>프로젝트 주요기술</h2>
			<c:if test="${empty loginUser.usetech }">
			<h5 class="w3-opacity"><i class="fa fa-briefcase fa-fw w3-margin-right"></i><b>프로젝트 주요기술 미등록</b></h5>
			<button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
			</c:if>
			<c:if test="${!empty loginUser.usetech }">
			<c:forEach var="usetech" items="${loginUser.usetech}" varStatus="g" begin="0">
			<span class="w3-tag w3-theme-d3">${usetech}</span>
			<c:out value="${g.end}" />
			</c:forEach>
			</c:if>
		</c:if>
			<p></p>
		</div>
	 </div><br>
	 <c:if test="${loginUser.type == '2' }">
	   <div class="w3-card w3-round w3-white w3-hide-small">
	     <div class="w3-container">
	       <h2 class="w3-text-grey w3-padding-16" style="text-align:left;"><i class="fa fa-bullhorn fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 상품정보</h2>
	       <c:if test="${loginUser.maxcount == '0' }">
			<h5 class="w3-opacity"><i class="fa fa-cart-plus fa-fw w3-margin-right"></i><b>공고 상품 미등록</b></h5>
			<button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_item.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
			</c:if>
			<c:if test="${loginUser.maxcount != '0' }">
			공고 사용가능 횟수: 
			<span class="w3-tag w3-theme-d3">${loginUser.maxcount}</span>
			</c:if>
			<p></p>
	     </div>
	   </div>
	   <br>
	 </c:if>
      
      <!-- Alert Box -->
      <div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
          <i class="fa fa-remove"></i>
        </span>
        <p><strong>Hello!</strong></p>
        <p>These page is Mypage So 알아서 하시길~~받아올거 있으면 말씀하시쥬</p>
      </div>
    
    <!-- End Left Column -->
    </div>
    
    <!-- Middle Column -->
   <div class="w3-twothird">
      <div class="w3-row-padding" >
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white" style="height:350px;width:100%">
          <div class="leftdiv">123</div><div class="rightdiv">789</div>
          <div class="centerdiv">
          <canvas id="canvas" width="100%" height="100%"></canvas>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
<script>
var canvas = document.getElementById("canvas");

var gradientBlue = canvas.getContext('2d').createLinearGradient(0, 0, 0, 150);
gradientBlue.addColorStop(0, 'rgba(85, 85, 255, 0.9)');
gradientBlue.addColorStop(1, 'rgba(151, 135, 255, 0.8)');

var gradientHoverBlue = canvas.getContext('2d').createLinearGradient(0, 0, 0, 150);
gradientHoverBlue.addColorStop(0, 'rgba(65, 65, 255, 1)');
gradientHoverBlue.addColorStop(1, 'rgba(131, 125, 255, 1)');

var redArea = null;
var blueArea = null;

var shadowed = {
	beforeDatasetsDraw: function(chart, options) {
    chart.ctx.shadowColor = 'rgba(0, 0, 0, 0.25)';
    chart.ctx.shadowBlur = 40;
  },
  afterDatasetsDraw: function(chart, options) {
  	chart.ctx.shadowColor = 'rgba(0, 0, 0, 0)';
    chart.ctx.shadowBlur = 0;
  }
};


window.chart = new Chart(document.getElementById("canvas"), {
    type: "radar",
    data: {
        labels: ["전문성", "적극성", "만족도", "일정수준", "의사소통"],
        datasets: [{
            label: "김도롱",
            data: [3.2, 1, 2, 4.2, 2.7],
            fill: true,
            backgroundColor: gradientBlue,
            borderColor: "transparent",
            pointBackgroundColor: "transparent",
            pointBorderColor: "transparent",
            pointHoverBackgroundColor: "transparent",
            pointHoverBorderColor: "transparent",
            pointHitRadius: 50,
        }]
    },
    options: {
    	legend: {
      	display: false,
      },
      tooltips: {
      	enabled: false,
      },
      gridLines: {
        display: false
      },
      scale: {
         ticks: {
        	 min: 0,
             max: 5,
             stepsize:1,
            display: true,
         }, 
         pointLabels: {
             fontSize: 13,
           }
      }
    },
    plugins: [shadowed]
});
</script>
          </div>
          </div>
        </div>
      </div>
<decorator:body/>
      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <img src="../workpic/QuickCoduck.jpg" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-opacity">32 min</span>
        <h4>Angie Jane</h4><br>
        <hr class="w3-clear">
        <p>Have you seen this?</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i> Like</button> 
        <button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i> Comment</button> 
      </div> 
      
    <!-- End Middle Column -->
    </div>
    
    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
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
<script>
// Accordion
function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-theme-d1";
  } else { 
    x.className = x.className.replace("w3-show", "");
    x.previousElementSibling.className = 
    x.previousElementSibling.className.replace(" w3-theme-d1", "");
  }
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>

</body>
</html> 
