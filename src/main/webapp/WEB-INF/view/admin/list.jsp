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
<style>
.table {
	font-family: "Roboto", sans-serif;
	border: 2px solid #ada6a6;
	border-radius: 5px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
	border-bottom-left-radius: inherit;
	border-bottom-right-radius: inherit;
	line-height: 3;
	background-color: #FEFEFE;
}

.th {
	font-family: "Roboto", sans-serif;
	font-size: 15px;
	font-weight: 600;
}

a {
	font-family: "Roboto", sans-serif;
	text-decoration: none;
}

font {
	font-family: "Roboto", sans-serif;
	font-size: 20px;
	color: #363636e0; font-weight : bold;
	text-shadow: 1px 0px 0px #666666;
	font-weight: bold;
}

.tag {
	background: #009688;
	color: #fff;
	border-radius : 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
	border-radius: 10px;
}
.tag2 {
	background: #f95959b8;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.id {
	width: 10%;
}

.type {
	width: 12%
}

.tech {
	width: 40%
}

.email {
	width: 10%
}

.info {
	width: 25%;
}

.chk {
	width: 3%;
}
</style>
</head>
<body>
	<div class="w3-container w3-card w3-white w3-round w3-margin">
		<h2 class="w3-text-grey w3-padding-16">
			<i
				class="fa fa-address-card-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>QuickCoduck
			회원목록
		</h2>
		<form action="mailForm.duck" method="post">
			<table border="1" style="border-collapse: collapse; width: 100%;"
				class="table">
				<tr>
					<td colspan="6"><i
						class="fa fa-address-card-o fa-fw w3-margin-right w3-xlarge w3-text-teal w3-margin-left"></i><font>회원목록</font>
					</td>
				</tr>
				<tr>
					<td class="th">아이디</td>
					<td class="th">회원타입</td>
					<td class="th">기술목록</td>
					<td class="th">이메일</td>
					<td class="th">정보수정</td>
					<td class="th"><input type="checkbox" name="allchk"
						onchange="allchkbox(this)"></td>
				</tr>
				<c:forEach items="${userlist}" var="user">
					<tr>
						<td class="id">${user.userid}</td>
						<td class="type"><c:if test="${user.type == 1}">개발자</c:if> <c:if
								test="${user.type == 2}">클라이언트</c:if> <c:if
								test="${user.type == 3}">관리자</c:if></td>
						<td class="tech">
						<c:if test="${!empty user.usetech }">
					        <c:forEach var="tech" items="${user.usetech}" varStatus="g" begin="0">
								<span class="tag">${tech}</span>
								<c:out value="${g.end}" />
							</c:forEach>
						</c:if>
						<c:if test="${empty user.usetech }">
						<span class="tag2">Empty Tech</span>
						</c:if>
							
							</td>
						<td class="email">${user.email}</td>
						<td class="info" style="text-align: center;"><a
							href="../user/mypage_update.duck?id=${user.userid}">수정</a> <a
							href="../user/mypage_delete.duck?id=${user.userid}">강제탈퇴</a> <a
							href="../user/mypage_info.duck?id=${user.userid}">회원정보</a></td>
						<td class="chk"><input type="checkbox" name="idchks"
							value="${user.userid}"></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="6" align="center"><input type="submit"
						value="메일보내기"></td>
				</tr>
			</table>
		</form>
		<div style="margin-bottom: 30px;"></div>
	</div>
</body>
</html>