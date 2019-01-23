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
			location.href = "mypage_suggestlist.duck?id=" + ${loginUser.userid} + "&pageNum=" + pageNum + "&ducktype=6";
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
<i class="fa fa-bell-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>제안받은 프로젝트
</h2>
<table border="1" style="width:100%;" class="table">
<tr>
	<td colspan="6" align="center">
		<form action="mypage_suggestlist.duck" method="post"
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
	<th width="8%" class="th" style="font-weight:bold;">번호</th>
	<th width="14%" class="th" style="font-weight:bold;">글쓴이</th>
	<th width="45%" class="th" style="font-weight:bold;">제목</th>
	<th width="13%" class="th" style="font-weight:bold;">관심등록수</th>
	<th width="10%" class="th" style="font-weight:bold;">조회수</th>
</tr>
<c:forEach var="board" items="${boardlist}">
	<tr align="center"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
		<td class="th"> ${boardcnt} </td> <%--duck게시물번호 --%>
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td align="left" class="th">${board.userid}</td>
		<td align="left" class="th">
			<a href="../board/suggest_detail.duck?boardnum=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="center" class="th">${board.duckcnt}</td>
		<td align="right" class="th">${board.readcnt}</td>
	</tr>
</c:forEach>
<tr align="center" class="page">
	<td colspan="6"><c:if test="${pageNum > 1}">
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