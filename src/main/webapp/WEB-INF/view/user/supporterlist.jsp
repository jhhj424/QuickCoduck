<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 목록</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<table border="1" style="border-collapse:collapse; width:100%">
	<tr>
		<th>-(사진)</th>
		<th>아이디</th>
		<th>이메일</th>
		<th>전화번호</th>
		<th>사용기술</th>
		<th>매칭여부</th>
		<th>확인</th>
	</tr>
	<c:forEach items="${supporterlist}" var="user">
		<td>${user.pic}</td>
		<td>${user.userid}</td>
		<td>${user.email}</td>
		<td>${user.tel}</td>
		<td>${user.usetech}</td>
		<td>${user.matching}</td>
		<td>
			<button type="button" id="accept" onclick="location.href='accept.duck?userid=${board.userid}&boardnum=${param.boardnum}'">수락</button>
			<button type="button" id="fail" onclick="location.href='fail.duck?userid=${board.userid}&boardnum=${param.boardnum}'">거절</button>
		</td>
	</c:forEach>
</table>
</body>
</html>