<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/main_slider_js.jsp" %>
<%@ include file="/WEB-INF/view/style/main_slider_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서브홈페이지</title>
</head>
<body>
	<div id="all">
		<div class="hp-container">
			<div id="container" class="clear" style="padding: 0px 26px 0px;">
				<div id="content">
					<div id="gap">
						<!------------------- Mainpage css ------------------------>
						<!-- 여기부터 -->
						<!-- 구분선 'COMMUNITY' -->
						<script
							src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.6/js/swiper.min.js"></script>
						<div class="mline" style="margin-bottom: 20px;">
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
											<div id="widgetPageBox_2018cms" style="overflow: hidden; visibility: visible;">
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
	<!-- 하단 BAR -->
</body>
</html>