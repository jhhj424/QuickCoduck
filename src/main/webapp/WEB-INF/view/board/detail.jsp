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
	/* function comment_submit() {
		if (document.f.comment.value == '') {
			alert("댓글을 입력하세요");
			document.f.comment.focus();
			return;
		}
		document.f.submit();
	}

	$(document).ready(
			function() {
				$("#rec").click(
						function() {
							var data = "num=" + $("#num").val();
							$.ajax({
								url : "recmd.jsp",
								type : "post",
								data : data,
								success : function(data) {
									alert("추천이 완료되었습니다!");
									$(".recview").val("추천수 : " + data);
								},
								error : function(xhr, status, error) { //서버응답 실패
									alert("서버오류 : " + xhr.status + ", error : "
											+ error + ", status : " + status);
								}
							})
						})
			}) */
</script>
<style type="text/css">
body {
	font-family: "Comic Sans MS", Georgia, fantasy;
}

h1, h2, h3, h4, h5, h6 {
	font-family: "Playfair Display";
	letter-spacing: 5px;
	font-weight: bold;
	color: dodgerblue;
}
html, body.b1 {
	font-family: Verdana, sans-serif;
	font-size: 11px;
	line-height: 1.5;
}

.table14_11 table {
	width: 100%;
	margin: 15px 0;
	border: 0;
}

.table14_11 th {
	font-weight: bold;
	background-color: #cde6fe;
	color: #2052fe;
	font-size: large;
}

.table14_10, .table14_10 th, .table14_10 td {
	font-size: 0.99em;
	text-align: center;
	padding: 4px;
	border-collapse: collapse;
	font-style: normal;
}

.table14_10 th, .table14_10 td {
	border: 1px solid #ffffff;
	border-width: 1px
}

.table14_10 th {
	border: 1px solid #cde6fe;
	border-width: 1px 0 1px 0
}

.table14_10 tr {
	border: 1px solid #ffffff;
}

.table14_10 tr:nth-child(odd) {
	background-color: #f7f7f7;
}

.table14_10 tr:nth-child(even) {
	background-color: #ffffff;
}

.table14_10 td {
	border: 1px solid #eeeeee;
	border-width: 2px 2px 2px 2px;
}
</style>
</head>
<body class="b1 ">
	<div class="w3-container">
		<div class="w3-ul w3-card-4">
			<table class="table14_10" style="width: 100%">
				<tr>
					<td colspan="2">Spring 게시판</td>
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
					<td>&nbsp; <c:if test="${!empty board.fileurl}">
							<a href="../file/${board.fileurl}">${board.fileurl}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><a
						href="update.duck?num=${board.boardnum}&type=${board.boardtype}">[수정]</a>
						<a
						href="deleteForm.duck?num=${board.boardnum}&type=${board.boardtype}">[삭제]</a>
						<a href="list.duck?type=${board.boardtype}">[목록]</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>