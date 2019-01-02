<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Spring 게시판 삭제</title>
</head>
<body>
<form action="delete.duck" name="f" method="post">
	<input type="hidden" name="num" value="${param.num}">
	<table border="2" style="border-collapse: collapse; width: 100%" >
		<tr><td>게시글 비밀번호</td><td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2"><a href="javascript:document.f.submit();">[삭제]</a></td></tr>
	</table>
</form>
</body>
</html>