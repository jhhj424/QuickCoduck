<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="payment.duck" method="post">
<input type="hidden" name="userid" value="${user.userid }">
<input type="hidden" name="itemtype" value="${param.itemtype }">
  <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-cart-arrow-down fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 상품정보</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-handshake-o fa-fw w3-margin-right"></i><b>상품명</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${param.itemtype == '1' }">짱짱한 공고 Top 10!</c:if>
          <c:if test="${param.itemtype == '2' }">막강한 공고 Top 20!</c:if>
          <c:if test="${param.itemtype == '3' }">굉장한 공고 Top 30!</c:if>
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-info fa-fw w3-margin-right"></i><b>상품설명</b></h5>
          <h6 class="w3-text-teal">
          <c:if test="${param.itemtype == '1' }">공고를 10개 쓸수있습니다!</c:if>
          <c:if test="${param.itemtype == '2' }">무려 20개나 한번에 가능?!</c:if>
          <c:if test="${param.itemtype == '3' }">솔직히 30개면 충분하다!</c:if>
          </h6>
          <hr>
       </div>
    </div>
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-credit-card fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 결제하기</h2>
    <c:if test="${!empty user.creditnum}">
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-credit-card fa-fw w3-margin-right"></i><b>카드번호</b></h5>
          <input type="text" name="creditnum" id="re_creditnum" maxlength="19" onkeyup="javascript:commanAndNum(this)" value="${user.creditnum }" readonly="readonly">
          <hr>
       </div>
         <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-shield fa-fw w3-margin-right"></i><b>결제 비밀번호</b></h5>
          <input type="password" name="creditpass" id="creditpass" maxlength="4">
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-shield fa-fw w3-margin-right"></i><b>결제하기</b></h5>
          <input type="submit" value="결제하기">
          <hr>
       </div>
    </c:if>
    <c:if test="${empty user.creditnum}">
    <div class="w3-container">
          <h5 class="w3-opacity">
          <i class="fa fa-credit-card fa-fw w3-margin-right"></i>
          <b>카드 정보</b>
          </h5>
          <h6 class="w3-text-teal">
          <button type="button" class="w3-button w3-theme" onclick="location.href='../user/mypage_update.duck?id=${user.userid}'">
          <i class="fa fa-plus-square"></i> 추가하기</button>
          </h6>
          <hr>
       </div>
    </c:if>
    </div>
</form>
</body>
</html>