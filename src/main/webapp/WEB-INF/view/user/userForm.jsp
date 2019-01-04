<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/user/userForm.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개발자 등록</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
 $(function(){
  $('#pass').keyup(function(){
   	$('font[name=check]').text('');
   	$('font[name=checklen]').text('');
   	if($('#pass').val().length < 4 || $('#pass').val().length > 13){
 	   $('font[name=checklen]').text('');
 	   $('font[name=checklen]').html("4글자이상 12글자이하로 입력해주세요.");
    }else{
 	   $('font[name=checklen]').text('');
 	   $('font[name=checklen]').html("");
 	   return false
    }
  }); //#user_pass.keyup

  $('#pass2').keyup(function(){
   if($('#pass').val()!=$('#pass2').val()){
    	$('font[name=check]').text('');
    	$('font[name=check]').html("암호불일치");
   }else{
    	$('font[name=check]').text('');
    	$('font[name=check]').html("암호일치");
   }
  }); //#pass2.keyup
  
  $('#userid').keyup(function(){
   if($('#userid').val().length < 3 || $('#userid').val().length > 10){
	   $('font[name=userlen]').text('');
	   $('font[name=userlen]').html("3글자이상 10글자 이하로 입력하세요.");
   }else{
	   $('font[name=userlen]').text('');
	   $('font[name=userlen]').html("");
   }
  });
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
		<font name="userlen" color="red"></font>
		
		<spring:hasBindErrors name="user">
    		<font color="red">
      			<c:forEach items="${errors.globalErrors}" var="error">
        			<spring:message code="${error.code}" />
      			</c:forEach>
    		</font>
  		</spring:hasBindErrors>
  		
		</td></tr>
		
		<tr height="40px" ><td>이메일</td><td><form:input path="email"/>
		</td></tr>
		<tr height="40px" ><td>비밀번호</td><td><form:password path="pass" name="pass" id="pass"/>
		<font name="checklen" color="red"></font>
		</td></tr>
		<tr height="40px" ><td>비밀번호확인</td><td><input type="password" name="pass2" id="pass2"/>
		<font name="check" color="red"></font>
		</td></tr>
		
		<tr height="40px"><td colspan="2" align="center">
		  <input type="submit" value="등록">
		  <input type="reset" value="초기화">
		  </td></tr></table></form:form></body></html>