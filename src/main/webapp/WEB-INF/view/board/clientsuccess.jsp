<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
<div id="client_main" align="center" style="border: 3px solid">
<h1>프로젝트 모집 공고 게시완료!</h1>
<table border="1" style="border-collapse: collapse; width: 100%">
<thead>
	<tr>
		<th>글쓴이</th>
		<th>제목</th>
		<th>사용기술</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>${board.userid}</td>
		<td>${board.subject}</td>
		<td>${board.usetech}</td>
	</tr>
</tbody>
</table>
<div id="client_select" align="center" style="border: 1px solid">
<input type="button" value="매칭인재보기" onclick="location.href='../user/matchuser.duck'">
<input type="button" value="목록보기" onclick="location.href='../board/find.duck?type=${board.boardtype}'">
</div>
</div >
</body>
</html>