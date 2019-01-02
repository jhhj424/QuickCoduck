<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 상세보기</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 100%">
	<tr><td colspan="2">Spring 게시판</td></tr>
	<tr><td width="15%">글쓴이</td><td width="85%">${board.userid}</td></tr>
	<tr><td>제목</td><td>${board.subject}</td></tr>
	<tr><td>내용</td><td>
		<table width="100%" height="250">
			<tr><td>${fn:replace(board.content, cn, br)}</td></tr>
		</table></td></tr>
	<tr><td>첨부파일</td><td>&nbsp;
		<c:if test="${!empty board.fileurl}">
			<a href="../file/${board.fileurl}">${board.fileurl}</a>
		</c:if>
	</td></tr>
	<tr><td colspan="2" align="center">
		<a href="reply.duck?num=${board.num}">[답변]</a>
		<a href="update.duck?num=${board.num}">[수정]</a>
		<a href="delete.duck?num=${board.num}">[삭제]</a>
		<a href="list.duck">[목록]</a>
	</td></tr>
</table>
</body>
</html>