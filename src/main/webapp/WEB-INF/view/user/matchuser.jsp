<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
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
<title>매칭유저 보기</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<script type="text/javascript">
$(document).ready(function(){
	$('#suggest').click(function(event){
	    if ($("input:checkbox[name='idchk']").is(":checked") == false){
	    	alert("유저 체크 안됨")
	    	return event.preventDefault();
	    }else {
	    	return event;
	    }
	});  
})

</script>
</head>
<body>

<form action="../board/match_suggest.duck" method="post" name="f" style="width:70%;margin:0 auto;margin-bottom:50px;">
<input type="hidden" name="boardnum" value="${clientboard.boardnum}">
<table border="1" style="border-collapse: collapse; width: 100%" class="table">
			<tr>
				<td colspan="7" class="th" style="text-align:center;">
				<h2 class="w3-padding-16" style="font-weight:bold;color:#181a1bd1;">
				<i class="fa fa-group fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>매칭유저 보기</h2>
				</td>
			</tr>
			<tr>
				<td class="th" style="font-weight:bold;">사진</td>
				<td class="th" style="font-weight:bold;">아이디</td>
				<td class="th" style="font-weight:bold;">이메일</td>
				<td class="th" style="font-weight:bold;">전화번호</td>
				<td class="th" style="font-weight:bold;">보유기술</td>
				<td class="th" style="font-weight:bold;">선택</td>
			</tr>
			<c:if test="${ON != 1}">
			<c:forEach items="${userlist}" var="user">
				<tr style="height: 60px;" class="th" style="font-weight:bold;">
					<td class="th" style="text-align:center;">
						<a href="../file/${user.fileurl}">
							<img src="../file/${user.fileurl}" class="w3-circle" style="height:50px;width:50px" alt="사진없음">
						</a>
					</td>
					<td class="th" style="font-weight:bold;text-align:center;">${user.userid}</td>
					<td class="th" style="font-weight:bold;text-align:left;">${user.email}</td>
					<td class="th" style="font-weight:bold;text-align:left;">${user.tel}</td>
					<td class="th">
					<c:forEach var="utech" items="${user.usetech}" varStatus="g" begin="0">
                    <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
                    <c:out value="${g.end}" />
                    </c:forEach></td>
					<td class="th" style="font-weight:bold;">
						<input type="checkbox" value="${user.userid}" name="idchk">&nbsp;선택하기
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${ON == 1}">
			<h2 class="w3-padding-16" style="font-weight:bold;color:#181a1bd1;">
			<i class="fa fa-remove fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>조건을 만족하는 개발자가 없음</h2>
			</c:if>
			<tr>
			<td colspan="6" align="right" class="th" style="font-weight:bold;text-align:center;">
				<a href="javascript:document.f.submit()" id="suggest" style="margin-right:20px;"><i class="fa fa-handshake-o"style="font-weight:bold;">매칭 제안하기</i></a>
				<a href="../board/find.duck?type=${clientboard.boardtype}"><i class="fa fa-navicon"style="font-weight:bold;">게시물목록</i></a>
		    </td>
			</tr>
		</table>
</form>
</body>
</html>