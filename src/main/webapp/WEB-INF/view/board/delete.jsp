<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Spring �Խ��� ����</title>
</head>
<body>
<form action="delete.duck" name="f" method="post">
	<input type="hidden" name="boardnum" value="${board.boardnum}">
	<input type="hidden" name="type" value="${board.boardtype}">
	<table border="2" style="border-collapse: collapse; width: 100%" >
		<tr><td>���� ��й�ȣ</td><td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2"><a href="javascript:document.f.submit();">[����]</a></td></tr>
	</table>
</form>
</body>
</html>