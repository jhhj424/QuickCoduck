<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� �۾���</title>
</head>
<body>
<form:form modelAttribute="board" action="write.duck" enctype="multipart/form-data" name="f">
	<table border="1" style="border-collapse: collapse; width:100%">
	<form:hidden path="boardtype" value="${param.type}"/>
		<tr align="center" valign="middle">
		<c:if test="${param.type==1}">
			<td colspan="4">���¼ҽ��Խ��� �۾���</td>
		</c:if>
		<c:if test="${param.type==2}">
			<td colspan="4">�����������Խ��� �۾���</td>
		</c:if>
		<c:if test="${param.type==3}">
			<td colspan="4">������Ʈ��������Խ��� �۾���</td>
		</c:if>
		</tr>	
		<tr><td align="center">�۾���</td>
		<td><form:input path="userid"/><font color="red"><form:errors path="userid" /></font></td></tr>
		<tr><td align="center">����</td>
		<td><form:input path="subject"/><font color="red"><form:errors path="subject" /></font></td></tr>
		<tr><td align="center">����</td>
		<td><form:textarea path="content" rows="15" cols="80"/>
			<font color="red"><form:errors path="content" /></font></td></tr>
		<tr><td align="center">÷������</td>
			<td><input type="file" name="file1"></td></tr>
		<tr><td colspan="2" align="center">
		<a href="javascript:document.f.submit()">[�Խù����]</a>
		<a href="list.duck">[�Խù����]</a></td></tr>
		</table></form:form></body></html>