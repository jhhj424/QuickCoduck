<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@include file="/WEB-INF/view/style/mypage_decorator_css.jsp" %>
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/user_mypage.jsp" %>
<!DOCTYPE html>
<html>
<title>Quick Coduck</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	var mat = ${loginUser.matching}
	if(mat == 1 || mat == 2) {
		$(":checkbox[id=toggle]").prop("checked", true);
	}else{
		$(":checkbox[id=toggle]").prop("checked", false);
	}
	
$("#toggle").click(function(){
	if(mat==2){
		alert("현재진행중인 프로젝트가 있습니다.")
		return false;
	}else{
		var result = confirm("매칭타입을 바꾸시겠습니까?");
		if(result) {	
		if($(":checkbox[id=toggle]").is(":checked") == false){
			$(":checkbox[id=toggle]").prop("checked", false);
			mat = 0;
		}else{
			$(":checkbox[id=toggle]").prop("checked", true);
			mat = 1;
		}
		var userid = '${loginUser.userid}';
		var data = {
				"userid" : userid,
				"matching" : mat
		}
		$.ajax({
			url : "checkbox.duck",
			type: "post",
			data: data,
			dataType: "json",
			success: function(data){
				alert(data.msg);
			},
			error: function(xhr,status,error){
				alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
			}
		})
		} else {
			return false;
		}
	}
});	
	
});
</script>
</head>
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
    <div class="w3-third" style="padding:10px 50px 0px 50px;">

      <!-- Profile -->
      <div class="w3-card w3-round w3-white" style="text-align:center;" id="profile">
        <div class="w3-container" style="padding:0 0 0 0;">
        <c:if test="${loginUser.type == 1 }">
        <div style="text-align:left;">
        <sup style="font-size:13px;">off</sup>
        <label class="switch" ><input type="checkbox" value="" name="" id="toggle">
        <span class="slider round" id="slider"></span></label>
        <sup style="font-size:13px;">on</sup>
        </div>
        </c:if>
         
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
           <c:if test="${loginUser.type == '3' }">
           <p class="w3-center"><i class="fa fa-android" style="font-size:100px;color:#7d97a5;"></i></p>
           </c:if>
         </c:if>
         <c:if test="${loginUser.type == '1' }">
         <h4 class="w3-center">개발자 : ${loginUser.userid } 님 </h4>
         </c:if>
         <c:if test="${loginUser.type == '2' }">
         <h4 class="w3-center">Client : ${loginUser.userid } 님</h4>
         </c:if>
         <c:if test="${loginUser.type == '3' }">
         <h4 class="w3-center">관리자 : ${loginUser.userid } 님</h4>
         </c:if>
         <div style="text-align:left;">
         <button onclick="location.href='../user/mypage_info.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-address-book fa-fw w3-margin-right"></i> 회원정보 보기</button>
         <button onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-edit fa-fw w3-margin-right"></i> 회원정보 수정</button>
         <c:if test="${loginUser.type == '1' }">
         <button onclick="location.href='../board/find.duck?type=5'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-cloud-upload fa-fw w3-margin-right"></i> 나만의 소스보기</button>
         <button onclick="location.href='../user/mypage_ducklist.duck?id=${loginUser.userid}&ducktype=1&boardtype=1'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-cloud-upload fa-fw w3-margin-right"></i> 'Duck' 한 오픈소스</button>
         </c:if>
         <button onclick="location.href='../user/mypage_delete.duck?id=${loginUser.userid}'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-user-times fa-fw w3-margin-right"></i> 회원탈퇴</button>
        <c:if test="${loginUser.type == '3'}">
          <button onclick="location.href='../admin/list.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 회원 목록</button>
        </c:if>
         </div>
        </div>
      </div>
      <br>
      
      <!-- Accordion -->
      <!-- 받은 인재 추천 목록
대기중인 프로젝트
진행중인 프로젝트
완료한 프로젝트 -->
	<c:if test="${loginUser.type != 3 }">
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
          <button onclick="location.href='../user/mypage_recmdlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-heart fa-fw w3-margin-right"></i> 추천인재 목록test</button>
          <button onclick="location.href='../user/mypage_waitlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-vcard-o fa-fw w3-margin-right"></i> 대기중인 프로젝트test</button>
          <button onclick="location.href='../user/mypage_proceedlist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i> 진행중인 프로젝트test</button>
          <button onclick="location.href='../user/mypage_completelist.duck'" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-check-square-o fa-fw w3-margin-right"></i> 완료한 프로젝트test</button>
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
      </c:if>
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
        <p><strong>반갑습니다!</strong></p>
        <p>QuickCoduck은 회원님을의 성공을 바랍니다! <i class="fa fa-thumbs-o-up"></i></p>
      </div>
    
    <!-- End Left Column -->
    </div>
    
    <!-- Middle Column -->
   <div class="w3-twothird">
      <div class="w3-row-padding" style="background-color:#fff0;">
        <div class="w3-col m12" style="background-color:#fff0;">
          <div class="w3-card w3-round w3-white" style="box-shadow:none;height:350px;width:100%;border-radius: 10px; background-color:#fff0;z-index:-1">
          <div class="leftdiv">
  <div class="rating_main" data-vote="0">
  <div class="star_main">
  <c:if test="${loginUser.rating >= 0.0 && loginUser.rating <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.rating >= 0.5 && loginUser.rating <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 1 && loginUser.rating <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 1.5 && loginUser.rating <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 2 && loginUser.rating <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 2.5 && loginUser.rating <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 3 && loginUser.rating <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 3.5 && loginUser.rating <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 4 && loginUser.rating <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.rating >= 4.5 && loginUser.rating < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.rating == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
  </div>
  <div class="score_main">
    <span>총 평점</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.rating}" pattern=".0"/> / 5</span>
  </div>
  </div>
  <!-- 총 평점 끝나는 지점 -->
    <div class="rating_main" data-vote="0">
    <div class="star_main">
          <c:if test="${loginUser.prosatisfact >= 0.0 && loginUser.prosatisfact <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.prosatisfact >= 0.5 && loginUser.prosatisfact <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 1 && loginUser.prosatisfact <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 1.5 && loginUser.prosatisfact <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 2 && loginUser.prosatisfact <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 2.5 && loginUser.prosatisfact <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 3 && loginUser.prosatisfact <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 3.5 && loginUser.prosatisfact <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 4 && loginUser.prosatisfact <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prosatisfact >= 4.5 && loginUser.prosatisfact < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.prosatisfact == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    </div>
    <div class="score_main">
    <span>만족도</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.prosatisfact}" pattern=".0"/> / 5</span>
    </div>
    </div>
  <!-- 만족도 끝나는 지점 -->
       <div class="rating_main" data-vote="0">
          <div class="star_main">
          <c:if test="${loginUser.procommunicate >= 0.0 && loginUser.procommunicate <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.procommunicate >= 0.5 && loginUser.procommunicate <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 1 && loginUser.procommunicate <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 1.5 && loginUser.procommunicate <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 2 && loginUser.procommunicate <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 2.5 && loginUser.procommunicate <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 3 && loginUser.procommunicate <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 3.5 && loginUser.procommunicate <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 4 && loginUser.procommunicate <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.procommunicate >= 4.5 && loginUser.procommunicate < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.procommunicate == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    </div>
    <div class="score_main">
    <span>의사소통</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.procommunicate}" pattern=".0"/> / 5</span>
    </div>
    </div>
    <!-- 의사소통 끝나는 지점 -->  
