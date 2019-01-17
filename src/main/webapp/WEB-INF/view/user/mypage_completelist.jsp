<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>완료한 프로젝트</title>

<script type="text/javascript">

$(document).ready(function(){
	$('#btn-open-dialog').click(){
		alert("클릭됨");
	}
})

function complete(boardnum){
	alert("보드넘:"+boardnum)
	var msg = confirm("해당 프로젝트를 완료하시겠습니까?");
	if (msg) { //삭제
		$.ajax({
			url : "../board/complete.duck",
			type : "post",
			data : {"userid" : userid,	"boardnum" : boardnum,	"ducktype" : ducktype},
			dataType : "json",
			success : function(result) {
				//alert(result.msg)
				if (result.msg == "OK") {
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
<script type="text/javascript">
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "mypage_completelist.duck?pageNum=" + pageNum;
		} else {
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>

<style>
#dialog-background {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,.3);
    z-index: 10;
}
#my-dialog {
    display: none;
    position: fixed;
    left: calc( 50% - 160px ); top: calc( 50% - 70px );
    width: 320px; height: 140px; 
    background: #fff;
    z-index: 11;
    padding: 10px;
}
</style>
<script src='//code.jquery.com/jquery.min.js'></script>
<script>
$(function(){
	$("#btn-open-dialog,#dialog-background,#btn-close-dialog").click(function () {
		$("#my-dialog,#dialog-background").toggle();
	});
});
</script>

</head>
<body>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-vcard-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>완료한 프로젝트
</h2>
<table border="1" style="width:100%;">
<tr>
	<td colspan="7" align="center">
		<form action="mypage_completelist.duck" method="post"
			name="searchform" onsubmit="return list(1)">
			<input type="hidden" name="pageNum" value="1"> 
			<select name="searchType" id="searchType">
				<option value="">선택하세요</option>
				<option value="subject">제목</option>
				<option value="userid">글쓴이</option>
				<option value="content">내용</option>
			</select>&nbsp;
			<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}';
				}
			</script>
			<input type="text" name="searchContent"
				value="${param.searchContent}"> <input type="submit"
				value="검색">
		</form>
	</td>
</tr>
<tr align="center" valign="middle" bordercolor="#212121">
	<th width="6%" height="26">번호</th>
	<th width="10%" height="26">글쓴이</th>
	<th width="45%" height="26">제목</th>
	<th width="10%" height="26">조회수</th>
	<th width="10%" height="26">평가하기</th>
	
</tr>

<c:forEach var="board" items="${completelist}">
	<tr align="center" valign="middle" bordercolor="#333333"
		onmouseover="this.style.backgroundColor='#5CD1E5'"
		onmouseout="this.style.backgroundColor=''">
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td height="23"> ${boardcnt+1} </td> <%--duck개시물번호 --%>
		<td align="left">${board.userid}</td>
		<td align="left">
			<a href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="right">${board.readcnt}</td>
		<td align="center">		
			<button id="btn-open-dialog">선택하기</button>
		</td>
	</tr>
</c:forEach>
<tr align="center" height="26">
	<td colspan="7"><c:if test="${pageNum > 1}">
		<a href="javascript:list(${pageNum -1})">[이전]</a>
	</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if>
	<c:forEach var="a" begin="${startpage}" end="${endpage}">
		<c:if test="${a==pageNum}">[${a}]</c:if>
		<c:if test="${a!=pageNum}">
			<a href="javascript:list(${a})">[${a}]</a>
		</c:if>
	</c:forEach> <c:if test="${pageNum < maxpage}">
		<a href="javascript:list(${pageNum +1})">[다음]</a>
	</c:if> <c:if test="${pageNum >= maxpage}">[다음]</c:if></td>
</tr>
</table>
<div id="my-dialog">
		<!-- 여기에 리스트를 받아오면 됩니다! -->
		<div> <!-- ajax으로 유저리스트 받아오면됨 -->
			
		</div>
    <button id="btn-close-dialog">창 닫기</button>
</div>
<div id="dialog-background">
</div>
<p></p>
</div>
</body>
</html>