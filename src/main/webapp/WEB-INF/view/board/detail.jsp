<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<style>
body,h1,h2,h3,h4,h5,h6,b,textarea {font-family: "Montserrat", sans-serif;}
input[type=text] {
  -webkit-appearance: none;
  -moz-appearance: none;
  margin: 10px 0 10px 0;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-width: 0 0 1px 0;
  border-radius: 0;
  background: rgba(0, 0, 0, 0);
  height: 2.5em;
  font-size:15px;
  font: inherit;
  color: inherit;
  outline: none;
  transition: all 180ms;
  padding: 0;
  text-align:center;
  width:63%;
}
.half {
  float: left;
  width: 46%;
  margin-bottom: 1em;
}

.right {
  width: 52%;
}

.left {
  margin-right: 2%;
}
.div{
text-align:left;
margin:10px 10px 10px 10px;
}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
					//alert(result.msg)
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
	//댓글 답변 입력창
	function comment_submit2(num) {
		var reply = $("#replycontent"+num).val();
		//alert(reply);
		var length = $("#replycontent"+num).val().length;
		//alert(length);
		//alert("댓글번호:"+num);
		var type = ${param.type};
		if (length < 1) {
			alert("답변을 입력하세요");
			return;
		}else{
			//alert($("#replycontent").val());
		}
		location.href="reply.duck?num="+num+"&reply="+reply+"&type="+type
	}
	//답글 폼(?)
	function replyCommentOpen(num){
		$("#reply"+num).html(
				'<table id="replytb" class="table14_10" style="width: 90%"><tr>'
					+'<td>└>답변쓰기</td><td><textarea required="required" rows="2" cols="75"'
					+'name="reply" id="replycontent'+num+'" >'+'</textarea>'
					+'<td><button type="button" onclick="location.href='
					+"'javascript:comment_submit2("+num+")'"
					+' "class="comment">답변등록!!</button><br>'
					+'<button onclick="replycancer('+num+')">답변 취소</button>'
				    +'</td></td></tr></table>'
		)
	}
	function replycancer(num){
		$("#reply"+num).html(
				''
		)
	}
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
</script>

</head>
<body>
<form action="comment.duck?" name="f" method="post">
<input type="hidden" value="${param.type}" name="type">
<input type="hidden" value="${param.num}" name="num">
<div class="w3-container w3-card w3-white w3-margin-bottom"style="max-width:80%;margin: 0 auto;">
<h2 class="w3-text-grey w3-padding-16">
<c:if test="${param.type==1 || boardtype==1}">
<i class="fa fa-github fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
오픈소스게시판</c:if>
<c:if test="${param.type==2 || boardtype==2}">
<i class="fa fa-wechat fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
개발자자유게시판</c:if>
<c:if test="${param.type==3 || boardtype==3}">
<i class="fa fa-black-tie fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
프로젝트공고모집게시판</c:if>
<c:if test="${param.type==5 || boardtype==5}">
<i class="fa fa-jsfiddle fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
나만의소스</c:if>
</h2>
<div align="center">
		
</div>	
<div class="half left">
<div class="div">
<b>글쓴이 : </b>
${board.userid}
</div>
<c:if test="${param.type==1 || param.type==3 || param.type==5 || boardtype==1 || boardtype==3 || boardtype==5}">
<div class="div">
<b>추천수 : </b>
<input class="recview" style="text-align: center;border: 1px solid rgba(0, 0, 0, 0.5);border-width: 0 0 1px 0;" readonly value="추천수 : ${board.recmd}">
</div>
</c:if>
<c:if test="${board.boardtype==3}">
<div class="div">
<b>프로젝트 기간 : ${board.schedule} 일</b>
</div>
<div class="div">
<b>프로젝트 금액 : ${board.price} 원</b>
</div>
<div class="div">
<b>프로젝트 인원수 : ${board.maxperson} 명</b>
</div>
</c:if>
<div class="div">
<b>제목 : ${board.subject}</b>
</div>
<div class="div">
<b>첨부파일 : </b>
<c:if test="${!empty board.fileurl}">
<a href="../file/${board.fileurl}">${board.fileurl}</a>
</c:if>
<c:if test="${empty board.fileurl }">
<b style="color:red;">등록된 이미지가 없습니다</b>
</c:if>
</div>
<div class="div">
<div style="width:550px;height:310px;float:left;border:1px solid #000;" class="1">
<c:if test="${!empty board.fileurl }">
<img src="${path}/file/${board.fileurl}" style="width:100%;height:100%;">
<br>
</c:if>
<c:if test="${empty board.fileurl}">
<img src="../workpic/noimage.png" style="width:100%; height:100%;">
</c:if>
</div>
</div>
</div>
			<%-- 
		<div>
			<div align="center"><b>프로젝트 금액 : </b>
				<form:input path="price" 
				<font color="red"><form:errors path="price" /></font>
			</div>
		</div>
		</c:if> --%>
			<!-- 왼쪽 div 영역 끝나는 지점 -->
