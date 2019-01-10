<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>

<c:if test="${type!=5}">
<div class="table14_10" style="width: 100%">
									<div>
										<div align="center">

											<div align="center"
												onmouseover="this.style.backgroundColor='#5CD1E5'"
												onmouseout="this.style.backgroundColor=''"
												style="border: 1px solid; border-color: grey; margin-bottom: 3px; margin-top: 3px">
													<div align="right">													
														<b>글개수:${listcount}</b>
													</div>
												<div align="center" style="margin-top: 5px;">
													<form action="find.duck?type=${param.type}" method="post"
														name="searchform" onsubmit="return list(1)">
														게시글 검색 <input type="hidden" name="pageNum" value="1">
														<select name="searchtype">
															<option value=" ">선택하세요</option>
															<option value="subject">제목</option>
															<option value="userid">글쓴이</option>
															<option value="content">내용</option>
														</select>&nbsp; <input type="text" name="searchContent"
															value="${param.searchContent}"> <input
															type="submit" value="검색">
													</form>
												</div>
											</div>
										</div>
									</div>

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
	<div align="center">
											<div>
												<c:if test="${pageNum > 1}">
													<a href="javascript:find(${pageNum -1})">[이전]</a>
												</c:if>
												<c:if test="${pageNum <= 1}">[이전]</c:if>
												<c:forEach var="a" begin="${startpage}" end="${endpage}">
													<c:if test="${a==pageNum}">[${a}]</c:if>
													<c:if test="${a!=pageNum}">
														<a href="javascript:find(${a})">[${a}]</a>
													</c:if>
												</c:forEach>
												<c:if test="${pageNum < maxpage}">
													<a href="javascript:find(${pageNum +1})">[다음]</a>
												</c:if>
												<c:if test="${pageNum >= maxpage}">[다음]</c:if>
											</div>
										</div>
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
									<div>
										<div align="right">
											<a href="write.duck?type=${param.type}">[글쓰기]</a>
										</div>
									</div>
									</div>
									
</c:if>
<c:if test="${type==5}">

<div class="table14_10" style="width: 100%">
									<div>
										<div align="center">

											<div align="center"
												onmouseover="this.style.backgroundColor='#5CD1E5'"
												onmouseout="this.style.backgroundColor=''"
												style="border: 1px solid; border-color: grey; margin-bottom: 3px; margin-top: 3px">
													<div align="right">													
														<b>나만의소스개수:${mycount}</b>
													</div>
												<div align="center" style="margin-top: 5px;">
													<form action="find.duck?type=${param.type}" method="post"
														name="searchform" onsubmit="return list(1)">
														게시글 검색 <input type="hidden" name="pageNum" value="1">
														<select name="searchtype">
															<option value=" ">선택하세요</option>
															<option value="subject">제목</option>
															<option value="userid">글쓴이</option>
															<option value="content">내용</option>
														</select>&nbsp; <input type="text" name="searchContent"
															value="${param.searchContent}"> <input
															type="submit" value="검색">
													</form>
												</div>
											</div>
										</div>
									</div>

<c:if test="${ON != 1}">
	<c:forEach var="board" items="${mylist}">
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
	<div align="center">
											<div>
												<c:if test="${pageNum > 1}">
													<a href="javascript:find(${pageNum -1})">[이전]</a>
												</c:if>
												<c:if test="${pageNum <= 1}">[이전]</c:if>
												<c:forEach var="a" begin="${startpage}" end="${endpage}">
													<c:if test="${a==pageNum}">[${a}]</c:if>
													<c:if test="${a!=pageNum}">
														<a href="javascript:find(${a})">[${a}]</a>
													</c:if>
												</c:forEach>
												<c:if test="${pageNum < maxpage}">
													<a href="javascript:find(${pageNum +1})">[다음]</a>
												</c:if>
												<c:if test="${pageNum >= maxpage}">[다음]</c:if>
											</div>
										</div>
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
									<div>
										<div align="right">
											<a href="write.duck?type=${param.type}">[글쓰기]</a>
										</div>
									</div>
									</div>
									
</c:if>