<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring 게시판 삭제</title>
</head>
<body>
<form action="delete.duck" name="f" method="post">
	<input type="hidden" name="boardnum" value="${board.boardnum}">
	<input type="hidden" name="type" value="${board.boardtype}">
	<table border="2" style="border-collapse: collapse; width: 100%" >
		<tr><td>유저 비밀번호</td><td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2"><a href="javascript:document.f.submit();">[삭제]</a></td></tr>
	</table>
</form>
</body>
</html>