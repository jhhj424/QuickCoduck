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
<%-- /mavenduck3/user/loginForm.duck ��û�� login.jsp�� ȭ�鿡 ����ϱ� --%>
<form:form modelAttribute="user" method="post" action="login.duck">
	<input type="hidden" name="userName" value="��ȿ�������� ȸ���ϱ����� �ǹ̾��� Name��">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />			
			</c:forEach>
		</font>	
	</spring:hasBindErrors>
	<h2>�α���</h2>
	<table>
		<tr height="40px"><td>���̵�</td><td><form:input path="userid"/>
			<font color="red"><form:errors path="userid"/></font></td></tr>
		<tr height="40px"><td>��й�ȣ</td><td><form:password path="pass"/>
			<font color="red"><form:errors path="pass"/></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="�α���">
			<input type="button" value="ȸ������" onclick="location.href='userForm.duck'"></td>
		</tr>
	</table>
</form:form>
</body>
</html>