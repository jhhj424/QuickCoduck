<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:if test="${ON != 1}">
	<c:forEach var="board" items="${boardlist}">
		<div align="center" onmouseover="this.style.backgroundColor='#5CD1E5'"
			onmouseout="this.style.backgroundColor=''"
			style="border: 1px solid; border-color: grey; margin-bottom: 3px;">
			<div align="left">
				<c:if test="${! empty board.fileurl}">
					<a href="../file/${board.fileurl}">@</a>
				</c:if>
				<c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;</c:if>
				<h3>
					<a style="text-decoration: none;"
						href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">&nbsp;&nbsp;&nbsp;${board.subject}<c:if
							test="${board.boardtype==1}"> [추천 : ${board.recmd}]</c:if></a>
				</h3>
			</div>
			<div align="right">날짜:${board.regdate}&nbsp;&nbsp;</div>
			<div align="right">조회수:${board.readcnt}&nbsp;&nbsp;</div>
			<div align="right">선택기술:${tech}&nbsp;&nbsp;</div>
			<div align="right">사용기술:${board.usetech}&nbsp;&nbsp;</div>
		</div>
	</c:forEach>
</c:if>
<c:if test="${ON == 1}">
	<div align="center" onmouseover="this.style.backgroundColor='#5CD1E5'"
		onmouseout="this.style.backgroundColor=''"
		style="border: 1px solid; border-color: grey; margin-bottom: 3px;">
		<div align="center">
			<h1>게시물이 없음</h1>
		</div>
	</div>
</c:if>