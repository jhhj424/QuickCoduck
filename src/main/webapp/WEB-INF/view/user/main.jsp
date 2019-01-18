<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/main_slider_js.jsp" %>
<%@ include file="/WEB-INF/view/style/main_slider_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuickCoduck_Main</title>
</head>
<body>
<div id="all">
		<div class="hp-container"style="border-radius: 10px;box-shadow: 0 0 6px rgba(0, 0, 0, 0.7);max-width:100%">
			<div id="container" class="clear" style="padding: 0px 26px 0px;max-width:100%;border-radius: 10px;box-shadow: 0 0 6px rgba(0, 0, 0, 0.7);">
				<div id="content">
					<div id="gap">
						<script
							src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.6/js/swiper.min.js"></script>
						<div class="mline">
							<span> OPENSOURCE & PROJECT </span>
						</div>
						<div>
							<div class="xe-widget-wrapper " style="">
								<div style="*zoom: 1; padding: 0px 0px 0px 0px !important;">
									<div class="widget_box2">
										<div class="widgetContainer">
											<div id="widgetTabBox_2018cms" class="top_tab">
												<ul>
													<li><a onclick="javascript:widgetPageSlider_2018cms.slide(0, 300);$('.on').removeClass('on');$(this).parent().addClass('on');return false;"
														title="인기 소스" id=opso>인기 소스</a></li>
													<li><a onclick="javascript:widgetPageSlider_2018cms.slide(1, 300);$('.on').removeClass('on');$(this).parent().addClass('on');return false;"
														title="인기 프로젝트">인기 프로젝트</a></li>
												</ul>
											</div>
											<!----- 배너 4개 ------>
											<div id="widgetPageBox_2018cms" style="overflow: hidden; visibility: visible;padding-bottom:50px;">
												<ul style="list-style: none; margin: 0px; width: 100%; transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
												<!-- 오픈소스 슬라이더 -->
													<li id="widgetPage_2018cms_0_0"
														style="width: 100%; display: table-cell; vertical-align: top;">
														<ul class="normal_list">
														
														<c:forEach var="board" items="${boardlist}" end="3">
															<li class="nb" style="width: 25%;"><a target="_self"
																href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}"> <!-- 링크 -->
																	<div class="thumb_bl">
																		<p class="thumbbox">
																			<span class="thumb">
																			<c:if test="${ empty board.fileurl }">
																			 <img 
																				src="../workpic/empty.jpg"class="thumbnail" ><!-- 사진 -->
																			</c:if>
																			<c:if test="${!empty board.fileurl }">
																			 <img 
																				src="../file/${board.fileurl}"class="thumbnail"><!-- 사진 -->
																			</c:if>
																			
																			</span>
																		</p>
																	</div> <span class="title"> ${board.subject}<!-- 제목 -->
																		<span style="margin-left: 5px; color: #EE3366; font-size: 0.8em; font-weight: 300;"></span>
																</span> <span class="browsertitle">
																<!-- 보드타입 -->
																<c:if test="${board.boardtype==1}">OpenSource</c:if></span>
																<span class="regdate">
																<!-- 작성일 -->
																<!-- 오늘올린 게시물이면 HH:mm  //  과거에 올렸던건 yy/MM/dd -->
																<jsp:useBean id ="day" class="java.util.Date"/>
																<fmt:formatDate value="${day}" pattern="yyyyMMdd" var="today"/>
                  												<fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate" />
                  													<c:if test="${today == rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
                  													</c:if>
              														<c:if test="${today != rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="yy/MM/dd"/>
                  													</c:if>
																</span>
															</a></li>
															</c:forEach>
															
														</ul> <!-- contents more --->
													</li>
													<li id="widgetPage_2018cms_1_0"
														style="width: 100%; display: table-cell; vertical-align: top;">
														<ul class="normal_list">
														
														<c:forEach var="board" items="${boardlist2}" end="3">
															<li class="nb" style="width: 25%;"><a target="_self"
																href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}"> <!-- 링크 -->
																	<div class="thumb_bl">
																		<p class="thumbbox">
																			<span class="thumb">
																				<c:if test="${ empty board.fileurl }">
																			 <img 
																				src="../workpic/empty.jpg"class="thumbnail" ><!-- 사진 -->
																			</c:if>
																			<c:if test="${!empty board.fileurl }">
																			 <img 
																				src="../file/${board.fileurl}"class="thumbnail"><!-- 사진 -->
																			</c:if>
																			</span>
																		</p>
																	</div> <span class="title"> ${board.subject}<!-- 제목 -->
																		<span style="margin-left: 5px; color: #EE3366; font-size: 0.8em; font-weight: 300;"></span>
																</span> <span class="browsertitle">
																<!-- 보드타입 -->
																<c:if test="${board.boardtype==3}">Project</c:if></span>
																<span class="regdate">
																<!-- 작성일 -->
																<!-- 오늘올린 게시물이면 HH:mm  //  과거에 올렸던건 yy/MM/dd -->
																<fmt:formatDate value="${day}" pattern="yyyyMMdd" var="today"/>
                  												<fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate" />
                  													<c:if test="${today == rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
                  													</c:if>
              														<c:if test="${today != rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="yy/MM/dd"/>
                  													</c:if>
																</span>
																</span>
															</a></li>
															</c:forEach>
														</ul> <!-- contents more --->
													</li>																											
												</ul>
												
											</div>
											<script type="text/javascript">
												var widgetPageSlider_2018cms = new widgetSwipe(
														document.getElementById('widgetPageBox_2018cms'),{
															auto : 0,
															callback : function(event, tm,p, pid) {
																setTab('2018cms',pid);
															},
												});
											</script>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="padding-top:50px;"></div>
<%-- <h1>메인 페이지 입니다</h1>
<h1><a href="logout.duck">로그아웃</a></h1>
<h1><a href="mypage.duck?id=${sessionScope.loginUser.userid}">mypage</a></h1>
<h1><a href="../board/find.duck?type=1">[게시판테스트중] - 오픈소스,프로젝트공고 게시판Form</a></h1>
<h1><a href="../board/list.duck?type=1">오픈소스게시판</a></h1>
<h1><a href="../board/list.duck?type=2">개발자자유게시판</a></h1>
<h1><a href="../board/list.duck?type=3">프로젝트공고모집게시판</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=1&type=1">덕한거보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=1&type=3">스크랩보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=2&type=3&matching=1">신청프로젝트보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=3&type=3&matching=2">진행중인프로젝트보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&type=3">클라이언트 진행중인프로젝트보기</a></h1> <!-- 정해놓지않았 -->
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=4&type=3">종료프로젝트보기</a></h1>
<h1><a href="submain.duck">서브메인</a></h1>
<h1>테스트 용입니다</h1> --%>
</body>
</html>