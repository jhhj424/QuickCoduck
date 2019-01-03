<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<form:form modelAttribute="board" action="write.duck" enctype="multipart/form-data" name="f">
	<table border="1" style="border-collapse: collapse; width:100%">
	<form:hidden path="boardtype" value="${param.type}"/>
		<tr align="center" valign="middle">
		<c:if test="${param.type==1}">
			<td colspan="4">오픈소스게시판 글쓰기</td>
		</c:if>
		<c:if test="${param.type==2}">
			<td colspan="4">개발자자유게시판 글쓰기</td>
		</c:if>
		<c:if test="${param.type==3}">
			<td colspan="4">프로젝트공고모집게시판 글쓰기</td>
		</c:if>
		</tr>	
		<tr><td align="center">글쓴이</td>
		<td><form:input path="userid" value="${loginUser.userid}" readonly="true"/><font color="red"><form:errors path="userid" /></font></td></tr>
		<tr><td align="center">제목</td>
		<td><form:input path="subject"/><font color="red"><form:errors path="subject" /></font></td></tr>
		<tr><td align="center">내용</td>
		<td><form:textarea path="content" rows="15" cols="80"/>
			<font color="red"><form:errors path="content" /></font></td></tr>
		<tr><td align="center">첨부파일</td>
			<td><input type="file" name="file1"></td></tr>
		<tr><td colspan="2" align="center">
		<a href="javascript:document.f.submit()">[게시물등록]</a>
		<a href="list.duck">[게시물목록]</a></td></tr>
		</table></form:form></body></html>