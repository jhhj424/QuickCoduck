<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>추천인재 목록보기</title>
<script type="text/javascript">
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "mypage_recmdlist.duck?pageNum=" + pageNum;
		} else {
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
<!-- <script type="text/javascript">
function cdelete(userid,ducktype){
	var msg = confirm("해당 개발자를 삭제 하시겠습니까??");
	if (msg) { //삭제
		$.ajax({
			url : "/developdelete.duck",
			type : "post",
			data : {"userid" : userid,	"ducktype" : ducktype},
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
</script> -->
</head>
<body>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-heart fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>추천인재 목록보기
</h2>
<table border="1" style="width:100%;" class="table">
<tr align="center" >
	<th width="5%" class="th" style="font-weight:bold;">번호</th>
	<th width="10%" class="th"style="font-weight:bold;">유저이름</th>
	<th width="15%" class="th"style="font-weight:bold;">이메일</th>
	<th width="55%" class="th"style="font-weight:bold;">보유기술</th>
	<th width="15%" class="th"style="font-weight:bold;">매칭상태</th>
</tr>
<c:forEach var="user" items="${recmdpersonlist}">
	<tr align="center" valign="middle"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
		<td class="th"> ${boardcnt} </td> <%--duck게시물번호 --%>
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td align="center" class="th">${user.userid}</td>
		<td align="center" class="th">${user.email}</td>
		<td align="left" class="th"> 
		<c:forEach var="tech" items="${user.usetech}" varStatus="g" begin="0">
		<span class="tag">${tech}</span>
		<c:out value="${g.end}" />
		</c:forEach>			
		</td>
		<td align="center"class="th"style="font-weight:bold;"><c:if test="${user.matching==1}">
		매칭대기중..</c:if>
		<c:if test="${user.matching==2}">
		<i class="fa fa-handshake-o"></i>매칭종료</c:if>
		<%-- <input type="button" class="btn" value="삭제" onclick="cdelete('${user.userid}',6)"> --%></td>
	</tr>
</c:forEach>
<tr align="center" class="page">
	<td colspan="6">
	<c:if test="${pageNum > 1}">
		<a href="javascript:list(${pageNum -1})"><i class="fa fa-arrow-left w3-large"></i>이전</a>
	</c:if> <c:if test="${pageNum <= 1}"><i class="fa fa-arrow-left w3-large"></i>이전</c:if>
	<c:forEach var="a" begin="${startpage}" end="${endpage}">
		<c:if test="${a==pageNum}">[${a}]</c:if>
		<c:if test="${a!=pageNum}">
			<a href="javascript:list(${a})">[${a}]</a>
		</c:if>
	</c:forEach> <c:if test="${pageNum < maxpage}">
		<a href="javascript:list(${pageNum +1})">다음<i class="fa fa-arrow-right w3-large"></i></a>
	</c:if> <c:if test="${pageNum >= maxpage}">다음<i class="fa fa-arrow-right w3-large"></i></c:if>
	</td>
</tr>
</table>
<p></p>
</div>
</body>
</html>