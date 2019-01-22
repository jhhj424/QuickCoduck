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
</style>
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
<meta charset="UTF-8">
<title>매칭제안성공</title>
</head>
<body>
<div class="table" style="width:70%;margin:0 auto;margin-bottom:50px;">
<h2 class="w3-padding-16" style="font-weight:bold;color:#181a1bd1;">
<i class="fa fa-group fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>매칭 제안 성공!</h2>
<button type="button" onclick="location.href='../board/find.duck?type=${clientboard.boardtype}'" class="button">
<i class="fa fa-reply"style="font-weight:bold;margin-right:10px;"></i>목록으로 돌아가기</button>
</div>
</body>
</html>