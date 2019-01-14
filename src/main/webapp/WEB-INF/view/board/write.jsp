<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
	<div>
		<div align="center">
		<c:if test="${param.type==1}">
			<div><h3>오픈소스게시판 글쓰기</h3></div>
		</c:if>
		<c:if test="${param.type==2}">
			<div><h3>개발자자유게시판 글쓰기</h3></div>
		</c:if>
		<c:if test="${param.type==3}">
			<div><h3>프로젝트공고모집게시판 글쓰기</h3></div>
		</c:if>
		<c:if test="${param.type==5}">
			<div><h3>나만의소스 작성하기</h3></div>
		</c:if>
		</div>	
		<div>
		<div align="center"><b>글쓴이 : </b><form:input path="userid" value="${loginUser.userid}" readonly="true"/><font color="red"><form:errors path="userid" /></font></div>
		<c:if test="${param.type==1 || param.type==3 || param.type==5 || boardtype==1 || boardtype==3 || boardtype==5}">
		<div align="center">
		<b>사용기술 : </b>
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
		<div><div align="center">
		<c:if test="${param.type==3 || boardtype==3}">
		<b>가격 : </b><form:input path="price" onkeyup="number_chk(this);" onkeypress="javascript:if((event.keyCode<48)||(event.keyCode>57))event.returnValue=false;" style="ime-mode:disabled; text-align: right;" />원<font color="red"><form:errors path="price" /></font>
		<br>
		<b>기간 : </b><form:input path="schedule" style="ime-mode:disabled; text-align: right;"/>일<font color="red"><form:errors path="schedule" /></font>
		<br>
		</c:if>
		<b>제목 : </b><form:input path="subject"/><font color="red"><form:errors path="subject" /></font>
		</div></div>
		</div>
		<div><div align="center"><b>[내용]</b></div>
		<div><form:textarea path="content" rows="15" cols="80"/>
			<font color="red"><form:errors path="content" /></font></div></div>
		<div><div align="center"><b>첨부파일 : </b><input type="file" name="file1"></div></div>
		<div align="center">
		 <c:if test="${param.type==1 || param.type==3 || param.type==5 || boardtype==1 || boardtype==3 || boardtype==5}">
		<div align="center">
		<b>사용기술 : </b><input readonly type="text" id="tech_box" name="techlist" value="">
		<input type="button" id="tech_reset" value="reset"></div>
		</c:if>
		<br>
		<a href="javascript:document.f.submit()">[게시물등록]</a>
		<c:if test="${param.type==1 || param.type==3 || param.type==5}">
		<a href="find.duck?type=${param.type}">[게시물목록]</a>
		</c:if>
		<c:if test="${boardtype==1 || boardtype==3 || boardtype==5 }">
		<a href="find.duck?type=${boardtype}">[게시물목록]</a>
		</c:if>
		<c:if test="${param.type!=1 && param.type!=3 && param.type!=5 && boardtype== null}">
		<a href="list.duck?type=${param.type}">[게시물목록]</a>
		</c:if>
		<c:if test="${boardtype==2}">
		<a href="list.duck?type=${boardtype}">[게시물목록]</a>
		</c:if>
		</div>
		</div></form:form></body></html>