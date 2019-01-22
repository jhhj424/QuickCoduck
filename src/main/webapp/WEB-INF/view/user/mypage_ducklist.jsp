<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My DUCK LIST</title>
<script type="text/javascript">

	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "mypage_ducklist.duck?id=" + ${loginUser.userid} + "&pageNum=" + pageNum + "&ducktype=1&boardtype=1";
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
<i class="fa fa-heart fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>'Duck' 한 오픈소스
<c:if test="${loginUser.type == '1' && param.ducktype == '1' && param.type == '3' }">
<i class="fa fa-heart fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>관심 프로젝트</c:if>
<c:if test="${loginUser.type == '1' && param.ducktype == '2' && param.type == '3' }">
<i class="fa fa-vcard-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>지원내역</c:if>
<c:if test="${loginUser.type == '1' && param.ducktype == '3' && param.type == '3' }">
<i class="fa fa-handshake-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>진행중인 프로젝트</c:if>
<c:if test="${loginUser.type == '1' && param.ducktype == '4' && param.type == '3' }">
<i class="fa fa-check-square-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>완료한 프로젝트</c:if>

<c:if test="${loginUser.type == '2' && param.ducktype == '1' && param.type == '3' }">
<i class="fa fa-heart fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>추천인재 목록</c:if>
<c:if test="${loginUser.type == '2' && param.ducktype == '2' && param.type == '3' }">
<i class="fa fa-vcard-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>대기중인 프로젝트</c:if>
<c:if test="${loginUser.type == '2' && param.ducktype == '3' && param.type == '3' }">
<i class="fa fa-handshake-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>진행중인 프로젝트</c:if>
<c:if test="${loginUser.type == '2' && param.ducktype == '4' && param.type == '3' }">
<i class="fa fa-check-square-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>완료한 프로젝트</c:if>
</h2>
<table border="1" style="width:100%;" class="table">
<tr>
	<td colspan="7" align="center">
		<form action="mypage_ducklist.duck" method="post"
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
	<th width="10%" class="th" style="font-weight:bold;">추천수</th>
	<th width="10%" class="th" style="font-weight:bold;">DUCK수</th>
	<th width="10%" class="th" style="font-weight:bold;">조회수</th>
	<th width="10%" class="th" style="font-weight:bold;">삭제</th>
</tr>

<c:forEach var="board" items="${boardlist}">
	<tr align="center"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
		<td class="th"> ${boardcnt} </td> <%--duck개시물번호 --%>
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td align="left" class="th">${board.userid}</td>
		<td align="left" class="th">
			<a href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="center" class="th">${board.recmd}</td>
		<td align="center" class="th">${board.duckcnt}</td>
		<td align="right" class="th">${board.readcnt}</td>
		<td>
			<button type="button" id="userprodelete" onclick="location.href='userprodelete.duck?userid=${user.userid}&num=${board.boardnum}&ducktype=1&type=1'">삭제</button>
		</td>
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