<div class="half right">
<div style="text-align:center;">
<b style="text-align:center;">[내용]</b>
</div>
<div style="text-align:left;width:800px;max-width:800px;resize:none;font-size:30px;height:500px;float:right;border:1px solid #000;word-break:break-all;overflow:scroll" class="2">
${fn:replace(board.content, cn, br)}
</div>
		<c:if test="${board.boardtype==3}">
<div style="text-align:center;margin-bottom:20px;">
		<i class="fa fa-star fa-fw w3-xlarge" style="color:#e3e329"></i>
		<button type="button" class="myButton" id="duck">스크랩</button>
		<i class="fa fa-handshake-o fa-fw w3-xlarge"></i>
		<button type="button" class="myButton" id="pro">즉시신청</button>
		<c:if test="${board.userid == loginUser.userid }">
		<a href="../user/supporterlist.duck?boardnum=${board.boardnum}&userid=${board.userid}"><i class="fa fa-users w3-margin-right w3-margin-left">[지원자목록보기]</i></a>
		<a href="selectdevelop.duck?boardnum=${board.boardnum}&userid=${board.userid}"><i class="fa fa-handshake-o w3-margin-right">[선택한개발자목록]</i></a>
		</c:if>
</div>
		</c:if>
</div>

<div style="text-align:center;margin-bottom:20px;">
		<a href="update.duck?num=${board.boardnum}&type=${board.boardtype}"><i class="fa fa-rotate-right w3-margin-right">[게시물수정]</i></a>
		<a href="deleteForm.duck?num=${board.boardnum}&type=${board.boardtype}"><i class="fa fa-trash-o w3-margin-right">[게시물삭제]</i></a>
		<c:if test="${param.type==1 || param.type==3 || param.type==5}">
		<a href="find.duck?type=${param.type}"class="w3-hover" style="color:#000"><i class="fa fa-list w3-margin-right">[게시물목록]</i></a>
		</c:if>
		<c:if test="${board.boardtype!=1 && board.boardtype!=3 && board.boardtype!=5 }">
		<a href="list.duck?type=${board.boardtype}"><i class="fa fa-list w3-margin-right">[게시물목록]</i></a>
		</c:if>
		<c:if test="${board.boardtype==1}">
		<i class="fa fa-thumbs-o-up fa-fw w3-xlarge"></i>
		<button type="button" class="myButton" id="rec">추천</button>
		<i class="fa fa-external-link fa-fw w3-xlarge"></i>
		<button type="button" class="myButton" id="duck">DUCK</button>
		</c:if>
		<c:if test="${board.boardtype==2}">
		<i class="fa fa-thumbs-o-up fa-fw w3-xlarge"></i>
		<button type="button" class="myButton" id="rec">추천</button>
		</c:if>
</div>
</div>
<!-- 아래쪽 하단 버튼 끝 -->
<div class="w3-container w3-card w3-white w3-margin-bottom"style="max-width:80%;margin: 0 auto;">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-comments-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>댓글</h2>
<table class="table14_10" style="width: 100%">
				<jsp:useBean id="day" class="java.util.Date" />
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
									<c:if test="${c.refstep == 0}">
									<div style="width: 100%; height: 100%; margin-left: 10%; padding-right: 20%">
										${fn:replace(c.content, cn, br)}</div>
									</c:if>
									<c:if test="${c.refstep != 0 }">
									<div style="width: 100%; height: 100%; margin-left: 10%; padding-right: 20%">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└>&nbsp;&nbsp;<font style="color:blue">${c.userid}</font> ${fn:replace(c.content, cn, br)}</div>
									</c:if>
								</td>
								<td><c:if test="${c.userid == loginUser.userid}">
										<fmt:formatDate value="${day}" pattern="yy/MM/dd" var="today" />
										<fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" var="rdate" />
										<c:if test="${today == rdate }">
											<fmt:formatDate value="${c.regdate}" pattern="HH:mm:ss" />
										</c:if>
										<c:if test="${today != rdate }">
											<fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" />
										</c:if>
										<br>
										<button type="button" onclick="replyCommentOpen(${c.num})">답변</button>
										<button type="button" onclick="delCommentOpen(${c.num})">삭제</button>
									</c:if> <c:if test="${c.userid != loginUser.userid }">
										<fmt:formatDate value="${day}" pattern="yy/MM/dd" var="today" />
										<fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" var="rdate" />
										<c:if test="${today == rdate }">
											<fmt:formatDate value="${c.regdate}" pattern="HH:mm:ss" />
										</c:if>
										<c:if test="${today != rdate }">
											<fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" />
										</c:if>
										<br>
										<button type="button" onclick="replyCommentOpen(${c.num})">답변</button>
										<c:if test="${loginUser.userid == 'admin'}">
											<button type="button" onclick="delCommentOpen(${c.num})">삭제</button>
										</c:if>
									</c:if></td>
							</tr>
							<tr id="reply${c.num}" align="right"></tr>
						</c:forEach>
					</c:if>
				</table>
<div style="margin:10px 0 10px 0">
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