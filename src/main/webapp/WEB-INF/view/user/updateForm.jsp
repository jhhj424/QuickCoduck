<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /WEB_INF/view/user/updateForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����� ����</title>
</head>
<body>
<%--
	1. AOP ����.
	2. User ��ü�� id �Ķ���Ϳ� �ش��ϴ� ������ ����.
 --%>
<h2>����� ����</h2>
<%-- modelAttribute="user" : ���� �������� ȣ�� �� �� user��ü�� �����ؾ��� --%>
<form:form modelAttribute="user" method="post" action="update.duck" >
	<table>
		<tr height="40px" ><td>���̵�</td><td><form:input path="userid" readonly="true"/>
		</td></tr>
		<tr height="40px" ><td>��й�ȣ</td><td><form:password path="pass" />
		</td></tr>
		<tr height="40px" ><td>�̸���</td><td><form:input path="email"/>
		</td></tr>
		<tr height="40px" ><td>��ȭ��ȣ</td><td><form:input path="tel"/>
		</td></tr>
		<tr height="40px" ><td>�������</td><td><form:input type="Date" path="birth"/>
		</td></tr>
	<c:if test="${user.type==1}">
	 	<tr height="40px" ><td>��밡�ɱ��</td><td><form:input path="usetech"/>
	 	</td></tr>
	 	<tr height="40px" ><td>�����Ͽ���</td>
			<td><form:radiobutton path="rating" value="0" checked="checked"/>��Ͼ���
				<form:radiobutton path="rating" value="1"/>�����</td>
		</tr>
	 </c:if>
	 <c:if test="${user.type==2}">
	 	<tr height="40px" ><td>����ڹ�ȣ</td><td><form:input path="businessnum"/>
	 	</td></tr>
	 	<tr height="40px" ><td>����� ���¹�ȣ</td><td><form:input path="creditnum"/>
	 	</td></tr>
	 </c:if>
		<tr height="40px"><td colspan="2" align="center">
		  <input type="submit" value="����"><input type="reset" value="�ʱ�ȭ">
		  </td></tr></table></form:form></body>
</html>