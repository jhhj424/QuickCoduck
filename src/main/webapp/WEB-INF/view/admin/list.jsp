<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<script type="text/javascript">
	function allchkbox(chk) {
		var chks = document.getElementsByName("idchks");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = chk.checked;
		}
	}
</script>
</head>
<body>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-address-card-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>QuickCoduck 회원목록</h2>
	<form action="mailForm.duck" method="post">
		<table border="1" style="border-collapse: collapse; width: 100%">
			<tr>
				<td colspan="7">회원 목록</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>전화번호</td>
				<td>생일</td>
				<td>이메일</td>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="allchk"
					onchange="allchkbox(this)"></td>
			</tr>
			<c:forEach items="${userlist}" var="user">
				<tr>
					<td>${user.userid}</td>
					<td>${user.email}</td>
					<td>${user.tel}</td>
					<td><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /></td>
					<td>${user.email}</td>
					<td><a href="../user/mypage_update.duck?id=${user.userid}">수정</a>
						<a href="../user/mypage_delete.duck?id=${user.userid}">강제탈퇴</a>
						<a href="../user/mypage_info.duck?id=${user.userid}">회원정보</a></td>
					<td><input type="checkbox" name="idchks"
						value="${user.userid}"></td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="7" align="center"><input type="submit"
					value="메일보내기"></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>