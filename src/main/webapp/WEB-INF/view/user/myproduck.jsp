<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클라이언트 마이페이지용</title>
</head>
<body>

<table border="1" style="width:100%;" class="table">
<tr>
	<td colspan="6" align="center">
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
	<th width="8%" class="th" style="font-weight:bold;">번호</th>
	<th width="14%" class="th" style="font-weight:bold;">글쓴이</th>
	<th width="45%" class="th" style="font-weight:bold;">제목</th>
	<th width="10%" class="th" style="font-weight:bold;">추천수</th>
	<c:if test="${type==3}">
	<th width="13%" class="th" style="font-weight:bold;">관심등록수</th>
	</c:if>
	<th width="10%" class="th" style="font-weight:bold;">조회수</th>
</tr>

<c:forEach var="board" items="${prolist}">
	<tr align="center"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
		<c:set var="boardcnt" value="${boardcnt-1}" />
		<td class="th"style="font-weight:bold;"> ${boardcnt+1} </td> <%--duck개시물번호 --%>
	
		<td align="left"class="th">${board.userid}</td>
		<td align="left"class="th">
			<a href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="center"class="th">${board.recmd}</td>
		<td align="center"class="th">${board.duckcnt}</td>
		<td align="right"class="th">${board.readcnt}</td>
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
</body>
</html>