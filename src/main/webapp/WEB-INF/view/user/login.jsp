<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
</head>
<body>
<%-- /mavenduck3/user/loginForm.duck 요청시 login.jsp가 화면에 출력하기 --%>
<form:form modelAttribute="user" method="post" action="login.duck">
	<input type="hidden" name="userName" value="유효성검증을 회피하기위한 의미없는 Name값">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />			
			</c:forEach>
		</font>	
	</spring:hasBindErrors>
	<h2>로그인</h2>
	<table>
		<tr height="40px"><td>아이디</td><td><form:input path="userid"/>
			<font color="red"><form:errors path="userid"/></font></td></tr>
		<tr height="40px"><td>비밀번호</td><td><form:password path="pass"/>
			<font color="red"><form:errors path="pass"/></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='userForm.duck'"></td>
		</tr>
	</table>
</form:form>
</body>
</html>