</div>
  <!-- 왼쪽 div 끝나는 지점 -->
   <div class="rightdiv">
          <div class="rating_main" data-vote="0">
          <div class="star_main">
          <c:if test="${loginUser.profess >= 0.0 && loginUser.profess <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.profess >= 0.5 && loginUser.profess <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 1 && loginUser.profess <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 1.5 && loginUser.profess <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 2 && loginUser.profess <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 2.5 && loginUser.profess <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 3 && loginUser.profess <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 3.5 && loginUser.profess <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 4 && loginUser.profess <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.profess >= 4.5 && loginUser.profess < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.profess == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    </div>
    <div class="score_main">
    <span>전문성</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.profess}" pattern=".0"/> / 5</span>
    </div>
    
    </div>
    <!-- 전문성 끝 -->
    <div class="rating_main" data-vote="0">
    <div class="star_main">
    <c:if test="${loginUser.proaction >= 0.0 && loginUser.proaction <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.proaction >= 0.5 && loginUser.proaction <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 1 && loginUser.proaction <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 1.5 && loginUser.proaction <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 2 && loginUser.proaction <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 2.5 && loginUser.proaction <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 3 && loginUser.proaction <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 3.5 && loginUser.proaction <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 4 && loginUser.proaction <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.proaction >= 4.5 && loginUser.proaction < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.proaction == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    </div>
    <div class="score_main">
    <span>적극성</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.proaction}" pattern=".0"/> / 5</span>
    </div>
    </div>
    <!-- 적극성 끝나는 지점 -->
     <div class="rating_main" data-vote="0">
    <div class="star_main">
    <c:if test="${loginUser.prodate >= 0.0 && loginUser.prodate <0.5}">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.prodate >= 0.5 && loginUser.prodate <1 }">
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 1 && loginUser.prodate <1.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 1.5 && loginUser.prodate <2 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 2 && loginUser.prodate <2.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 2.5 && loginUser.prodate <3 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 3 && loginUser.prodate <3.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 3.5 && loginUser.prodate <4 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 4 && loginUser.prodate <4.5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #b2b2b25c;position: relative;"></i>
    </c:if>
     <c:if test="${loginUser.prodate >= 4.5 && loginUser.prodate < 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star-half-empty"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    <c:if test="${loginUser.prodate == 5 }">
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    <i class="fa fa-star"style="display: inline-block;margin: 5px;font-size: 30px;color: #ffd700;position: relative;"></i>
    </c:if>
    </div>
    <div class="score_main">
    <span>일정준수</span>&nbsp;&nbsp;
    <span class="score_main-rating js-score"><fmt:formatNumber value="${loginUser.prodate}" pattern=".0"/> / 5</span>
    </div>
    </div>
    <!-- 적극성 끝나는 지점 -->
        
    </div>
   <!-- 오른쪽 div 끝나는 지점 -->
          <div class="centerdiv">
          <div class="chart-container" style="position: relative;width:100%;position:center;">

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
        labels: ["전문성", "적극성", "만족도", "일정준수", "의사소통"],
        datasets: [{
            label: "김도롱",
            data: [${loginUser.profess}, ${loginUser.proaction}, ${loginUser.prosatisfact}, ${loginUser.prodate},${loginUser.procommunicate}],
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
      </div>
<decorator:body/>
      
    <!-- End Middle Column -->
    </div>
    
    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
<!-- Footer -->
<footer class="w3-center w3-padding-32" style="background-color:#4d636f">
  <div class="w3-xlarge w3-section" style="color:#fefefe">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i><br>
  </div>
  <p style="color:#fefefe">Quick Coduck<a href="#home"class="w3-hover-text-green" style="color:#fefefe;text-decoration: none;">  <i class="fa fa-arrow-up w3-margin-right" style="color:#fefefe">Up to top</i></a></p>
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
