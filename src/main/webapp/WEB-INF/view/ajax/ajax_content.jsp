<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@include file="/WEB-INF/view/style/board_find_css.jsp"%>
<script type="text/javascript">
function write_submit() {
	var usertype = ${loginUser.type}
	var boardtype = ${param.type}
	var userid = '${loginUser.userid}'
	if (usertype != 1 && boardtype == 1 && userid!='admin') {
		alert("개발자만 글을 쓸 수 있습니다.");
		return false;
	}
	if (usertype != 2 && boardtype == 3 && userid!='admin') {
		alert("클라이언트만 글을 쓸 수 있습니다.");
		return false;
	}
	location.href = "write.duck?type="+boardtype;
}
</script>
<c:if test="${type!=5}">
<div class="div" style="width: 100%">
									<div>
										<div align="center">

											<div align="center"
												onmouseover="this.style.backgroundColor=''"
												onmouseout="this.style.backgroundColor=''"
												>
													<div align="right" class="listcount_div">													
														<b class="listcount_b">
														<i class="fa fa-asterisk w3-text-teal"></i>
														글개수: ${listcount}</b>
													</div>
												<div align="center" style="margin-top: 5px;">
													<form action="find.duck?type=${param.type}" method="post"
														name="searchform" onsubmit="return list(1)" class="form">
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
															<div><!-- 글쓰기 -->
										<div align="center">
										<c:if test="${loginUser.type == 2 && loginUser.maxcount != 0 && param.type == 3}">
											<button type="button"
								onclick="location.href='javascript:write_submit()'" class="button">프로젝트 등록</button>
								        </c:if>
								        <c:if test="${loginUser.type == 2 && loginUser.maxcount == 0 && param.type == 3}">
								        <p>공고를 사용하시려면 상품을 먼저 결제해주세요.</p>
											<button type="button"
								onclick="location.href='../user/mypage_item.duck?id=${loginUser.userid}'" class="button">상품결제</button>
								        </c:if>
								        <c:if test="${loginUser.type == 1 || loginUser.type == 3 || param.type == 1 || param.type == 5}">
											<button type="button"
								onclick="location.href='javascript:write_submit()'" class="button">게시글 작성</button>
								        </c:if>
										</div>
									</div><!-- 글쓰기 끝 -->
											</div>
										</div>
									</div>

<c:if test="${ON != 1}">
	<c:forEach var="board" items="${boardlist}">
		<div align="center" onmouseover="this.style.backgroundColor='#dcdcdcad'"
			onmouseout="this.style.backgroundColor=''"
			class="content">
			<div align="left">
														<c:if test="${! empty board.fileurl}">
															<a href="../file/${board.fileurl}">
															<span class="span"><i class="fa fa-file-image-o w3-margin-right"></i>Image</span>
															</a>
														</c:if>
														<c:if test="${empty board.fileurl}">
														<span class="span2"><i class="fa fa-frown-o w3-margin-right"></i>No-Image</span>
														</c:if>
														<h3 class="h3">
															<a style="text-decoration: none;"
																href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">&nbsp;&nbsp;&nbsp;<b>${board.subject}</b>
														<c:if test="${param.type == 1 }">
														<c:if test="${board.duckcnt > 10}">
														<span class="tag_duck"><i class="fa fa-github"></i> Hot!</span></c:if>
														</c:if><!-- 이벤트! -->
														<c:if test="${param.type == 3 }">
														<c:if test="${board.maxperson-1 <=  board.nowperson}">
														<span class="tag4"><i class="fa fa-certificate"></i> 마감임박!</span></c:if>
														</c:if>	<!-- 임의로 이벤트 하나 만든거임 -->
														<c:if test="${board.boardtype==1}">
														<c:if test="${board.recmd >= 11 }">
														<span class="recmd_best"><i class="fa fa-heart"></i> 추천 : ${board.recmd}</span>
														</c:if>
														<c:if test="${board.recmd <= 10 || board.recmd == 0 }">
														<span class="recmd"><i class="fa fa-thumbs-o-up"></i> 추천 : ${board.recmd}</span>
														</c:if>
														</c:if>
														   </a>
														</h3>
													</div>
													<div align="left" class="thumb"><b style="margin:5px 5px 5px 5px;font-weight:bold;color:#000 !important;"><i class="fa fa-low-vision"></i>내용 미리보기</b><br><c:out value="${board.content}" escapeXml="true"/></div>
													<div align="right" class="right">
													<b>등록일자:</b><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd hh:mm"/>&nbsp;&nbsp;<br>
													<b>조회수:</b>${board.readcnt}&nbsp;&nbsp;
													</div>
			                                        <div align="right"class="right"><b>선택기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty tech }">
			                                        <c:forEach var="utech" items="${tech}" varStatus="g" begin="0">
                                                    <span class="tag"><i class="fa fa-search"></i>${utech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty tech }">
                                                    <span class="tag3"><i class="fa fa-search"></i>검색</span>
                                                    </c:if>
			                                        </div><!-- 선택기술 -->
			                                        <div align="right" class="right"><b>사용기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty board.usetech }">
			                                        <c:forEach var="usetech" items="${board.usetech}" varStatus="g" begin="0">
                                                    <span class="tag">${usetech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty board.usetech }">
                                                    <span class="tag2">Empty Tech</span>
                                                    </c:if>
			                                        </div><!-- 사용기술 -->
				</div>
	</c:forEach>
	<div align="center">
											<div align="center" class="page">
											<div>
												<c:if test="${pageNum > 1}">
													<a href="javascript:list(${pageNum -1})"><i class="fa fa-arrow-left w3-large"></i>이전</a>
												</c:if>
												<c:if test="${pageNum <= 1}"><i class="fa fa-arrow-left w3-large"></i>이전</c:if>
												<c:forEach var="a" begin="${startpage}" end="${endpage}">
													<c:if test="${a==pageNum}">[${a}]</c:if>
													<c:if test="${a!=pageNum}">
														<a href="javascript:list(${a})">[${a}]</a>
													</c:if>
												</c:forEach>
												<c:if test="${pageNum < maxpage}">
													<a href="javascript:list(${pageNum +1})">다음<i class="fa fa-arrow-right w3-large"></i></a>
												</c:if>
												<c:if test="${pageNum >= maxpage}">다음<i class="fa fa-arrow-right w3-large"></i></c:if>
											</div>
										</div>
										</div>
