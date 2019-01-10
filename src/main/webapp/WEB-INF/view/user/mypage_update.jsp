<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_mypage_fileupload.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript">
	function file_delete() {
		document.f.file2.value = "";
		file_desc.style.display = "none";
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){		
		$("#develop_select").change(function(){
			var data ={
					"tech" : $("#tech_box").val()+$("#develop_select option:selected").val()
			};
			$.ajax({
				url : "../board/tech_select.duck",
				type : "post",
				data : data,
				dataType : "json", // ajax 통신으로 받는 타입
				success : function(data) {
					$("#tech_box").val(data.tech);
				},
				error : function(xhr, status,
						error) { //서버응답 실패
					alert("서버오류 : "
							+ xhr.status
							+ ", error : "
							+ error
							+ ", status : "
							+ status);
				}
			})
		})
		$("#design_select").change(function(){
			var data ={
					"tech" : $("#tech_box").val()+$("#design_select option:selected").val()
			};
			$.ajax({
				url : "../board/tech_select.duck",
				type : "post",
				data : data,
				dataType : "json", // ajax 통신으로 받는 타입
				success : function(data) {
					$("#tech_box").val(data.tech);
				},
				error : function(xhr, status,
						error) { //서버응답 실패
					alert("서버오류 : "
							+ xhr.status
							+ ", error : "
							+ error
							+ ", status : "
							+ status);
				}
			})
		})
		$("#tech_reset").click(function(){
			$("#tech_box").val("");
			return false;
		})
	})
</script>
</head>
<body>
<form action="update.duck" method="post" enctype="multipart/form-data" name="f">
<input type="hidden" name="file2" value="${loginUser.fileurl}">
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
          <input type="date" min=1901 max="2018" name="birth" placeholder="Your birth(1901~2018)">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 보유기술</b></h5>
          <div align="left">
		<select id="develop_select">
			<option value="">Develop</option>
			<option value="C">C</option>
			<option value="C++">C++</option>
			<option value="Java">Java</option>
			<option value="JSP">JSP</option>
			<option value="Python">Python</option>
			<option value="Ajax">Ajax</option>
			<option value="jQuery">jQuery</option>
			<option value="Ruby">Ruby</option>
			<option value="Android">Android</option>
			<option value="Unity">Unity</option>
		</select>
		<select id="design_select">
			<option value="">Design</option>
			<option value="HTML">HTML</option>
			<option value="CSS">CSS</option>
			<option value="BootStrap">BootStrap</option>
			<option value="DreamWeaver">DreamWeaver</option>
			<option value="PhotoShop">PhotoShop</option>
			<option value="XML">XML</option>
			<option value="Sketch">Sketch</option>
			<option value="JavaScript">JavaScript</option>
			<option value="Unity3d">Unity3d</option>
			<option value="iOS">iOS</option>
		</select>
		</div>
          <h6 class="w3-text-teal">
          <input readonly type="text" id="tech_box" name="usetech" value="${user.usetech }">
		<input type="button" id="tech_reset" value="reset">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 사진</b></h5>
          <c:if test="${!empty loginUser.fileurl}">
          <div id="file_desc">
			<a href="../file/${loginUser.fileurl}">${loginUser.fileurl}</a>
			<a href="javascript:file_delete()">[첨부파일삭제]</a></div>
		  </c:if>
		  <div class="filebox preview-image">
			<input class="upload-name" value="Choose Photo!"disabled="disabled">
			  <label for="input-file">Upload</label>
			    <input type="file" id="input-file" class="upload-hidden" name="file1">
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