<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/user_main.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif;background-color:#FEFEFE;}
</style>
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
<!-- 상단 이미지 AD-->
<header class="bgimg-1 w3-display-container w3-grayscale-min" id="home">
<div class="container2">
      <div class="row">
        <div class="photo-slider">
          <img src="../workpic/title2.jpg" alt="" class="photo-slider-img NOW">
          <img src="../workpic/title3.jpg" alt="" class="photo-slider-img">
          <img src="../workpic/title4.jpg" alt="" class="photo-slider-img">
          <img src="../workpic/title5.png" alt="" class="photo-slider-img">
          <img src="../workpic/title6.jpg" alt="" class="photo-slider-img">
        </div>
      </div>
    </div>
  <div class="w3-display-left" style="padding:48px; top:55%;">
    <span class="w3-jumbo w3-hide-small">Welcome to Quick Coduck</span><br>
    <span class="w3-xxlarge w3-hide-large w3-hide-medium "></span><br>
    <span class="w3-large ">Provide developers with
				OpenSource space and based on your data Platform that provides
				outsourcing through big data analysis</span><br>
    <p></p>
  </div> 
  <!-- 공고 글 수 보여주는 영역 -->
<div class="project w3-container w3-row w3-center"style="margin-bottom:50px;border:1px solid grey;background-color:#ffffff;padding:10px;">
 <div class="w3-col s4 w3-center"style="border-right:1px solid grey">
 <span class="w3-large">등록된 프로젝트</span><br>
 <c:set var="projectcnt" value="${projectcnt}" />
    <span class="w3-xlarge"style="font-weight:bold;">${projectcnt} 개</span>
  </div>
  <div class="w3-col s4 w3-center" style="border-right:1px solid grey">
  <span class="w3-large"> 프로젝트 등록금액</span><br>
    <span class="w3-xlarge"style="font-weight:bold;">${projecttotalprice} 원</span>
  </div>
 <div class="w3-col s4 w3-center">
 <span class="w3-large">Client & 개발자</span><br>
    <span class="w3-xlarge"style="font-weight:bold;">${usertotalcnt} 명</span>
  </div>
</div>
</header>
<div class="w3-center">
<decorator:body />
</div>
<!-- Footer -->
<footer class="w3-center w3-padding-32" style="background-color:#4d636f;color:#fff;">
  <div class="w3-xlarge w3-section">
<i class="fa fa-github"></i>
<i class="fa fa-git-square"></i>
<i class="fa fa-github-alt"></i>
<i class="fa fa-windows"></i>
<i class="fa fa-codepen"></i>
<i class="fa fa-chrome"></i>
<i class="fa fa-internet-explorer"></i>
<i class="fa fa-html5"></i>
<i class="fa fa-linux"></i>
<i class="fa fa-firefox"></i>
<i class="fa fa-dropbox"></i>
<i class="fa fa-mixcloud"></i>
<i class="fa fa-share-alt-square"></i>

  </div>
  <p>Quick Coduck<a href="#home"class="w3-hover" style="color:#fff">&nbsp;&nbsp;&nbsp;<i class="fa fa-arrow-up w3-margin-right"> Up to top</i></a></p>
</footer>
</body>
</html>
