<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>유저 마이페이지</title>
</head>
<body>

<table>
<tr><td colspan="4">
<c:forEach items="${selflist}" var="self">
     <tr><td align="center">${self.id}</td>
     	 <td align="left"><a href="detail.duck?id=${self.id}">${self.subject}</a></td>
     	 <td align="center">${self.regdate}</td>
     	 <td align="center"><a href="edit.shop?id=${item.id}">수정</a></td>
     	 <td align="center"><a href="confirm.shop?id=${item.id}">삭제</a></td>
 </c:forEach>
 </table>
</body>
</html>