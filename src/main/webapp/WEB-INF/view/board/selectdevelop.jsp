<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>개발자 목록</title>
</head>
<body>
<c:if test="${!empty developlist}">
	<table border="1" style="border-collapse: collapse; width: 100%">
		<tr>
			<th>사진</th>
			<th>아이디</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>보유기술</th>
			<th>현재상태</th>
		</tr>
		<c:forEach items="${developlist}" var="user">
			<tr>
				<td align="center"><a href="../file/${user.fileurl}"> <img
						src="../file/${user.fileurl}" class="w3-circle"
						style="height: 50px; width: 50px" alt="사진없음">
				</a></td>
				<td>${user.userid}</td>
				<td>${user.email}</td>
				<td>${user.tel}</td>
				<td>${user.usetech}</td>
				<td>
					대기중...
				</td>
			</tr>
		</c:forEach>
		<tr>
		<td align="center" colspan="6">
		<a href="../board/find.duck?type=3">[게시물목록]</a>
		</td>
		</tr>
	</table>
</c:if>
<c:if test="${empty developlist}">
		<h1>선택한 개발자 없음</h1>
		<a href="../board/find.duck?type=3">[게시물목록]</a>
</c:if>
</body>
</html>