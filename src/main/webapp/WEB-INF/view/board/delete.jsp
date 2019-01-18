<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
text-align:center;
margin:10px 10px 10px 10px;
}
</style>
<meta charset="UTF-8">
<title>Spring 게시판 삭제</title>
</head>
<body>
<form action="delete.duck" name="f" method="post">
	<input type="hidden" name="boardnum" value="${board.boardnum}${notice.boardnum}">
	<input type="hidden" name="type" value="${board.boardtype}${notice.boardtype}">
<div class="w3-container w3-card w3-white w3-margin-bottom"style="max-width:50%;height:30%;margin: 0 auto;">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-trash-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>삭제</h2><br>
<div class="div">
		<b style="font-size:17px;">유저 비밀번호 : </b>
		<input type="password" name="pass">
		<a href="javascript:document.f.submit();"><i class="fa fa-trash-o w3-xlarge w3-margin-right">[게시물삭제]</i></a>
</div>
</div>
</form>
</body> 
</html>