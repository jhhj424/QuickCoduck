<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-user fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 회원정보</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-id-badge fa-fw w3-margin-right"></i><b>아이디</b></h5>
          <h6 class="w3-text-teal">${loginUser.userid }</h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-envelope fa-fw w3-margin-right"></i><b>이메일</b></h5>
          <h6 class="w3-text-teal">${loginUser.email }</h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity">
          <c:if test="${loginUser.type == '1' }">
          <i class="fa fa-user fa-fw w3-margin-right"></i></c:if>
          <c:if test="${loginUser.type == '2' }">
          <i class="fa fa-user-secret fa-fw w3-margin-right"></i></c:if>
          <b>회원타입</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${loginUser.type == '1' }">개발자</c:if>
          <c:if test="${loginUser.type == '2' }">클라이언트</c:if>
          <c:if test="${loginUser.type == '3' }">관리자</c:if>
          </h6>
          <hr>
       </div>
    </div>
    <c:if test="${loginUser.type == '1' }">
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-briefcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 보유기술</h2>
       <div class="w3-container">
          <h6 class="w3-text-teal">
          <c:if test="${empty loginUser.usetech }">
			<h5 class="w3-opacity"><i class="fa fa-briefcase fa-fw w3-margin-right"></i><b>보유기술 미등록</b></h5>
			<button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
			</c:if>
			<c:if test="${!empty loginUser.usetech }">
			<h5 class="w3-opacity"><i class="fa fa-briefcase fa-fw w3-margin-right"></i><b>보유기술</b></h5>
			<c:forEach var="usetech" items="${loginUser.usetech}" varStatus="g" begin="0">
			<span class="w3-tag w3-theme-d3">${usetech}</span>
			<c:out value="${g.end}" />
			</c:forEach>
			</c:if>
          </h6>
          <hr>
       </div>
    </div>
    </c:if>
    
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-user-plus fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 추가정보</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-volume-control-phone fa-fw w3-margin-right"></i><b>휴대번호</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${empty loginUser.tel }">
          <button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
          </c:if>
          <c:if test="${!empty loginUser.tel }">
          ${loginUser.tel }
          </c:if>
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>생년월일</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${empty loginUser.birth }">
          <button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
          </c:if>
          <c:if test="${!empty loginUser.birth }">
           <fmt:formatDate value="${loginUser.birth}" pattern="yyyy-MM-dd" />
          </c:if></h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-file-image-o fa-fw w3-margin-right"></i><b>프로필 사진</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${empty loginUser.fileurl }">
          <button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${loginUser.userid}'"><i class="fa fa-plus-square"></i> 추가하기</button>
          </c:if>
          <c:if test="${!empty loginUser.fileurl }">
          <a href="../file/${loginUser.fileurl }">${loginUser.fileurl}</a>
          </c:if></h6>
          <hr>
       </div>
    </div>
</body>
</html>