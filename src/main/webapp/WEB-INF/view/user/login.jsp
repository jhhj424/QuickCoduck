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
<!-- /mavenshop3/user/loginForm.shop ��û�� login.jsp�� ȭ�鿡 ����ϱ�
	 /mavenshop3/user/login.shop ��û�� login.jsp�� ��ȿ�� ���� ȭ�鿡 ����ϱ�  -->
<form:form modelAttribute="user" method="post" action="login.shop">
  <input type="hidden" name="userName" value="��ȿ������ȸ�ǿ뵵" />
  <spring:hasBindErrors name="user">
   <font color="red">
    <c:forEach items="${errors.globalErrors}" var="error">
      <spring:message code="${error.code}" />
    </c:forEach>
   </font>
  </spring:hasBindErrors>
  <h2>�α���</h2>
  <table>
   <tr height="40px"><td>���̵�</td><td><form:input path="userId" />
   		<font color="red"><form:errors path="userId" /></font></td></tr>
   <tr height="40px"><td>��й�ȣ</td><td><form:password path="password" />
   		<font color="red"><form:errors path="password" /></font></td></tr>
   <tr height="40px"><td colspan="2" align="center">
   		<input type="submit" value="�α���">
   		<input type="button" value="ȸ������" onclick="location.href='userEntry.shop'">
   		</td></tr>
  </table>
</form:form>
</body>
</html>