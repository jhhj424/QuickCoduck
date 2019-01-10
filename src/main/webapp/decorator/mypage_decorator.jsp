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
</style>
<decorator:head/>
<body class="w3-theme-l5"id="home">
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
				style="padding-right: 50px; padding-left: 50px;">

      <!-- Profile -->
      <div class="w3-card w3-round w3-white" style="text-align:center;">
        <div class="w3-container" style="padding:0 0 0 0;">
         <c:if test="${!empty loginUser.fileurl }">
         <p class="w3-center"><img src="../file/${loginUser.fileurl }" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         </c:if>
         <c:if test="${empty loginUser.fileurl }">
         <p class="w3-center">
         <i class="fa fa-user-circle-o" style="font-size:100px;color:#7d97a5;"></i>
         </p>
         </c:if>
         <h4 class="w3-center">${loginUser.userid } 님</h4>
         <div style="text-align:left;">
         <button onclick="location.href='../user/mypage_info.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-address-book fa-fw w3-margin-right"></i> 내 프로필보기</button>
         <button onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-edit fa-fw w3-margin-right"></i> 내 프로필 수정</button>
         <button onclick="location.href='../user/mypage_delete.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-user-times fa-fw w3-margin-right"></i> 회원탈퇴</button>
         </div>
        </div>
      </div>
      <br>
      
      <!-- Accordion -->
      <div class="w3-card w3-round">
        <div class="w3-white">
          <button onclick="myFunction('Demo1')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 관심프로젝트</button>
          <div id="Demo1" class="w3-hide w3-container">
            <p>받아오면 됩니당</p>
          </div>
          <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 지원내역</button>
          <div id="Demo2" class="w3-hide w3-container">
            <p>받아오면 됩니당</p>
          </div>
           <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트</button>
          <div id="Demo3" class="w3-hide w3-container">
             <p>받아오면 됩니당</p>
          </div>
           <button onclick="myFunction('Demo4')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트</button>
          <div id="Demo4" class="w3-hide w3-container">
          
         <div class="w3-row-padding">
         <br>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
           <div class="w3-half">
             <img src="../workpic/QuickCoduck.jpg" style="width:100%" class="w3-margin-bottom">
           </div>
         </div>
          </div>
          
        </div>      
      </div>
      <br>
      <!-- Interests -->
      <div class="w3-card w3-round w3-white w3-hide-small">
		<div class="w3-container">
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
			<p></p>
		</div>
	 </div><br>
      
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
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
              <h6 class="w3-opacity">검색기능 창으로 쓸까 예정중</h6>
              <p contenteditable="true" class="w3-border w3-padding">Status: Feeling Blue</p>
              <button type="button" class="w3-button w3-theme"><i class="fa fa-pencil"></i> Post</button> 
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
