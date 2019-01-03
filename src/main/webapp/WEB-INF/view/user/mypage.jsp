<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>유저 마이페이지</title>
</head>
<body>
 
 <table border="1" width="100%">
		 <tr><td colspan="2">회원정보</td></tr>
		 <tr><td>아이디</td><td>${user.userid}</td></tr>
		 <tr><td>이메일</td><td>${user.email}</td></tr>
		 <tr><td>핸드폰</td><td>${user.tel}</td></tr>
		 <tr><td>생년월일</td>
		 	<td><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd"/>
		 </td></tr>
		 <c:if test="${user.type==1}">
		 	<tr><td>사용가능기술</td>
		 		<td>${user.usetech}</td></tr>
		 	<tr><td>인재등록여부</td>
		 		<c:if test="${user.rating==0}">
		 			<td>등록안함</td>
		 		</c:if>
		 		<c:if test="${user.rating==1}">
		 			<td>등록함</td>
		 		</c:if>
		 	</tr>
		 </c:if>
		 <c:if test="${user.type==2}">
		 	<tr><td>사업자번호</td>
		 		<td>${user.businessnum}</td></tr>
		 	<tr><td>등록한 계좌번호</td>
		 		<td>${user.creditnum}</td></tr>
		 </c:if>
		 <tr><td>매칭여부</td>
		 	 <c:if test="${user.matching==0}">
		 	 	<td>매칭안됨</td>
		 	 </c:if>
		 	 <c:if test="${user.matching==1}">
		 	 	<td>매칭진행중</td>
		 	 </c:if>
		 	 <c:if test="${user.matching==2}">
		 	 	<td>매칭됨</td>
		 	 </c:if>
		 </tr>
  </table>
  
  
  <a href="updateForm.shop?id=${user.userid}">[회원정보수정]</a>&nbsp;
		 <c:if test="${loginUser.userid !='admin'}">
		 	<a href="delete.shop?id=${user.userid}">[회원탈퇴]</a>&nbsp;
		 </c:if>
		 <c:if test="${loginUser.userid =='admin'}">
		 	<a href="../admin/list.duck">[회원목록]</a>&nbsp;
		 </c:if>
		 <a href="logout.shop?id=${user.userid}">[로그아웃]</a>&nbsp;
</body>
</html>