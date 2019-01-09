<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/board_list.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script type="text/javascript">
	function list(pageNum) {
		var type = document.searchform.type.value;
		if (type == null || type.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "list.duck?pageNum=" + pageNum
					+ "&type=${param.type}";
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
<div id="wrap">
<div class="table-users">
<div class="header">
<c:if test="${param.type==1}">
오픈소스 게시판
</c:if>
<c:if test="${param.type==2}">
개발자 자유게시판
</c:if>
<c:if test="${param.type==3}">
프로젝트 공고모집 게시판
</c:if>
</div>
<!-- header -->
<table>
<!-- 게시글 존재 안할시 -->
<c:if test="${listcount == 0}">
<tr>
<td width="27%"></td>
<td width="45%"><font style="font-weight: bold;">등록된 게시글이 없습니다.</font></td>
<td width="28%" align="right" class="top">
<a href="write.duck?type=${param.type}">
<font style="font-weight: bold;">
<img src="${path}/review1.png" style="height: 25px;weight:25px;">
글쓰기</font>
</a></td>
</tr>
<tr><td colspan="6"><a href="../board/list.duck?type=1">오픈소스게시판</a>
<a href="../board/list.duck?type=2">개발자자유게시판</a>
<a href="../board/list.duck?type=3">프로젝트공고모집게시판</a></td></tr>
</c:if>
<!-- 게시글 존재 할시 -->			
<c:if test="${listcount > 0}">
<tr>
<th style="font-weight:bold;">
<img src="${path }/rating.png" style="width: 25px; height: 25px;">
QuickCoduck
</th>
<td colspan="4">
<form action="list.duck?type=${param.type}" method="post" name="searchform" onsubmit="return list(1)">
<input type="hidden" name="pageNum" value="1">
<img src="${path}/lens.png" style="height: 25px;weight:25px;">
게시글 찾기:
<select name="type" id="type">
<option value="">선택하세요</option>
<option value="subject">제목</option>
<option value="userid">글쓴이</option>
<option value="content">내용</option>
</select>
<script type="text/javascript">
if ('${param.type}' != '') {
document.getElementById("type").value = '${param.type}';
}
</script>
<input type="text" name="searchContent" size="50" value="${param.searchContent}">
<input type="submit"value="검색" class="delete">
</form>
</td>
<c:if test="${param.type==1}">
<td colspan="1" style="text-align:center;" class="buttom">
<font style="font-weight: bold;">
<img src="${path }/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>

<c:if test="${param.type==2}">
<td colspan="1" style="text-align:center;" class="buttom">
<font style="font-weight: bold;">
<img src="${path }/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>

<c:if test="${param.type==3}">
<td colspan="1" style="text-align:center;" class="buttom">
<font style="font-weight: bold;">
<img src="${path }/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>

</tr>

<!-- 중간저장 -->
<tr>
<th width="13%" scope="row"><font style="font-weight: bold;">글번호</font></th>
<th width="10%" scope="row"><font style="font-weight: bold;">사진</font></th>
<th width="35%" scope="row"><font style="font-weight: bold;">제목</font></th>
<th width="14%" scope="row"><font style="font-weight: bold;">글쓴이</font></th>
<th width="17%" scope="row"><font style="font-weight: bold;">날짜</font></th>
<th width="11%" scope="row"><font style="font-weight: bold;">조회수</font></th>
</tr>

<c:forEach var="board" items="${boardlist}">
<tr align="center" valign="middle">
<td>
<font style="border-bottom: 2px solid #2ac1bc; color: #000; font-weight: bold;">
${boardcnt}.<sub>st</sub>게시글</font>
</td>
<!-- 게시글번호 -->
<td>
 <c:if test="${!empty board.file1 }">
<a href="file/${board.file1 }" style="text-decoration: none;">
<img src="${path }/pictures.png" style="width: 20px; height: 20px;"> </a>
<%--<img src="file/file12.png" width="20" height="20"> --%>
</c:if>
<c:if test="${empty board.file1 }">
<img src="${path }/nullpic.png" style="width: 20px; height: 20px;">
</c:if>
</td>
<!-- 첨부파일 여부 -->
<c:set var="boardcnt" value="${boardcnt - 1}" />
<td><font style="border-bottom: 2px solid #2ac1bc; color: #000; font-weight: bold;">
<a href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}
<c:if test="${board.boardtype==1}">추천 - ${board.recmd}</c:if></a></font>
</td>
<!-- 제목 디테일 -->
<td><font style="border-bottom: 2px solid #2ac1bc; color: #000; font-weight: bold;">
${board.userid}</font>
</td>
<!-- 작성자 -->
<td><font style="border-bottom: 2px solid #2ac1bc; color: #000; font-weight: bold;">
${board.regdate}</font>
</td>
<!-- 작성일 -->
<td><font style="border-bottom: 2px solid #2ac1bc; color: #000; font-weight: bold;">
${board.readcnt}</font>
</td>
<!-- 조회수 -->
</tr>
</c:forEach>
</c:if>
<!-- 페이징 부분 -->
<c:if test="${listcount != 0}">
<tr align="center">
<td></td>
<td colspan="4">
<c:if test="${pageNum > 1}"><font style="font-weight: bold;">
<a href="javascript:list(${pageNum -1})">[이전]</a></font>
</c:if>
<c:if test="${pageNum <= 1}">
<font style="font-weight: bold;">
[이전]</font></c:if>
<c:forEach var="a" begin="${startpage}" end="${endpage}">

<c:if test="${a==pageNum}">
<font style="font-weight: bold;">
[${a}]</font>
</c:if>
<c:if test="${a!=pageNum}">
<font style="font-weight: bold;">
<a href="javascript:list(${a})">
[${a}]</a></font>
</c:if>
</c:forEach>
<c:if test="${pageNum < maxpage}"><font style="font-weight: bold;">
<a href="javascript:list(${pageNum +1})">[다음]</a></font>
</c:if>
<c:if test="${pageNum >= maxpage}">
<font style="font-weight: bold;">
[다음]</font></c:if>
</td>
<td colspan="1" align="right" class="top">
<a href="write.duck?type=${param.type}">
<font style="font-weight: bold;">
<img src="${path}/review1.png" style="height: 25px;weight:25px;">
글쓰기</font>
</a></td>
</tr>
<tr><td colspan="6"><a href="../board/list.duck?type=1">오픈소스게시판</a>
<a href="../board/list.duck?type=2">개발자자유게시판</a>
<a href="../board/list.duck?type=3">프로젝트공고모집게시판</a></td></tr>
</c:if>
</table>
</div>
<!-- table-users -->
</div>
</body>
</html>