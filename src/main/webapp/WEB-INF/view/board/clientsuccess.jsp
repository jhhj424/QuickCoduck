<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
.button {
	background: #4c6979a3;
	border-radius: 5px;
	margin-bottom: 20px;
	margin-top:20px;
	line-height:1;
	color: #fff;
	border: none;
	position: relative;
	height: 60px;
	font-size: 1.8em;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 99%;
}

.button:hover {
	background: #fff;
	color: #4c6979a3;
	border-radius: 5px;
}

.button:before, .button:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #4c6979a3;
	transition: 400ms ease all;
}

.button:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.button:hover:before, .button:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.tag {
	background: #009688;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}
</style>
<meta charset="UTF-8">
<script type="text/javascript">
 // 뒤로가기 방지
window.history.forward(1);
// 우클릭방지
oncontextmenu='return false' 
 // 드래그 방지
 ondragstart='return false'
// 선택복사 방지
onselectstart='return false'
//새로고침, 뒤로가기 막기
document.onkeydown = function(e) {
 key = (e) ? e.keyCode : event.keyCode;
 if(key==8 || key==116) {
  if(e) {
   e.preventDefault();
  } else {
   event.keyCode = 0;
   event.returnValue = false;
  }
 }
}
//오른쪽마우스 막기
document.oncontextmenu = function(e){
	alert("우클릭 불가능")
 if(e){
  e.preventDefault();
 }
 else{
  event.keyCode = 0;
  event.returnValue = false;
 }
}
</script>
<title>클라이언트 글쓰기 완료</title>
</head>
<body>
<div id="client_main" align="center" class="table" style="width:70%;margin:0 auto;margin-bottom:50px;">
<h2 class="w3-padding-16" style="font-weight:bold;color:#181a1bd1;">
<i class="fa fa-check fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>프로젝트 모집 공고 게시완료!
</h2>
<table border="1" style="border-collapse: collapse; width: 99%" class="table">
<thead>
	<tr>
		<th class="th" style="font-weight:bold;">글쓴이</th>
		<th class="th" style="font-weight:bold;">제목</th>
		<th class="th" style="font-weight:bold;">사용기술</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td class="th" style="text-align:center;">${board.userid}</td>
		<td class="th" style="text-align:center;font-weight:bold;">${board.subject}</td>
		<td class="th">
		<c:forEach var="utech" items="${board.usetech}" varStatus="g" begin="0">
        <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
        <c:out value="${g.end}" />
        </c:forEach>
		</td>
	</tr>
</tbody>
</table>
<div id="client_select" align="center"  style="margin-top:20px;">
<input type="button" value="매칭인재보기" onclick="location.href='../user/matchuser.duck'" class="button">
<input type="button" value="목록보기" onclick="location.href='../board/find.duck?type=${board.boardtype}'" class="button">
</div>
</div >
</body>
</html>