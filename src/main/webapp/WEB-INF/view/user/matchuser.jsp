<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>매칭유저 보기</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 100%">
			<tr>
				<td colspan="7">회원 목록</td>
			</tr>
			<tr>
				<td>사진</td>
				<td>아이디</td>
				<td>이메일</td>
				<td>전화번호</td>
				<td>보유기술</td>
				<td>선택</td>
			</tr>
			<c:if test="${ON != 1}">
			<c:forEach items="${userlist}" var="user">
				<tr style="height: 60px;">
					<td>
						<a href="../file/${user.fileurl}">
							<img src="../file/${user.fileurl}" class="w3-circle" style="height:50px;width:50px" alt="사진없음">
						</a>
					</td>
					<td>${user.userid}</td>
					<td>${user.email}</td>
					<td>${user.tel}</td>
					<td>${user.usetech}</td>
					<td>
						<input type="button" value="선택하기" onclick="location.href='#'">
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${ON == 1}">
			<h1>조건을 만족하는 개발자가 없음</h1>
			</c:if>
			<tr>
			<td colspan="6">
				<a href="../board/find.duck?type=${clientboard.boardtype}">[게시물목록]</a>
				</td>
			</tr>
		</table>
</body>
</html>