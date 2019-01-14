<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_mypage_fileupload.jsp" %>
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
text-align:left;
margin:10px 10px 10px 10px;
}
</style>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		$("#develop_select").change(function(){
			var data ={
					"tech" : $("#tech_box").val()+$("#develop_select option:selected").val()
			};
			$.ajax({
				url : "tech_select.duck",
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
				url : "tech_select.duck",
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
function number_chk(obj){
var val = obj.value.replace(/,/g, "");
var val2 = val.substr(0, 1);
var val3 = val.length;
if(val2 == 0){
			val = val.substr(1, val3);
		}
	obj.value = num_format(val);
}
function num_format(n){
var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
n = String(n);    //숫자 -> 문자변환
while(reg.test(n)){
				n = n.replace(reg, "$1" + "," + "$2");
			}
		return n;
	}
</script>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<form:form modelAttribute="board" action="write.duck" enctype="multipart/form-data" name="f">
<form:hidden path="boardtype" value="${param.type}"/>
<div class="w3-container w3-card w3-white w3-margin-bottom"style="max-width:80%;margin: 0 auto;">
<h2 class="w3-text-grey w3-padding-16">
<c:if test="${param.type==1 || boardtype==1}">
<i class="fa fa-github fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
오픈소스게시판 글쓰기</c:if>
<c:if test="${param.type==2 || boardtype==2}">
<i class="fa fa-wechat fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
개발자자유게시판 글쓰기</c:if>
<c:if test="${param.type==3 || boardtype==3}">
<i class="fa fa-black-tie fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
프로젝트공고모집게시판 글쓰기</c:if>
<c:if test="${param.type==5 || boardtype==5}">
<i class="fa fa-jsfiddle fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
나만의소스 작성하기</c:if>
</h2>
<div align="center">
		
</div>	
<div class="half left">
<div class="div">
		<b>글쓴이 : </b>
		<form:input path="userid" value="${loginUser.userid}" readonly="true"/><font color="red">
		<form:errors path="userid" /></font>
</div>
<c:if test="${param.type==1 || param.type==3 || param.type==5 || boardtype==1 || boardtype==3 || boardtype==5}">
<div class="div">
		<b>사용기술 : </b><input readonly type="text" id="tech_box" name="techlist" value="">
		<input type="button" id="tech_reset" value="reset">
</div>
<div class="div">
<b>선택 리스트:</b>
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
		</c:if>
		<%-- 
		<div>
			<div align="center"><b>프로젝트 금액 : </b>
				<form:input path="price" 
				<font color="red"><form:errors path="price" /></font>
			</div>
		</div>
		</c:if> --%>
<c:if test="${param.type==3 || boardtype==3}">
<div class="div">
		<b>가격 : </b><form:input path="price" onkeyup="number_chk(this);" onkeypress="javascript:if((event.keyCode<48)||(event.keyCode>57))event.returnValue=false;" style="ime-mode:disabled; text-align: right;" />원<font color="red"><form:errors path="price" /></font>
		<br>
		<b>기간 : </b><form:input path="schedule" style="ime-mode:disabled; text-align: right;"/>일<font color="red"><form:errors path="schedule" /></font>
		<br>
</div>
</c:if>
<div class="div">
		<b>제목 : </b><form:input path="subject"/><font color="red"><form:errors path="subject" /></font>
</div>
<div class="div"><b>첨부파일 : </b>
          <div class="filebox preview-image">
			<input class="upload-name" value="Choose Photo!"disabled="disabled">
			  <label for="input-file">Upload</label>
			    <input type="file" id="input-file" class="upload-hidden" name="file1">
		  </div>
</div>
</div>
<!-- 왼쪽 div 끝나는 지점 -->
<div class="half right">
<div align="center"><b>[내용]</b>
<font color="red"><form:errors path="content" /></font>		
</div>
<div><form:textarea path="content" rows="15" cols="80" style="width:100%;resize:none;font-size:20px;"/>

</div>
</div>
<!-- 오른쪽 div 끝나는 지점 -->
<div style="text-align:center;margin-bottom:20px;">
		<a href="javascript:document.f.submit()"class="w3-hover" style="color:#000"><i class="fa fa-edit w3-margin-right">[게시물등록]</i></a>
		<c:if test="${param.type==1 || param.type==3 || param.type==5}">
		<a href="find.duck?type=${param.type}"class="w3-hover" style="color:#000"><i class="fa fa-list">[게시물목록]</i></a>
		</c:if>
		<c:if test="${boardtype==1 || boardtype==3 || boardtype==5 }">
		<a href="find.duck?type=${boardtype}"class="w3-hover" style="color:#000"><i class="fa fa-list">[게시물목록]</i></a>
		</c:if>
		<c:if test="${param.type!=1 && param.type!=3 && param.type!=5 && boardtype== null}">
		<a href="list.duck?type=${param.type}"class="w3-hover" style="color:#000"><i class="fa fa-list">[게시물목록]</i></a>
		</c:if>
		<c:if test="${boardtype==2}">
		<a href="list.duck?type=${boardtype}"class="w3-hover" style="color:#000"><i class="fa fa-list">[게시물목록]</i></a>
		</c:if>
		</div>
		</div></form:form></body></html>