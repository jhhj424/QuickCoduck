<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_mypage_fileupload.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_update_css.jsp" %>
<%@ include file="/WEB-INF/view/style/input_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
.tech{
  width: 70%;
  height: 30px;
  padding-left: 10px;
  padding-top: 3px;
  padding-bottom: 3px;
  margin: 7px;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
.reset{
  width: 10%;
  height: 30px;
  padding-left: 10px;
  padding-top: 3px;
  padding-bottom: 3px;
  margin: 7px;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
</style>
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
<script>
//콤마찍기 and 숫자체크
function commanAndNum(obj) 
{
  var n = obj.value;
  n = onlyNumber(n);
  var reg = /(^[+-]?\d+)(\d{4})/;   // 정규식
  n += '';                          // 숫자를 문자열로 변환
  while (reg.test(n))
  n = n.replace(reg, '$1' + '-' + '$2');  
  obj.value = n;     
}

//숫자체크
function onlyNumber(objVal) 
{
 var replaceNum = unNumberFormat(objVal);
 var preNum = replaceNum;
 if(/[^0123456789]/g.test(replaceNum)) 
 {
  preNum = "";
  for (i = 0; i < (replaceNum.length - 1); i++)
   {
    preNum = preNum + replaceNum.charAt(i);
   }
  alert("숫자가 아닙니다.\n\n0-9의 정수만 허용합니다.");
 }
 if(replaceNum == 0)
 {
  if(preNum != "")
  {
   alert("첫자리 0은 허용하지 않습니다.");
  }
  preNum = "";
 }
  return preNum;
}
//특수문자 제거
function unNumberFormat(num) 
{
 return (num.replace(/\-/g,""));
} 
</script>
</head>
<body>
<form action="update.duck" method="post" enctype="multipart/form-data" name="f">
<input type="hidden" name="file2" value="${user.fileurl}">
<input type="hidden" name="type" value="${user.type }">
 <div class="w3-container w3-card w3-white w3-round w3-margin">
      <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-user-plus fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 회원정보</h2>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-id-badge fa-fw w3-margin-right"></i><b>회원 Id</b></h5>
          <h6 class="w3-text-teal">
          <input type="text" value="${user.userid }" readonly="readonly" name="userid">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-envelope fa-fw w3-margin-right"></i>
          <c:if test="${user.type == '1' }"><b>회원 Email</b></c:if>
          <c:if test="${user.type == '2' }"><b>사업자 Email</b></c:if>
          </h5>
          <h6 class="w3-text-teal">
          <input type="email" value="${user.email }" name="email">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-volume-control-phone fa-fw w3-margin-right"></i>
          <c:if test="${user.type == '1' }"><b>회원 Tel</b></c:if>
          <c:if test="${user.type == '2' }"><b>사업자 Tel</b></c:if>
          </h5>
          <h6 class="w3-text-teal">
          <input type="text" value="${user.tel }" name="tel">
          </h6>
          <hr>
       </div>
       <c:if test="${user.type == '1' }">
        <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-calendar fa-fw w3-margin-right"></i><b>사용자 birth</b></h5>
          <h6 class="w3-text-teal">
          <fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="bibi"/>
          <input type="date" min="1901-01-01" max="2019-01-01" name="birth" value="${bibi}">
          </h6>
          <hr>
       </div>
       </c:if>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-briefcase fa-fw w3-margin-right"></i>
          <c:if test="${user.type == '1' }"><b>사용자 보유기술</b></c:if>
          <c:if test="${user.type == '2' }"><b>프로젝트 주요기술</b></c:if>
          </h5>
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
          <input readonly type="text" id="tech_box" name="usetech" value="${user.usetech }" class="tech">
		<input type="button" id="tech_reset" value="reset" class="reset">
          </h6>
          <hr>
       </div>
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-file-image-o fa-fw w3-margin-right"></i>
          <c:if test="${user.type == '1' }"><b>회원 프로필사진</b></c:if>
          <c:if test="${user.type == '2' }"><b>사업자 대표사진</b></c:if>
          </h5>
          <c:if test="${!empty user.fileurl}">
          <div id="file_desc">
			<a href="../file/${user.fileurl}">${user.fileurl}</a>
			<a href="javascript:file_delete()">[첨부파일삭제]</a></div>
		  </c:if>
		  <div class="filebox preview-image">
			<input class="upload-name" value="Choose Photo!"disabled="disabled">
			  <label for="input-file">Upload</label>
			    <input type="file" id="input-file" class="upload-hidden" name="file1">
		  </div>
          <hr>
       </div>
    </div>
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-refresh fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 정보 수정하기</h2>
        <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-refresh fa-fw w3-margin-right"></i><b>정보 수정하기</b></h5>
          <h6 class="w3-text-teal">
          <input type="submit" value="수정하기">
          </h6>
          <hr>
       </div>
    </div>
    <c:if test="${user.type == '2' }">
    <div class="w3-container w3-card w3-white w3-round w3-margin">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-krw fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i> 결제정보</h2>
        <div class="container">
  <div class="col1">
    <div class="card">
      <div class="front">
        <div class="type">
          <img class="bankid"/>
        </div>
        <span class="chip"></span>
        <span class="card_number">
        <c:if test="${empty user.creditnum }">
        &#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF;
        </c:if>
        <c:if test="${!empty user.creditnum }">
        ${loginUser.creditnum }
        </c:if>
         </span>
        <div class="date"><span class="date_value">MM / YYYY</span></div>
        <span class="fullname" style="margin-top:10px;">${loginUser.userid }</span>
      </div>
    </div>
  </div>
</div>
       <c:if test="${empty user.creditnum }">
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-credit-card fa-fw w3-margin-right"></i><b>카드번호</b></h5>
          <input type="text" name="creditnum" id="creditnum"  maxlength="19"onkeyup="javascript:commanAndNum(this)">
          <hr>
       </div>
       </c:if>
       <c:if test="${!empty user.creditnum }">
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-credit-card fa-fw w3-margin-right"></i><b>카드번호</b></h5>
          <input type="text" name="creditnum" id="re_creditnum" maxlength="19" onkeyup="javascript:commanAndNum(this)" value="${user.creditnum }" readonly="readonly">
          <hr>
       </div>
       </c:if>
       <c:if test="${empty user.creditpass }">
       <div class="w3-container">
          <h5 class="w3-opacity"><i class="fa fa-shield fa-fw w3-margin-right"></i><b>결제 비밀번호</b></h5>
          <input type="password" name="creditpass" id="creditpass" maxlength="4">
          <hr>
       </div>
     </c:if>
       <c:if test="${!empty user.creditpass }">
       <div class="w3-container" style="display:none;">
          <h5 class="w3-opacity"><i class="fa fa-shield fa-fw w3-margin-right"></i><b>결제 비밀번호</b></h5>
          <input type="password" name="creditpass" id="re_creditpass" value="${user.creditpass }" maxlength="4" readonly="readonly">
          <hr>
       </div>
       </c:if>
    </div>
    </c:if>
</form>
</body>
</html>