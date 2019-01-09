<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_mypage_fileupload.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<form action="update.duck" method="post" enctype="multipart/form-data" name="f">
 <div class="w3-container w3-card w3-white w3-round w3-margin">
      <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-user-plus fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 회원정보 수정</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 id</b></h5>
          <h6 class="w3-text-teal">
          <input type="text" value="${loginUser.userid }" readonly="readonly" name="userid">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 email</b></h5>
          <h6 class="w3-text-teal">
          <input type="email" value="${loginUser.email }" name="email">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 tel</b></h5>
          <h6 class="w3-text-teal">
          <input type="text" value="${loginUser.tel }" name="tel">
          </h6>
          <hr>
       </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 birth</b></h5>
          <h6 class="w3-text-teal">
          <input type="date" min=1901 max="2018" name="birth" required="required" placeholder="Your birth(1901~2018)">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 사진</b></h5>
          <div class="filebox preview-image">
			<input class="upload-name" value="Choose Photo!"disabled="disabled">
			  <label for="input-file">Upload</label>
			    <input type="file" id="input-file" class="upload-hidden" name="picture">
		  </div>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 birth</b></h5>
          <h6 class="w3-text-teal">
          <input type="submit" value="수정하기">
          </h6>
          <hr>
       </div>
    </div>
</form>
</body>
</html>