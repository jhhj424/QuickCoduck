<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#rec").click(
						function() {
							var num = ${board.boardnum}
							var type = ${board.boardtype}
							var userid = "${loginUser.userid}"
							var data = {
								"num" : num,
								"type" : type,
								"userid" : userid
								}
							$.ajax({
								url : "recmd.duck",
								type : "post",
								data : data,
								dataType : "json", // ajax 통신으로 받는 타입
								success : function(data) {
									alert(data.msg);
									$(".recview").val("추천수 : " + data.recmd);
								},
								error : function(xhr, status, error) { //서버응답 실패
									alert("서버오류 : " + xhr.status + ", error : "
											+ error + ", status : " + status);
								}
							})
						});
				
				$("#duck").click(
						function() {
							var num = ${board.boardnum}
							var type = ${board.boardtype}
							var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
							var data = {
								"num" : num,
								"type" : type,
								"ducktype" : 1,
								"userid" : userid
							}
							$.ajax({
								url : "duck.duck",
								type : "post",
								data : data,
								dataType : "json", // ajax 통신으로 받는 타입
								success : function(data) {
									alert(data.msg);
								},
								error : function(xhr, status, error) { //서버응답 실패
									alert("서버오류 : " + xhr.status + ", error : "
											+ error + ", status : " + status);
								}
							})
						});
			
			$("#pro").click(
						function() {
							var num = ${board.boardnum}
							var type = ${board.boardtype}
							var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
							var data = {
								"num" : num,
								"type" : type,
								"ducktype" : 2,
								"userid" : userid
							}
							$.ajax({
								url : "pro.duck",
								type : "post",
								data : data,
								dataType : "json", // ajax 통신으로 받는 타입
								success : function(data) {
									alert(data.msg);
								},
								error : function(xhr, status, error) { //서버응답 실패
									alert("서버오류 : " + xhr.status + ", error : "
											+ error + ", status : " + status);
								}
							})
						});
			});
</script>

</head>
<body class="b1 ">
	<div class="w3-container">
		<div class="w3-ul w3-card-4">
			<table class="table14_10" style="width: 100%">
				<tr>
					<td>
					<c:if test="${board.boardtype==1}">오픈소스게시판</c:if>
					<c:if test="${board.boardtype==2}">개발자자유게시판</c:if>
					<c:if test="${board.boardtype==3}">프로젝트공고모집게시판</c:if>
					</td>
					<td align="center"><input class="recview"
						style="text-align: center;" readonly value="추천수 : ${board.recmd}"></td>
				</tr>
				<tr>
					<td width="15%">글쓴이</td>
					<td width="85%">${board.userid}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${board.subject}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<table width="100%" height="250">
							<tr>
								<td>${fn:replace(board.content, cn, br)}</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td>&nbsp; <c:if test="${!empty board.fileurl}">테스트
							<a href="../file/${board.fileurl}">${board.fileurl}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><a
						href="update.duck?num=${board.boardnum}&type=${board.boardtype}">[수정]</a>
						<a
						href="deleteForm.duck?num=${board.boardnum}&type=${board.boardtype}">[삭제]</a>
						<a href="list.duck?type=${board.boardtype}">[목록!!!]</a>
						<c:if test="${board.boardtype==1}">
						<button type="button" class="myButton" id="rec">추천</button>
						<button type="button" class="myButton" id="duck">DUCK</button>
						</c:if>
						<c:if test="${board.boardtype==3}">
						<button type="button" class="myButton" id="duck">스크랩</button>
						<button type="button" class="myButton" id="pro">참여신청</button>
						<a href="../user/supporterlist.duck?boardnum=${board.boardnum}">[지원자목록보기]</a>
						</c:if>
						</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>