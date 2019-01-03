<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /WEB_INF/view/user/updateForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 수정</title>
</head>
<body>
<%--
   1. AOP 설정.
   2. User 객체에 id 파라미터에 해당하는 고객정보 저장.
 --%>
<h2>사용자 수정</h2>
<%-- modelAttribute="user" : 현재 페이지가 호출 될 때 user객체가 존재해야함 --%>
<form:form modelAttribute="user" method="post" action="update.duck" >
   <table>
      <tr height="40px" ><td>아이디</td><td><form:input path="userid" readonly="true"/>
      </td></tr>
      <tr height="40px" ><td>비밀번호</td><td><form:password path="pass" />
      </td></tr>
      <tr height="40px" ><td>이메일</td><td><form:input path="email"/>
      </td></tr>
      <tr height="40px" ><td>전화번호</td><td><form:input path="tel"/>
      </td></tr>
      <tr height="40px" ><td>생년월일</td><td><form:input type="Date" path="birth"/>
      </td></tr>
   <c:if test="${user.type==1}">
       <tr height="40px" ><td>사용가능기술</td><td><form:input path="usetech"/>
       </td></tr>
       <tr height="40px" ><td>인재등록여부</td>
         <td><form:radiobutton path="rating" value="0" checked="checked"/>등록안함
            <form:radiobutton path="rating" value="1"/>등록함</td>
      </tr>
    </c:if>
    <c:if test="${user.type==2}">
       <tr height="40px" ><td>사업자번호</td><td><form:input path="businessnum"/>
       </td></tr>
       <tr height="40px" ><td>등록한 계좌번호</td><td><form:input path="creditnum"/>
       </td></tr>
    </c:if>
      <tr height="40px"><td colspan="2" align="center">
        <input type="submit" value="수정"><input type="reset" value="초기화">
        </td></tr></table></form:form></body>
</html>