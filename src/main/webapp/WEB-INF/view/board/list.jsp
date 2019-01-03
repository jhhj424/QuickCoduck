<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script type="text/javascript">
	function list(pageNum){
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value="";
			document.searchform.pageNum.value="1";
			location.href = "list.duck?pageNum=" + pageNum +"&type=${param.type}";
		} else {
			document.searchform.pageNum.value=pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 100%" >
	<tr><td colspan="5" align="center">
		<form action="list.duck" method="post" name="searchform" onsubmit="return list(1)" >
		<input type="hidden" name="pageNum" value="1">
		<select name="searchType" id="searchType">
			<option value="">선택하세요</option>
			<option value="subject">제목</option>
			<option value="name">글쓴이</option>
			<option value="content">내용</option>
		</select>&nbsp;
		<script type="text/javascript">
			if('${param.searchType}' != '') {
				document.getElementById("searchType").value = '${param.searchType}';
			}
		</script>
		<input type="text" name="searchContent" value="${param.searchContent}" >
		<input type="submit" value="검색">
		</form>	
	</td></tr>
	<c:if test="${listcount > 0}"><%-- 게시물이 있는경우 --%>
		<tr align="center" valign="middle">
		<c:if test="${param.type==1}">
			<td colspan="4">오픈소스게시판</td><td>글개수:${listcount}</td>
		</c:if>
		<c:if test="${param.type==2}">
			<td colspan="4">개발자자유게시판</td><td>글개수:${listcount}</td>
		</c:if>
		<c:if test="${param.type==3}">
			<td colspan="4">프로젝트공고모집게시판</td><td>글개수:${listcount}</td>
		</c:if>
		</tr>			
		<tr align="center" valign="middle" bordercolor="#212121">
			<th width="8%" height="26">번호</th><th width="50%" height="26">제목</th>
			<th width="14%" height="26">글쓴이</th><th width="17%" height="26">날짜</th>
			<th width="11%" height="26">조회수</th></tr>
	<c:forEach var="board" items="${boardlist}">
		<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.backgroundColor='#5CD1E5'"
			onmouseout="this.style.backgroundColor=''">
			<td height="23">${boardcnt}</td>
			<c:set var="boardcnt" value="${boardcnt - 1}"/>
			<td align="left">
			<c:if test="${! empty board.fileurl}">
				<a href="../file/${board.fileurl}">@</a></c:if>
			<c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;</c:if>
				<a href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
			</td>
			<td align="left">${board.userid}</td><td align="center">${board.regdate}</td>
			<td align="right">${board.readcnt}</td></tr>
	</c:forEach>
		<tr align="center" height="26"><td colspan="5">
		 <c:if test="${pageNum > 1}"><a href="javascript:list(${pageNum -1})">[이전]</a></c:if>
		 <c:if test="${pageNum <= 1}">[이전]</c:if>
		 <c:forEach var="a" begin="${startpage}" end="${endpage}">
		 <c:if test="${a==pageNum}">[${a}]</c:if>
		 <c:if test="${a!=pageNum}"><a href="javascript:list(${a})">[${a}]</a></c:if>
		 </c:forEach>
		 <c:if test="${pageNum < maxpage}">
		 	<a href="javascript:list(${pageNum +1})">[다음]</a>
		 </c:if>
		 <c:if test="${pageNum >= maxpage}">[다음]</c:if>
		</td></tr>
	</c:if>
	<c:if test="${listcount == 0}">
		<tr><td colspan="5">등록된 게시물이 없습니다.</td></tr>
	</c:if>
	<tr><td colspan="5" align="right"><a href="write.duck?type=${param.type}">[글쓰기]</a></td></tr>
	</table>
  		<a href="../board/list.duck?type=1">오픈소스게시판</a>
  		<a href="../board/list.duck?type=2">개발자자유게시판</a>
  		<a href="../board/list.duck?type=3">프로젝트공고모집게시판</a></body></html>