<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WEB-INF/view/user/userForm.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>개발자 등록</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
 $(function(){
  $('#pass').keyup(function(){
   $('font[name=check]').text('');
  }); //#user_pass.keyup

  $('#pass2').keyup(function(){
   if($('#pass').val()!=$('#pass2').val()){
    $('font[name=check]').text('');
    $('font[name=check]').html("암호틀림");
   }else{
    $('font[name=check]').text('');
    $('font[name=check]').html("암호맞음");
   }
  }); //#pass2.keyup
 });

</script>
</head>
<body>
<h2>회원가입</h2>
<%-- modelAttribute="user" : 현재 페이지가 호출 될 때 user객체가 존재해야함 --%>
<form:form modelAttribute="user" method="post" action="userEntry.duck">
	<table>
		<tr height="40px" ><td>
		
		<form:radiobutton path="type" value="1" checked="checked"/>개발자
		<form:radiobutton path="type" value="2"/>클라이언트
		
		</td></tr>
		<tr height="40px" ><td>아이디</td><td><form:input path="userid"/>
		</td></tr>
		<tr height="40px" ><td>이메일</td><td><form:input path="email"/>
		</td></tr>
		<tr height="40px" ><td>비밀번호</td><td><form:password path="pass" />
		</td></tr>
		<tr height="40px" ><td>비밀번호확인</td><td><input type="password" name="pass2" id="pass2"/>
		<font name="check" color="red"></font>
		</td></tr>
		
		<tr height="40px"><td colspan="2" align="center">
		  <input id="submit" type="submit" value="등록"><input type="reset" value="초기화">
		  </td></tr></table></form:form></body></html>