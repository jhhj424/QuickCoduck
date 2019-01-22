<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
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
<div style="border-collapse:collapse; width:70%;margin-bottom:50px;margin:0 auto;">
<h2 class="w3-text-grey" style="background-color:#FEFEFE;font-weight:bold;">
<i class="fa fa-group w3-margin-right"></i>추천인재 목록</h2>
</div>
<c:if test="${!empty developlist || !empty refuselist || !empty acceptlist}">
	<table border="1" style="border-collapse: collapse; width: 70%;margin:0 auto;margin-bottom:50px;" class="table">
		<tr>
			<th class="th" style="font-weight:bold;">사진</th>
			<th class="th" style="font-weight:bold;">아이디</th>
			<th class="th" style="font-weight:bold;">이메일</th>
			<th class="th" style="font-weight:bold;">전화번호</th>
			<th class="th" style="font-weight:bold;">보유기술</th>
			<th class="th" style="font-weight:bold;">현재상태</th>
		</tr>
		<c:forEach items="${developlist}" var="user">
			<tr>
				<td align="center" class="th"><a href="../file/${user.fileurl}"> <img
						src="../file/${user.fileurl}" class="w3-circle"
						style="height: 50px; width: 50px" alt="사진없음">
				</a></td>
				<td class="th">${user.userid}</td>
				<td class="th">${user.email}</td>
				<td class="th">${user.tel}</td>
				<td class="th"><c:if test="${!empty user.usetech }">
		<c:forEach var="utech" items="${user.usetech}" varStatus="g" begin="0">
        <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
        <c:out value="${g.end}" />
        </c:forEach>
        </c:if>
        <c:if test="${empty user.usetech }">
        <span class="tag2">Empty Tech</span>
        </c:if></td>
				<td class="th" style="font-weight:bold;">
					대기중... <input type="button" class="button1" value="삭제" onclick="cdelete('${user.userid}',6)" >
				</td>
			</tr>
		</c:forEach>
		<c:forEach items="${refuselist}" var="user">
			<tr>
				<td align="center" class="th"><a href="../file/${user.fileurl}"> <img
						src="../file/${user.fileurl}" class="w3-circle"
						style="height: 50px; width: 50px" alt="사진없음">
				</a></td>
				<td class="th">${user.userid}</td>
				<td class="th">${user.email}</td>
				<td class="th">${user.tel}</td>
				<td class="th"><c:if test="${!empty user.usetech }">
		<c:forEach var="utech" items="${user.usetech}" varStatus="g" begin="0">
        <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
        <c:out value="${g.end}" />
        </c:forEach>
        </c:if>
        <c:if test="${empty user.usetech }">
        <span class="tag2">Empty Tech</span>
        </c:if></td>
				<td class="th" style="font-weight:bold;">
					거절함... <input type="button" class="button1" value="삭제" onclick="cdelete('${user.userid}',8)">
				</td>
			</tr>
		</c:forEach>
		<c:forEach items="${acceptlist}" var="user">
			<tr>
				<td align="center" class="th"><a href="../file/${user.fileurl}"> <img
						src="../file/${user.fileurl}" class="w3-circle"
						style="height: 50px; width: 50px" alt="사진없음">
				</a></td>
				<td class="th">${user.userid}</td>
				<td class="th">${user.email}</td>
				<td class="th">${user.tel}</td>
				<td class="th"><c:if test="${!empty user.usetech }">
		<c:forEach var="utech" items="${user.usetech}" varStatus="g" begin="0">
        <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
        <c:out value="${g.end}" />
        </c:forEach>
        </c:if>
        <c:if test="${empty user.usetech }">
        <span class="tag2">Empty Tech</span>
        </c:if></td>
				<td class="th" style="font-weight:bold;">
					수락함!
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="table" style="width:70%;margin:0 auto;margin-bottom:50px;margin-top:50px;">
<h2 class="w3-text-grey" style="background-color:#FEFEFE;">
<i class="fa fa-copyright"></i>2019 QuickCoduck Corp</h2>
<button type="button" id="fail" onclick="location.href='../user/mypage_waitlist.duck'" class="button2" style="font-weight:bold;">
<i class="fa fa-navicon w3-margin-right w3-margin-left"></i>내 게시물 목록보기</button>
</div>
	
</c:if>
<c:if test="${empty developlist && empty refuselist && empty acceptlist}">
<div class="table" style="width:70%;margin:0 auto;margin-bottom:50px;margin-top:50px;">
<h2 class="w3-text-grey" style="background-color:#FEFEFE;">
<i class="fa fa-remove"></i>선택한 개발자 없음</h2>
<button type="button" id="fail" onclick="location.href='../user/mypage_waitlist.duck'" class="button2" style="font-weight:bold;">
<i class="fa fa-navicon w3-margin-right w3-margin-left"></i>내 게시물 목록보기</button>
</div>
</c:if>
</body>
</html>