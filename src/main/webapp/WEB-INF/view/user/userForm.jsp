<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WEB-INF/view/user/userForm.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ���</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
 $(function(){
  $('#pass').keyup(function(){
   $('font[name=check]').text('');
  }); //#user_pass.keyup

  $('#pass2').keyup(function(){
   if($('#pass').val()!=$('#pass2').val()){
    $('font[name=check]').text('');
    $('font[name=check]').html("��ȣƲ��");
   }else{
    $('font[name=check]').text('');
    $('font[name=check]').html("��ȣ����");
   }
  }); //#pass2.keyup
 });

</script>
</head>
<body>
<h2>ȸ������</h2>
<%-- modelAttribute="user" : ���� �������� ȣ�� �� �� user��ü�� �����ؾ��� --%>
<form:form modelAttribute="user" method="post" action="userEntry.duck">
	<table>
		<tr height="40px" ><td>
		
		<form:radiobutton path="type" value="1" checked="checked"/>������
		<form:radiobutton path="type" value="2"/>Ŭ���̾�Ʈ
		
		</td></tr>
		<tr height="40px" ><td>���̵�</td><td><form:input path="userid"/>
		</td></tr>
		<tr height="40px" ><td>�̸���</td><td><form:input path="email"/>
		</td></tr>
		<tr height="40px" ><td>��й�ȣ</td><td><form:password path="pass" />
		</td></tr>
		<tr height="40px" ><td>��й�ȣȮ��</td><td><input type="password" name="pass2" id="pass2"/>
		<font name="check" color="red"></font>
		</td></tr>
		
		<tr height="40px"><td colspan="2" align="center">
		  <input id="submit" type="submit" value="���"><input type="reset" value="�ʱ�ȭ">
		  </td></tr></table></form:form></body></html>