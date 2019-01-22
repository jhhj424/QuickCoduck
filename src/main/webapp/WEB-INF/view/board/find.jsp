<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/WEB-INF/view/jspHeader.jsp"%>
<%@include file="/WEB-INF/view/style/user_main.jsp"%>
<%@include file="/WEB-INF/view/style/board_find_css.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Quick Coduck</title>
<spring:url value="/resources/css/jquery.treemenu.css" var="treecss" />

<link href="${treecss}" rel="stylesheet" type="text/css" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet'
	href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



<style>
html, body, h1, h2, h3, h4, h5, h6 {
	font-family: "Roboto", sans-serif;
}

.w3-bar .w3-button {
	padding: 12px;
	margin: 5px 15px 5px 15px;
}
.search{
  width: 260px;
  height: 30px;
  padding-left: 10px;
  padding-top: 3px;
  padding-bottom: 3px;
  margin: 7px;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
.submit{
  width: 10%;
  line-height:0;
  height:30px;
  font-weight:bold;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
input:focus {
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
input:hover{
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
select{
  width: 12%;
  line-height:0;
  font-align:center;
  height:30px;
  font-weight:bold;
  font-size: 14px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
select:focus {
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
select:hover{
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
</style>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>

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
</head>
<body id="home">

	<div class="w3-top">

		<div class="w3-bar w3-card" id="myNavbar"
			style="background-color: rgba(255, 255, 255, 0.7); height: 50%">
			<!-- 상단 아이콘-->
			<div class="w3-hide-small">
				<a href="../user/main.duck"
					class="w3-left w3-bar-item w3-button w3-wide"> Quick Coduck <img
					src="../workpic/QuickCoduck.jpg" class="w3-circle"
					style="height: 23px; width: 23px" alt="Avatar"></a>
			</div>
			<div class="w3-right w3-hide-small">
				<a href="../board/find.duck?type=1" class="w3-bar-item w3-button"><i
					class="fa fa-info"></i> 이용방법</a>
				<c:if test="${sessionScope.loginUser.type == '1'}">
					<a href="../board/find.duck?type=1" class="w3-bar-item w3-button"><i
						class="fa fa-search"></i> opensource 찾기</a>
				    <a href="../board/find.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 공고 프로젝트 찾기</a>
				</c:if>
				<c:if test="${sessionScope.loginUser.type == '2'}">
					<a href="../board/find.duck?type=3" class="w3-bar-item w3-button"><i
						class="fa fa-search"></i> 프로젝트 찾기</a>
				</c:if>
				<a href="../board/list.duck?type=2" class="w3-bar-item w3-button"><i
					class="fa fa-newspaper-o"></i> 자유게시판</a> <a href="../user/mypage_main.duck?id=${sessionScope.loginUser.userid}" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="../user/loginForm.duck" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i>로그인/회원가입</a>
      </c:if>
      <c:if test="${!empty sessionScope.loginUser}">
      <a href="../user/logout.duck" class="w3-bar-item w3-button"><i class="fa fa-unlock-alt"></i> 로그아웃</a>
      </c:if>
			</div>
			<a href="javascript:void(0)"
				class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium"
				onclick="w3_open()"> <i class="fa fa-bars"></i>
			</a>
		</div>
	</div>
	<div class="w3-opacity">
		<br>
		<div class="w3-clear"style="background-color:#FEFEFE;"></div>
		<header class="w3-center w3-margin-bottom" style="margin-top:60px;background-color:#FEFEFE;">
			<p style="background-color:#FEFEFE;">
				<b>Quick Coduck</b>
			</p>
			<c:if test="${param.type==1}">
				<h1>
					<b>오픈소스 </b>
				</h1>
			</c:if>
			<c:if test="${param.type==3}">
				<h1>
					<b>프로젝트 공고 </b>
				</h1>
			</c:if>
			<c:if test="${param.type==5}">
				<h1>
					<b>나만의 소스</b>
				</h1>
			</c:if>
		</header>
	</div>
	<!-- Page Container -->
	<div class="w3-content w3-margin-top" style="max-width: 1400px;background-color:#FEFEFE;">

		<!-- The Grid -->
		<div class="w3-row-padding" style="margin-bottom: 50px">

			<!-- Left Column -->
			<div class="w3-third"
				style="padding-right: 50px; padding-left: 50px;">

				<div class="w3-white w3-text-grey w3-card-4">
					<div class="w3-container" style="padding-left: 10px;">
						<br>
						<p class="w3-large">
							<b><i
								class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>Skills</b>
						</p>
						<ul class="tree">
							<li><a>Development<input type="checkbox"
									id="checkall_develop"></a>
								<ul>
									<li><a>C<input type="checkbox" name="usetech"
											value="C" class="usetech_develop"></a></li>
									<li><a>C++<input type="checkbox" name="usetech"
											value="C++" class="usetech_develop"></a></li>
									<li><a>Java<input type="checkbox" name="usetech"
											value="Java" class="usetech_develop"></a></li>
									<li><a>JSP<input type="checkbox" name="usetech"
											value="JSP" class="usetech_develop"></a></li>
									<li><a>Python<input type="checkbox" name="usetech"
											value="Python" class="usetech_develop"></a></li>
									<li><a>Ajax<input type="checkbox" name="usetech"
											value="Ajax" class="usetech_develop"></a></li>
									<li><a>jQuery<input type="checkbox" name="usetech"
											value="jQuery" class="usetech_develop"></a></li>
									<li><a>Ruby<input type="checkbox" name="usetech"
											value="Ruby" class="usetech_develop"></a></li>
									<li><a>Android<input type="checkbox" name="usetech"
											value="Android" class="usetech_develop"></a></li>
									<li><a>Unity<input type="checkbox" name="usetech"
											value="Unity" class="usetech_develop"></a></li>
								</ul></li>

							<li><a>Design<input type="checkbox" id="checkall_design"></a>
								<ul>
									<li><a>HTMl<input type="checkbox" name="usetech"
											value="HTMl" class="usetech_design"></a></li>
									<li><a>CSS<input type="checkbox" name="usetech"
											value="CSS" class="usetech_design"></a></li>
									<li><a>BootStrap<input type="checkbox" name="usetech"
											value="BootStrap" class="usetech_design"></a></li>
									<li><a>DreamWeaver<input type="checkbox"
											name="usetech" value="DreamWeaver" class="usetech_design"></a></li>
									<li><a>PhotoShop<input type="checkbox" name="usetech"
											value="PhotoShop" class="usetech_design"></a></li>
									<li><a>XML<input type="checkbox" name="usetech"
											value="XML" class="usetech_design"></a></li>
									<li><a>Sketch<input type="checkbox" name="usetech"
											value="Sketch" class="usetech_design"></a></li>
									<li><a>JavaScript<input type="checkbox" name="usetech"
											value="JavaScript" class="usetech_design"></a></li>
									<li><a>Unity3d<input type="checkbox" name="usetech"
											value="Unity3d" class="usetech_design"></a></li>
									<li><a>iOS<input type="checkbox" name="usetech"
											value="iOS" class="usetech_design"></a></li>
								</ul></li>

						</ul>
					</div>
				</div>
				<br>


				<script>
					$(document).ready(function() {
						$("#checkall_develop").click(function() {
							if ($("#checkall_develop").prop("checked")) {
								$(".usetech_develop").prop("checked", true);
							} else {
								$(".usetech_develop").prop("checked", false);
							}
						});
						$("#checkall_design").click(function() {
							if ($("#checkall_design").prop("checked")) {
								$(".usetech_design").prop("checked", true);
							} else {
								$(".usetech_design").prop("checked", false);
							}
						});
					})
					$(document).ready(
							function() {
								var chk = ""
								var data = ""
								var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
								var pageNum = $("input[name=pageNum]").val(); //pageNum값
								var type = ${param.type}
								var searchType = $("select[name=pageNum]").val();
								var searchContent = $("input[name=searchContent]").val();
								; //게시판type
								$(".tree").click(
										function() {
											// 이미 체크박스 선택한 상태에서 체크박스 다시 선택시에 데이터 초기화하고 현재선택되있는값들로 변경
											$("input[name=usetech]:checked")
													.each(function() {
																chk += $(this).val()+ ",";});
											data = {
												"chk" : chk,
												"pageNum" : pageNum,
												"type" : type,
												"searchType" : searchType,
												"searchContent" : searchContent
											}
											chk = ""
											$.ajax({
												url : "ajax_content.duck",
												type : "post",
												data : data,
												dataType : "html", // ajax 통신으로 받는 타입
												success : function(data) {
													$("#ajax_content").html(data);
												},
												error : function(xhr, status,
														error) { //서버응답 실패
													alert("서버오류 : "
															+ xhr.status
															+ ", error : "
															+ error
															+ ", status : "
															+ status);
												}
											})
										});
							})
				</script>
				<script type="text/javascript">
					function list(pageNum) {
						var type = ${param.type};
						if (type == null || type.length == 0) {
							document.searchform.searchContent.value = "";
							document.searchform.pageNum.value = "1";
							location.href = "find.duck?pageNum=" + pageNum
									+ "&type=${param.type}";
						} else {
							document.searchform.pageNum.value = pageNum;
							document.searchform.submit();
							return true;
						}
						return false;
					}
					
					function find(pageNum) {
						var chk = ""
							var data = ""
							var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
							var type = ${param.type}; //게시판type
										// 이미 체크박스 선택한 상태에서 체크박스 다시 선택시에 데이터 초기화하고 현재선택되있는값들로 변경
										$("input[name=usetech]:checked")
												.each(function() {
															chk += $(this).val()+ ",";});
										data = {
											"chk" : chk,
											"pageNum" : pageNum,
											"type" : type
										}
										chk = ""
										$.ajax({
											url : "ajax_content.duck",
											type : "post",
											data : data,
											dataType : "html", // ajax 통신으로 받는 타입
											success : function(data) {
												$("#ajax_content").html(data);
											},
											error : function(xhr, status,
													error) { //서버응답 실패
												alert("서버오류 : "
														+ xhr.status
														+ ", error : "
														+ error
														+ ", status : "
														+ status);
											}
										});
					}
				</script>

				<!-- End Left Column -->
			</div>

			<!-- Right Column -->
			<div class="w3-twothird">

				<div class="w3-container w3-card w3-white w3-margin-bottom">
					<c:if test="${param.type==1}">
						<h2 class="w3-text-grey w3-padding-16">
							<i
								class="fa fa-github fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>오픈소스
						</h2>
					</c:if>
					<c:if test="${param.type==3}">
						<h2 class="w3-text-grey w3-padding-16">
							<i
								class="fa fa-black-tie fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>프로젝트
							공고
						</h2>
					</c:if>
					<c:if test="${param.type==5}">
						<h2 class="w3-text-grey w3-padding-16">
							<i
								class="fa fa-jsfiddle fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>나만의 소스
						</h2>
					</c:if>
					<!-- <div class="w3-container">
          <h5 class="w3-opacity"><b>Front End Developer / w3schools.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jan 2015 - <span class="w3-tag w3-teal w3-round">Current</span></h6>
          <p>Lorem ipsum dolor sit amet. Praesentium magnam consectetur vel in deserunt aspernatur est reprehenderit sunt hic. Nulla tempora soluta ea et odio, unde doloremque repellendus iure, iste.</p>
          <hr>
        </div> -->
					<div class="w3-container" style="padding-bottom:77px;">
						<div class="w3-ul w3-card-4">
							<div id="ajax_content">
								<div class="div" style="width: 100%">
									<div>
										<div align="center">
											<div align="center"
												onmouseover="this.style.backgroundColor=''"
												onmouseout="this.style.backgroundColor=''"
												>
													<div align="right" class="listcount_div">
														<c:if test="${type != 5}">														
														<b class="listcount_b">
														<i class="fa fa-asterisk w3-text-teal"></i>
														글개수: ${listcount}</b>
														</c:if>
														<c:if test="${type == 5}">														
														<b class="listcount_b">
														<i class="fa fa-cloud-upload w3-text-teal"></i>
														나만의소스개수: ${mycount}</b>
														</c:if>
													</div>
												<div align="center" style="margin-top: 5px;">
													<form action="find.duck?type=${param.type}" method="post"
														name="searchform" onsubmit="return list(1)">
														<input type="hidden" name="pageNum" value="1"> <select
															name="searchType" id="searchType">
															<option value="">선택하세요</option>
															<option value="subject">제목</option>
															<option value="userid">글쓴이</option>
															<option value="content">내용</option>
														</select>&nbsp;
														<script type="text/javascript">
															if ('${param.searchType}' != '') {
																document
																		.getElementById("searchType").value = '${param.searchType}';
															}
														</script>
														<input type="text" name="searchContent"
															value="${param.searchContent}" class="search"
															placeholder="내용을 입력해주세요"> <input type="submit"
															value="검색" class="submit">
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
									<c:if test="${listcount > 0}">
										<%-- 게시물이 있는경우 --%>
										<div id="ajax_content1">
											<c:forEach var="board" items="${boardlist}">
												<div align="center"
													onmouseover="this.style.backgroundColor='#dcdcdcad'"
													onmouseout="this.style.backgroundColor=''"
													class="content">
													<%-- <div height="23">${boardcnt}</div> --%>
													<c:set var="boardcnt" value="${boardcnt - 1}" />
													<div align="left">
														<c:if test="${! empty board.fileurl}">
															<a href="../file/${board.fileurl}">
															<span class="span"><i class="fa fa-file-image-o w3-margin-right"></i>Image</span>
															</a>
														</c:if>
														<c:if test="${empty board.fileurl}">
														<span class="span2"><i class="fa fa-frown-o w3-margin-right"></i>No-Image</span>
														</c:if>
														<c:if test="${param.type == 1 }">
														<c:if test="${board.duckcnt > 10}">
														<span class="tag_duck"><i class="fa fa-github"></i> Hot!</span></c:if>
														</c:if><!-- 이벤트! -->
														<c:if test="${param.type == 3 }">
														<c:if test="${board.maxperson-1 <=  board.nowperson}">
														<span class="tag4"><i class="fa fa-certificate"></i> 마감임박!</span></c:if>
														<c:if test="${board.nowperson == 0}">
														<span class="tag_new"><sup>New</sup> 신규등록!</span></c:if>
														</c:if>	<!-- 임의로 이벤트 하나 만든거임 -->
														<c:if test="${board.boardtype==1}">
														<c:if test="${board.recmd >= 11 }">
														<span class="recmd_best"><i class="fa fa-heart"></i> 추천 : ${board.recmd}</span>
														</c:if>
														<c:if test="${board.recmd <= 10 || board.recmd == 0 }">
														<span class="recmd"><i class="fa fa-thumbs-o-up"></i> 추천 : ${board.recmd}</span>
														</c:if>
														</c:if>
														<h3 class="h3">
															<a style="text-decoration: none;"
																href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">&nbsp;&nbsp;&nbsp;<b>${board.subject}</b>
														   </a>
														</h3>
													</div>
													<div align="left" class="thumb"><b style="margin:5px 5px 5px 5px;font-weight:bold;color:#000 !important;"><i class="fa fa-low-vision"></i>내용 미리보기</b><br><c:out value="${board.content}" escapeXml="true"/></div>
													<div align="right" class="right">
													<b>등록일자:</b><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd hh:mm"/>&nbsp;&nbsp;<br>
													<b>조회수:</b>&nbsp;&nbsp;<sup class="readcnt">${board.readcnt}</sup> &nbsp;&nbsp;
													</div>
			                                        <div align="right"class="right"><b>선택기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty tech }">
			                                        <c:forEach var="utech" items="${tech}" varStatus="g" begin="0">
                                                    <span class="tag_check"><i class="fa fa-search"></i>${utech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty tech }">
                                                    <span class="tag3"><i class="fa fa-search"></i>검색</span>
                                                    </c:if>
			                                        </div><!-- 선택기술 -->
			                                        <div align="right" class="right"><b>요구기술:</b>&nbsp;&nbsp;
			                                        <c:if test="${!empty board.usetech }">
			                                        <c:forEach var="usetech" items="${board.usetech}" varStatus="g" begin="0">
                                                    <span class="tag">${usetech}</span>
                                                    <c:out value="${g.end}" />
                                                    </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty board.usetech }">
                                                    <span class="tag2">Empty Tech</span>
                                                    </c:if>
			                                        </div><!-- 요구기술 -->
												</div>
											</c:forEach>
										</div>
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
									</c:if>
									<c:if test="${listcount == 0}">
										<div class="div">
											<div style="text-align:center;"><b>등록된 게시물이 없습니다.</b></div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- End Right Column -->
			</div>

			<!-- End Grid -->
		</div>

		<!-- End Page Container -->
	</div>

<footer class="w3-center w3-padding-32" style="background-color:#4d636f;color:#fff;">
  <div class="w3-xlarge w3-section">
<i class="fa fa-github"></i>
<i class="fa fa-git-square"></i>
<i class="fa fa-github-alt"></i>
<i class="fa fa-windows"></i>
<i class="fa fa-codepen"></i>
<i class="fa fa-chrome"></i>
<i class="fa fa-internet-explorer"></i>
<i class="fa fa-html5"></i>
<i class="fa fa-linux"></i>
<i class="fa fa-firefox"></i>
<i class="fa fa-dropbox"></i>
<i class="fa fa-mixcloud"></i>
<i class="fa fa-share-alt-square"></i>

  </div>
  <p>Quick Coduck<a href="#home"class="w3-hover">&nbsp;&nbsp;&nbsp;<i class="fa fa-arrow-up w3-margin-right"> Up to top</i></a></p>
</footer>
</body>
</html>
