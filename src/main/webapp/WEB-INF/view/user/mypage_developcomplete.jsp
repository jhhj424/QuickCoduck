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
<title>완료한 프로젝트</title>
<script type="text/javascript">
function evaluation(boardnum){
	var userid = '${loginUser.userid}';
	var msg = confirm("해당 프로젝트를 평가하시겠습니까?");
	if (msg) { //삭제
		 $.ajax({
			url : "evaluation.duck",
			type : "post",
			data : {"boardnum" : boardnum, "userid" : userid},
			dataType : "json",
			success : function(result) {
				alert(result.msg);
				if(result.ok == "ok") {
				location.href = "mypage_project_finished.duck?id="+userid+"&boardnum="+boardnum;					
				}else{
					return false;
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
<script type="text/javascript">
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "mypage_developcomplete.duck?pageNum=" + pageNum;
		} else {
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-vcard-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>완료한 프로젝트
</h2>
<table border="1" style="width:100%;" class="table">
<tr>
	<td colspan="7" align="center">
		<form action="myduck.duck?id=${user.userid}" method="post"
			name="searchform" onsubmit="return list(1)">
			<input type="hidden" name="pageNum" value="1"> 
			<select name="searchType" id="searchType">
				<option value="">선택하세요</option>
				<option value="subject">제목</option>
				<option value="userid">글쓴이</option>
				<option value="content">내용</option>
			</select>&nbsp;
			<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}';
				}
			</script>
			<input type="text" name="searchContent" value="${param.searchContent}" class="search" placeholder="내용을 입력해주세요">
		    <input type="submit" value="검색"class="submit">
		</form>
	</td>
</tr>
<tr align="center">
	<th width="6%" class="th" style="font-weight:bold;">번호</th>
	<th width="10%" class="th" style="font-weight:bold;">글쓴이</th>
	<th width="45%" class="th" style="font-weight:bold;">제목</th>
	<th width="10%" class="th" style="font-weight:bold;">조회수</th>
	<th width="10%" class="th" style="font-weight:bold;">평가하기</th>
</tr>

<c:forEach var="board" items="${developcomplete}">
	<tr align="center"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td class="th"> ${boardcnt+1} </td> <%--duck개시물번호 --%>
		<td align="left" class="th">${board.userid}</td>
		<td align="left" class="th">
			<a href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="right" class="th">${board.readcnt}</td>
		<td align="center" class="th"><input type="button" value="평가하기" onclick="evaluation(${board.boardnum})" class="button"></td>
	</tr>
</c:forEach>
<tr align="center" class="page">
	<td colspan="7"><c:if test="${pageNum > 1}">
		<a href="javascript:list(${pageNum -1})"><i class="fa fa-arrow-left w3-large"></i>이전</a>
	</c:if> <c:if test="${pageNum <= 1}"><i class="fa fa-arrow-left w3-large"></i>이전</c:if>
	<c:forEach var="a" begin="${startpage}" end="${endpage}">
		<c:if test="${a==pageNum}">[${a}]</c:if>
		<c:if test="${a!=pageNum}">
			<a href="javascript:list(${a})">[${a}]</a>
		</c:if>
	</c:forEach> <c:if test="${pageNum < maxpage}">
		<a href="javascript:list(${pageNum +1})">다음<i class="fa fa-arrow-right w3-large"></i></a>
	</c:if> <c:if test="${pageNum >= maxpage}">다음<i class="fa fa-arrow-right w3-large"></i></c:if></td>
</tr>
</table>
<p></p>
</div>
</body>
</html>