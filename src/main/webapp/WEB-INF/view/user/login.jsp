<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ȭ��</title>
</head>
<body>
<%-- /mavenshop3/user/loginForm.shop ��û�� login.jsp�� ȭ�鿡 ����ϱ� --%>
<form:form modelAttribute="user" method="post" action="login.shop">
	<input type="hidden" name="userName" value="��ȿ�������� ȸ���ϱ����� �ǹ̾��� Name��">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />			
			</c:forEach>
		</font>	
	</spring:hasBindErrors>
	<h2>�α���</h2>
</form:form>
</body>
</html>