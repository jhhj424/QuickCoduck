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
						})
			})
	//댓글 입력창
	function comment_submit() {
		if (document.f.content.value == '') {
			alert("댓글을 입력하세요");
			document.f.content.focus();
			return;
		}
		document.f.submit();
	}
	//댓글 삭제창
	function delCommentOpen(num) {
		var boardnum = ${param.num} ;
		var msg = confirm("댓글을 삭제 하시겠습니까??");
		if (msg) { //삭제
			$.ajax({
				url : "delcomment.duck",
				type : "post",
				data : {"boardnum" : boardnum,	"num" : num},
				dataType : "json",
				success : function(result) {
					alert(result.msg)
					if (result.msg == "OK") {
						$('#comment.content').remove();
						alert("삭제되었습니다.");
						location.reload();
					} else {
						alert("삭제에 실패하였습니다.");
					}
				},
				error : function(xhr, status, error) {
					alert("서버오류:"+xhr.status+",error:"+error+",status:"+status);
				}
			})
		} else { //삭제 취소
			//alert("취소")
			return false;
		}
	}
</script>

</head>
<body class="b1 ">
	<form action="comment.duck?" name="f" method="post">
		<input type="hidden" value="${param.type}" name="type"> <input
			type="hidden" value="${param.num}" name="num">
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
						<c:if test="${board.boardtype==1 || board.boardtype==3 || board.boardtype==5 }">
						<a href="find.duck?type=${board.boardtype}">[목록]</a>
						</c:if>
						<c:if test="${board.boardtype!=1 && board.boardtype!=3 && board.boardtype!=5 }">
						<a href="list.duck?type=${board.boardtype}">[목록]</a>
						</c:if>
						<c:if test="${board.boardtype==1}">
						<button type="button" class="myButton" id="rec">추천</button>
						<button type="button" class="myButton" id="duck">DUCK</button>
						</c:if>
						<c:if test="${board.boardtype==2}">
						<button type="button" class="myButton" id="rec">추천</button>
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
		<div class="w3-container">
			<div class="w3-ul w3-card-4">
				<table class="table14_10" style="width: 100%">
					<c:if test="${commentCount==0 }">
						<tr>
							<td colspan="5" align="center">등록된 댓글이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${commentCount > 0}">
						<tr>
							<td colspan="3" style="text-align: center;">달린댓글
								:${commentCount}</td>
						</tr>
						<c:forEach items="${comment}" var="c">
							<tr>
								<td>${c.userid}님</td>
								<td style="min-width: 600px; text-align: left; max-width: 600px">
										${fn:replace(c.content, cn, br)}
								</td>
								<td><c:if test="${c.userid == loginUser.userid}">
										<button type="button" onclick="delCommentOpen(${c.num})">삭제</button>
									</c:if> <c:if test="${c.userid != loginUser.userid }">
										<!--  --><fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd HH:mm:ss" />  -->
									</c:if></td>
							</tr>
						</c:forEach>
						<%-- 페이지 부분 출력하기 --%>
						<tr align="center">
							<td colspan="3"><c:if test="${pageNum<=1}">
									<button type="button" class="comment">이전</button>
								</c:if> <c:if test="${pageNum>1}">
									<button type="button"
										onclick="location.href='detail.duck?pageNum=${pageNum-1}&num=${board.boardnum}&type=${board.boardtype}&id=${loginUser.userid}'"
										class="comment">이전</button>
								</c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
									<c:if test="${a==pageNum }">
										<button type="button" class="comment">${a}</button>
									</c:if>
									<c:if test="${a!=pageNum }">
										<button type="button"
											onclick="location.href='detail.duck?pageNum=${a}&num=${board.boardnum}&type=${board.boardtype}&id=${loginUser.userid}'"
											class="comment">${a}</button>
									</c:if>
								</c:forEach> <c:if test="${pageNum>=maxpage}">
									<button type="button" class="comment">다음</button>
								</c:if> <c:if test="${pageNum < maxpage}">
									<button type="button" class="comment"
										onclick="location.href='detail.duck?pageNum=${pageNum+1}&num=${board.boardnum}&type=${board.boardtype}&id=${loginUser.userid}'">다음</button>
								</c:if></td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
		<br>
		<div class="w3-container">
			<div class="w3-ul w3-card-4">
				<table class="table14_10" style="width: 100%">
					<tr>
						<td>댓글쓰기</td>
						<td><textarea required="required" rows="2" cols="75"
								name="content"></textarea></td>
						<td>
							<button type="button"
								onclick="location.href='javascript:comment_submit()' "
								class="comment">댓글등록!!</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
</body>
</html>