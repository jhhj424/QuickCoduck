<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WEB-INF/view/user/userForm.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����� ���</title>
</head>
<body>
<h2>����� ���</h2>
<%-- modelAttribute="user" : ���� �������� ȣ�� �� �� user��ü�� �����ؾ��� --%>
<form:form modelAttribute="user" method="post" action="userEntry.shop" >
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors }"  var="error" >
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table>
		<tr height="40px" ><td>���̵�</td><td><form:input path="userId"/>
		<font color="red"><form:errors path="userId"/></font></td></tr>
		<tr height="40px" ><td>��й�ȣ</td><td><form:password path="password"/>
		<font color="red"><form:errors path="password"/></font></td></tr>
		<tr height="40px" ><td>�̸�</td><td><form:input path="userName"/>
		<font color="red"><form:errors path="userName"/></font></td></tr>
		<tr height="40px" ><td>��ȭ��ȣ</td><td><form:input path="phoneNo"/>
		<font color="red"><form:errors path="phoneNo"/></font></td></tr>
		<tr height="40px" ><td>�����ȣ</td><td><form:input path="postcode"/>
		<font color="red"><form:errors path="postcode"/></font></td></tr>
		<tr height="40px" ><td>�ּ�</td><td><form:input path="address"/>
		<font color="red"><form:errors path="address"/></font></td></tr>
		<tr height="40px" ><td>�̸���</td><td><form:input path="email"/>
		<font color="red"><form:errors path="email"/></font></td></tr>
		<tr height="40px" ><td>�������</td><td><form:input path="birthDay"/>
		<font color="red"><form:errors path="birthDay"/></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
		  <input type="submit" value="���"><input type="reset" value="�ʱ�ȭ">
		  </td></tr></table></form:form></body></html>