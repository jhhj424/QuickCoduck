<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My DUCK</title>
</head>
<body>
<table border="1">
<tr align="center" valign="middle" bordercolor="#212121">
	<th width="8%" height="26">번호</th>
	<th width="14%" height="26">글쓴이</th>
	<th width="48%" height="26">제목</th>
	<th width="10%" height="26">추천수</th>
	<th width="10%" height="26">DUCK수</th>
	<th width="10%" height="26">조회수</th>
</tr>
<c:forEach var="board" items="${boardlist}">
	<tr align="center" valign="middle" bordercolor="#333333"
		onmouseover="this.style.backgroundColor='#5CD1E5'"
		onmouseout="this.style.backgroundColor=''">
		<td height="23">${ducknum}</td> <%--duck개시물번호 --%>
	<c:set var="boardcnt" value="${duckcnt - 1}" />
		<td align="left">${board.userid}</td>
		<td align="left">
			<a href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="center">${board.recmd}</td>
		<td align="center">${board.duckcnt}</td>
		<td align="right">${board.readcnt}</td>
	</tr>
</c:forEach>
</table>
</body>
</html>