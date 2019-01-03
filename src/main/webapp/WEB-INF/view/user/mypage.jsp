<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����������</title>
</head>
<body>
 
 <table border="1" width="100%">
		 <tr><td colspan="2">ȸ������</td></tr>
		 <tr><td>���̵�</td><td>${user.userid}</td></tr>
		 <tr><td>�̸���</td><td>${user.email}</td></tr>
		 <tr><td>�ڵ���</td><td>${user.tel}</td></tr>
		 <tr><td>�������</td>
		 	<td><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd"/>
		 </td></tr>
		 <c:if test="${user.type==1}">
		 	<tr><td>��밡�ɱ��</td>
		 		<td>${user.usetech}</td></tr>
		 	<tr><td>�����Ͽ���</td>
		 		<c:if test="${user.rating==0}">
		 			<td>��Ͼ���</td>
		 		</c:if>
		 		<c:if test="${user.rating==1}">
		 			<td>�����</td>
		 		</c:if>
		 	</tr>
		 </c:if>
		 <c:if test="${user.type==2}">
		 	<tr><td>����ڹ�ȣ</td>
		 		<td>${user.businessnum}</td></tr>
		 	<tr><td>����� ���¹�ȣ</td>
		 		<td>${user.creditnum}</td></tr>
		 </c:if>
		 <tr><td>��Ī����</td>
		 	 <c:if test="${user.matching==0}">
		 	 	<td>��Ī�ȵ�</td>
		 	 </c:if>
		 	 <c:if test="${user.matching==1}">
		 	 	<td>��Ī������</td>
		 	 </c:if>
		 	 <c:if test="${user.matching==2}">
		 	 	<td>��Ī��</td>
		 	 </c:if>
		 </tr>
  </table>
  
  
  <a href="updateForm.shop?id=${user.userid}">[ȸ����������]</a>&nbsp;
		 <c:if test="${loginUser.userid !='admin'}">
		 	<a href="delete.shop?id=${user.userid}">[ȸ��Ż��]</a>&nbsp;
		 </c:if>
		 <c:if test="${loginUser.userid =='admin'}">
		 	<a href="../admin/list.duck">[ȸ�����]</a>&nbsp;
		 </c:if>
		 <a href="logout.shop?id=${user.userid}">[�α׾ƿ�]</a>&nbsp;
</body>
</html>