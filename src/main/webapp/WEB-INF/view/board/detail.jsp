<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �󼼺���</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 100%">
	<tr><td colspan="2">Spring �Խ���</td></tr>
	<tr><td width="15%">�۾���</td><td width="85%">${board.userid}</td></tr>
	<tr><td>����</td><td>${board.subject}</td></tr>
	<tr><td>����</td><td>
		<table width="100%" height="250">
			<tr><td>${fn:replace(board.content, cn, br)}</td></tr>
		</table></td></tr>
	<tr><td>÷������</td><td>&nbsp;
		<c:if test="${!empty board.fileurl}">
			<a href="../file/${board.fileurl}">${board.fileurl}</a>
		</c:if>
	</td></tr>
	<tr><td colspan="2" align="center">
		<a href="reply.duck?num=${board.num}">[�亯]</a>
		<a href="update.duck?num=${board.num}">[����]</a>
		<a href="delete.duck?num=${board.num}">[����]</a>
		<a href="list.duck">[���]</a>
	</td></tr>
</table>
</body>
</html>