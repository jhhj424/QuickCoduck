<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>완료한 프로젝트</title>
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
function evaluation(boardnum){
	var data = {
			"boardnum" : boardnum
	}
	$.ajax({
		url : "completeuserlist.duck",
		type : "post",
		data : data,
		dataType : "html", // ajax 통신으로 받는 타입
		success : function(data) {
			$('#my-userlist').html(data);
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
	$("#my-dialog,#dialog-background").toggle();
}
$(function(){
	$("#dialog-background,#btn-close-dialog").click(function () {
		$("#my-dialog,#dialog-background").toggle();
	});
});
</script>

<script type="text/javascript">
/* 
var msg = confirm("해당 유저의 평가를 진행하시겠습니까?");
if (msg) { //삭제
	 $.ajax({
		url : "userevaluation.duck",
		type : "post",
		data : {"boardnum" : boardnum, "userid" : userid},
		dataType : "json",
		success : function(result) {
			alert(result.msg);
			if(result.ok == "ok") {
			location.href = "mypage_project_finished.duck?id="+userid+"&boardnum="+boardnum;					
			}else{
				return false;
			}
		},
		error : function(xhr, status, error) {
			alert("서버오류:"+xhr.status+",error:"+error+",status:"+status);
		} 
	})
} else { //삭제 취소
	//alert("취소")
	return false;
} */
</script>
</head>
<body>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-check-square-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>완료한 프로젝트
</h2>
<table border="1" style="width:100%;" class="table">
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
			<input type="text" name="searchContent" value="${param.searchContent}" class="search" placeholder="내용을 입력해주세요">
		    <input type="submit" value="검색"class="submit">
		</form>
	</td>
</tr>
<tr align="center" valign="middle" bordercolor="#212121">
	<th width="6%" class="th" style="font-weight:bold;">번호</th>
	<th width="10%" class="th" style="font-weight:bold;">글쓴이</th>
	<th width="40%" class="th" style="font-weight:bold;">제목</th>
	<th width="10%" class="th" style="font-weight:bold;">조회수</th>
	<th width="15%" class="th" style="font-weight:bold;">평가하기</th>
	
</tr>

<c:forEach var="board" items="${completelist}">
	<tr align="center"
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
	<c:set var="boardcnt" value="${boardcnt-1}" />
		<td class="th"> ${boardcnt+1} </td> <%--duck개시물번호 --%>
		<td align="left" class="th">${board.userid}</td>
		<td align="left" class="th">
			<a href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}">${board.subject}</a>
		</td>
		<td align="right" class="th">${board.readcnt}</td>
		<td align="center" class="th">		
			<button id="btn-open-dialog" onclick="evaluation(${board.boardnum})" class="button">평가하기</button>
		</td>
	</tr>
</c:forEach>
<tr align="center" class="page">
	<td colspan="7"><c:if test="${pageNum > 1}">
		<a href="javascript:list(${pageNum -1})"><i class="fa fa-arrow-left w3-large"></i>이전</a>
	</c:if> <c:if test="${pageNum <= 1}"><i class="fa fa-arrow-left w3-large"></i>이전</c:if>
	<c:forEach var="a" begin="${startpage}" end="${endpage}">
		<c:if test="${a==pageNum}">[${a}]</c:if>
		<c:if test="${a!=pageNum}">
			<a href="javascript:list(${a})">[${a}]</a>
		</c:if>
	</c:forEach> <c:if test="${pageNum < maxpage}">
		<a href="javascript:list(${pageNum +1})">다음<i class="fa fa-arrow-right w3-large"></i></a>
	</c:if> <c:if test="${pageNum >= maxpage}">다음<i class="fa fa-arrow-right w3-large"></i></c:if></td>
</tr>
</table>
<div id="my-dialog" style="width: 20%; height: 8%; background-color:rgba(0, 0, 0, 0);">
	
<div align="center" class="table">
<h2 class="w3-padding-16" style="font-weight:bold;color:#252c30;">
<i class="fa fa-group fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>참여한 개발자 목록
</h2>
</div>
<div id="my-userlist"> 
<!-- ajax으로 유저리스트 받아오면됨 -->
</div>
</div>
<div id="dialog-background" >

</div>
<p></p>
</div>
</body>
</html>