<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>개발자 목록</title>
<script type="text/javascript">
function cdelete(userid,ducktype){
	var boardnum = ${param.boardnum}
	var msg = confirm("해당 개발자를 삭제 하시겠습니까??");
	if (msg) { //삭제
		$.ajax({
			url : "developdelete.duck",
			type : "post",
			data : {"userid" : userid,	"boardnum" : boardnum,	"ducktype" : ducktype},
			dataType : "json",
			success : function(result) {
				//alert(result.msg)
				if (result.msg == "OK") {
					alert("삭제되었습니다.");
					location.reload();
				} else {
					alert("삭제에 실패하였습니다.");
				}
			},
			error : function(xhr, status, error) {
				alert("서버오류:"+xhr.status+",error:"+error+",status:"+status);
			}
		})
	} else { //삭제 취소
		//alert("취소")
		return false;
	}
}
</script>
</head>
<body>
<c:if test="${!empty developlist || !empty refuselist || !empty acceptlist}">
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
					대기중... <input type="button" class="btn" value="삭제" onclick="cdelete('${user.userid}',6)">
				</td>
			</tr>
		</c:forEach>
		<c:forEach items="${refuselist}" var="user">
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
					거절함... <input type="button" class="btn" value="삭제" onclick="cdelete('${user.userid}',8)">
				</td>
			</tr>
		</c:forEach>
		<c:forEach items="${acceptlist}" var="user">
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
					수락함!
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
<c:if test="${empty developlist && empty refuselist && empty acceptlist}">
		<h1>선택한 개발자 없음</h1>
		<a href="../board/find.duck?type=3">[게시물목록]</a>
</c:if>
</body>
</html>