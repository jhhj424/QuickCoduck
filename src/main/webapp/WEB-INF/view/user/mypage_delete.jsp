<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="delete.duck" method="post"name="f">
<input type="hidden" name="id" value="${param.id}">
 <div class="w3-container w3-card w3-white w3-round w3-margin">
      <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-user-times fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 회원탈퇴</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-keyboard-o fa-fw w3-margin-right"></i><b>비밀번호</b></h5>
          <h6 class="w3-text-teal">
          <input type="password" name="pass" required="required">
          <input type="submit" value="탈퇴하기">
          </h6>
          <hr>
      </div>
  </div>
</form>
</body>
</html>