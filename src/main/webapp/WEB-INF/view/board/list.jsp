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
		var type = document.searchform.searchType.value;
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
<div id="wrap" style="margin-bottom:50px;">
<div class="table-users">
<div class="header">
  <div class="pagenation">
    <a class="pager-home" style="color:white;">
     <c:if test="${param.type==1}">오픈소스 게시판</c:if>
     <c:if test="${param.type==2}">자유게시판</c:if>
     <c:if test="${param.type==3}">프로젝트 공고모집 게시판</c:if></a>
  </div>
</div>
<!-- header -->
<table>		
<tr>
<th style="font-weight:bold;">
<img src="../workpic/rating.png" style="width: 25px; height: 25px;">
QuickCoduck
</th>
<td colspan="4" style="border-radius: 3px;">
<form action="list.duck?type=${param.type}" method="post"
			name="searchform" onsubmit="return list(1)" style="">
			<input type="hidden" name="pageNum" value="1">
			<img src="../workpic/lens.png" style="height: 25px;weight:25px;">게시글 찾기: 
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
<c:if test="${param.type==1}">
<td colspan="1" style="text-align:center;border:1px solid grey;border-radius: 3px;" class="buttom">
<font style="font-weight: bold;">
<img src="../workpic/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>

<c:if test="${param.type==2}">
<td colspan="1" style="text-align:center;" class="buttom">
<font style="font-weight: bold;">
<img src="../workpic/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>

<c:if test="${param.type==3}">
<td colspan="1" style="text-align:center;" class="buttom">
<font style="font-weight: bold;">
<img src="../workpic/review.png" style="width: 25px; height: 25px;">
글개수 : ${listcount}</font>
</td>
</c:if>
</tr>
<!-- 게시글 존재 할시 -->	
<c:if test="${listcount > 0}">

<tr>
<th width="13%" scope="row"><font style="font-weight: bold;">글번호</font></th>
<th width="10%" scope="row"><font style="font-weight: bold;">사진</font></th>
<th width="35%" scope="row"><font style="font-weight: bold;">제목</font></th>
<th width="14%" scope="row"><font style="font-weight: bold;">글쓴이</font></th>
<th width="17%" scope="row"><font style="font-weight: bold;">날짜</font></th>
<th width="11%" scope="row"><font style="font-weight: bold;">조회수</font></th>
</tr>
<c:forEach var="notice" items="${noticelist}">
<tr align="center" valign="middle">
<td>
<span class="notice">
<font style=" color: #fff; font-weight: bold; font-size:15px;">
<i class="fa fa-bullhorn w3-margin-right"></i>공지</font></span>
</td>
<!-- 게시글번호 -->
<td>
<c:if test="${!empty notice.fileurl }">
<a href="../file/${notice.fileurl}" style="text-decoration: none;">
<img src="../workpic/pictures.png" style="width: 20px; height: 20px;">첨부파일</a>
<%--<img src="file/file12.png" width="20" height="20"> --%>
</c:if>
<c:if test="${empty notice.fileurl }">
<img src="../workpic/nullpic.png" style="width: 20px; height: 20px;">
</c:if>
</td>
<!-- 첨부파일 여부 -->
<td>
<a href="detail.duck?num=${notice.boardnum}&type=${notice.boardtype}" style="color:#e40000;font-weight:bold;font-size:16px;">${notice.subject}
<c:if test="${notice.boardtype==1}">추천 - ${notice.recmd}</c:if></a>
</td>
<!-- 제목 디테일 -->
<td><font style="color:#e40000;font-weight:bold;font-size:16px;">
${notice.userid}</font>
</td>
<!-- 작성자 -->
<td><font style="color:#e40000;font-weight:bold;font-size:16px;">
	<!-- 오늘올린 게시물이면 HH:mm 과거에 올렸던건 yy/MM/dd -->
	<fmt:formatDate value="${notice.regdate}" pattern="yy/MM/dd hh:mm"/>
	</font>
</td>
<!-- 작성일 -->
<td><font style="color:#e40000;font-weight:bold;font-size:16px;">
${notice.readcnt}</font>
</td>
<!-- 조회수 -->
</tr>
</c:forEach>

<c:forEach var="board" items="${boardlist}">
<tr align="center" valign="middle">
<td>
<c:set var="boardcnt" value="${boardcnt-1}" />
<font style=" color: #000; font-weight: bold;">
${boardcnt+1}번 게시글</font>
</td>
<!-- 게시글번호 -->
<td>
<c:if test="${!empty board.fileurl }">
<a href="../file/${board.fileurl}" style="text-decoration: none;">
<img src="../workpic/pictures.png" style="width: 20px; height: 20px;">첨부파일</a>
<%--<img src="file/file12.png" width="20" height="20"> --%>
</c:if>
<c:if test="${empty board.fileurl }">
<img src="../workpic/nullpic.png" style="width: 20px; height: 20px;">
</c:if>
</td>
<!-- 첨부파일 여부 -->
<td><font style=" color: #000; font-weight: bold;">
<a href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}
<c:if test="${board.boardtype==1}">추천 - ${board.recmd}</c:if></a></font>
</td>
<!-- 제목 디테일 -->
<td><font style=" color: #000; font-weight: bold;">
${board.userid}</font>
</td>
<!-- 작성자 -->
<td><font style=" color: #000; font-weight: bold;">
	<!-- 오늘올린 게시물이면 HH:mm 과거에 올렸던건 yy/MM/dd -->
	<fmt:formatDate value="${board.regdate}" pattern="yy/MM/dd hh:mm"/>
	</font>
</td>
<!-- 작성일 -->
<td><font style=" color: #000; font-weight: bold;">
${board.readcnt}</font>
</td>
<!-- 조회수 -->
</tr>
</c:forEach>
</c:if>
<!-- 게시글 존재 안할시 -->
<c:if test="${listcount == 0}">
<tr>
<th width="13%" scope="row"><font style="font-weight: bold;">글번호</font></th>
<th width="10%" scope="row"><font style="font-weight: bold;">사진</font></th>
<th width="35%" scope="row"><font style="font-weight: bold;">제목</font></th>
<th width="14%" scope="row"><font style="font-weight: bold;">글쓴이</font></th>
<th width="17%" scope="row"><font style="font-weight: bold;">날짜</font></th>
<th width="11%" scope="row"><font style="font-weight: bold;">조회수</font></th>
</tr>
<tr>
<td style="border:none;"></td>
<td colspan="4" style="border:none;"><font style="font-weight: bold;">등록된 게시글이 없습니다.</font></td>
<td  align="center" style="border:none;">
<a href="write.duck?type=${param.type}"><font style="font-weight: bold;"><img src="../workpic/review1.png" style="height: 25px;weight:25px;">
글쓰기</font>
</a></td>
</tr>
</c:if>
<!-- 페이징 부분 -->
<c:if test="${listcount != 0}">
<tr align="center">
<td></td>
<td colspan="4" class="page">
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
<td colspan="1" align="right" class="top">
<a href="write.duck?type=${param.type}">
<font style="font-weight: bold;">
<img src="../workpic/review1.png" style="height: 25px;weight:25px;">
글쓰기</font>
</a></td>
</tr>
<tr><td colspan="6" style="background-color:#7d97a5">
<p style="color:white"><i class="fa fa-copyright"></i>2019 QuickCoduck Corp</p>
</td></tr>
</c:if>
</table>
</div>
<!-- table-users -->
</div>
</body>
</html>