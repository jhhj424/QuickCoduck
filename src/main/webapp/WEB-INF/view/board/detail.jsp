<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		<a href="update.duck?num=${board.boardnum}&type=${board.boardtype}">[수정]</a>
		<a href="deleteForm.duck?num=${board.boardnum}&type=${board.boardtype}">[삭제]</a>
		<a href="list.duck?type=${board.boardtype}">[목록]</a>
	</td></tr>
</table>
</body>
</html>