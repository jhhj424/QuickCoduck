<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 화면</title>
</head>
<body>
<%-- /mavenshop3/user/loginForm.shop 요청시 login.jsp가 화면에 출력하기 --%>
<form:form modelAttribute="user" method="post" action="login.shop">
	<input type="hidden" name="userName" value="유효성검증을 회피하기위한 의미없는 Name값">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />			
			</c:forEach>
		</font>	
	</spring:hasBindErrors>
	<h2>로그인</h2>
</form:form>
</body>
</html>