</c:if>
<c:if test="${ON == 1}">
	<div align="center" onmouseover="this.style.backgroundColor='#dcdcdcad'"
		onmouseout="this.style.backgroundColor=''"
		class="content">
		<div align="center">
			<h1>게시물이 없음</h1>
		</div>
	</div>
</c:if>
									</div>
									
</c:if>
<c:if test="${type==5}">

<div class="div" style="width: 100%">
		<div>
			<div align="center">

				<div align="center" onmouseover="this.style.backgroundColor=''"
					onmouseout="this.style.backgroundColor=''">
					<div align="right" class="listcount_div">
						<b class="listcount_b">
						<i class="fa fa-cloud-upload w3-text-teal"></i>
						나만의소스개수: ${mycount}</b>
					</div>
					<div align="center" style="margin-top: 5px;">
						<form action="find.duck?type=${param.type}" method="post"
							name="searchform" onsubmit="return list(1)" class="form">
							게시글 검색 <input type="hidden" name="pageNum" value="1"> <select
								name="searchtype">
								<option value=" ">선택하세요</option>
								<option value="subject">제목</option>
								<option value="userid">글쓴이</option>
								<option value="content">내용</option>
							</select>&nbsp; <input type="text" name="searchContent"
								value="${param.searchContent}"> <input type="submit"
								value="검색">
						</form>
					</div>
					<div>
						<!-- 글쓰기 -->
						<div align="center">
							<c:if
								test="${loginUser.type == 2 && loginUser.maxcount != 0 && param.type == 3}">
								<button type="button"
									onclick="location.href='javascript:write_submit()'"
									class="button">프로젝트 등록</button>
							</c:if>
							<c:if
								test="${loginUser.type == 2 && loginUser.maxcount == 0 && param.type == 3}">
								<p>공고를 사용하시려면 상품을 먼저 결제해주세요.</p>
								<button type="button"
									onclick="location.href='../user/mypage_item.duck?id=${loginUser.userid}'"
									class="button">상품결제</button>
							</c:if>
							<c:if
								test="${loginUser.type == 1 || loginUser.type == 3 || param.type == 1 || param.type == 5}">
								<button type="button"
									onclick="location.href='javascript:write_submit()'"
									class="button">게시글 작성</button>
							</c:if>
						</div>
					</div>
					<!-- 글쓰기 끝 -->
				</div>
			</div>
		</div>

		<c:if test="${ON != 1}">
	<c:forEach var="board" items="${mylist}">
		<div align="center" onmouseover="this.style.backgroundColor='#dcdcdcad'"
			onmouseout="this.style.backgroundColor=''"
			class="content">
			<div align="left">
														<c:if test="${! empty board.fileurl}">
															<a href="../file/${board.fileurl}">
															<span class="span"><i class="fa fa-file-image-o w3-margin-right"></i>Image</span>
															</a>
														</c:if>
														<c:if test="${empty board.fileurl}">
														<span class="span2"><i class="fa fa-frown-o w3-margin-right"></i>No-Image</span>
														</c:if>
														<h3 class="h3">
															<a style="text-decoration: none;"
																href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">&nbsp;&nbsp;&nbsp;<b>${board.subject}</b>
														<c:if test="${param.type == 1 }">
														<c:if test="${board.duckcnt > 10}">
														<span class="tag_duck"><i class="fa fa-github"></i> Hot!</span></c:if>
														</c:if><!-- 이벤트! -->
														<c:if test="${param.type == 3 }">
														<c:if test="${board.maxperson-1 <=  board.nowperson}">
														<span class="tag4"><i class="fa fa-certificate"></i> 마감임박!</span></c:if>
														</c:if>	<!-- 임의로 이벤트 하나 만든거임 -->
														<c:if test="${board.boardtype==1}">
														<c:if test="${board.recmd >= 11 }">
														<span class="recmd_best"><i class="fa fa-heart"></i> 추천 : ${board.recmd}</span>
														</c:if>
														<c:if test="${board.recmd <= 10 || board.recmd == 0 }">
														<span class="recmd"><i class="fa fa-thumbs-o-up"></i> 추천 : ${board.recmd}</span>
														</c:if>
														</c:if>
														   </a>
														</h3>
													</div>
													<div align="left" class="thumb"><b style="margin:5px 5px 5px 5px;font-weight:bold;color:#000 !important;"><i class="fa fa-low-vision"></i>내용 미리보기</b><br>${board.content }</div>
													<div align="right" class="right">
													<b>등록일자:</b><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd hh:mm"/>&nbsp;&nbsp;<br>
													<b>조회수:</b>${board.readcnt}&nbsp;&nbsp;
													</div>
			                                        <div align="right"class="right"><b>선택기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty tech }">
			                                        <c:forEach var="utech" items="${tech}" varStatus="g" begin="0">
                                                    <span class="tag"><i class="fa fa-search"></i>${utech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty tech }">
                                                    <span class="tag3"><i class="fa fa-search"></i>검색</span>
                                                    </c:if>
			                                        </div><!-- 선택기술 -->
			                                        <div align="right" class="right"><b>사용기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty board.usetech }">
			                                        <c:forEach var="usetech" items="${board.usetech}" varStatus="g" begin="0">
                                                    <span class="tag">${usetech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty board.usetech }">
                                                    <span class="tag2">Empty Tech</span>
                                                    </c:if>
			                                        </div><!-- 사용기술 -->
			</div>
	</c:forEach>
	<div align="center">
											<div align="center" class="page">
											<div>
												<c:if test="${pageNum > 1}">
													<a href="javascript:list(${pageNum -1})"><i class="fa fa-arrow-left w3-large"></i>이전</a>
												</c:if>
												<c:if test="${pageNum <= 1}"><i class="fa fa-arrow-left w3-large"></i>이전</c:if>
												<c:forEach var="a" begin="${startpage}" end="${endpage}">
													<c:if test="${a==pageNum}">[${a}]</c:if>
													<c:if test="${a!=pageNum}">
														<a href="javascript:list(${a})">[${a}]</a>
													</c:if>
												</c:forEach>
												<c:if test="${pageNum < maxpage}">
													<a href="javascript:list(${pageNum +1})">다음<i class="fa fa-arrow-right w3-large"></i></a>
												</c:if>
												<c:if test="${pageNum >= maxpage}">다음<i class="fa fa-arrow-right w3-large"></i></c:if>
											</div>
										</div>
										</div>
</c:if>
<c:if test="${ON == 1}">
	<div align="center" onmouseover="this.style.backgroundColor='#dcdcdcad'"
		onmouseout="this.style.backgroundColor=''"
		style="">
		<div align="center">
			<h1>게시물이 없음</h1>
		</div>
	</div>
</c:if>
									</div>
									
</c:if>