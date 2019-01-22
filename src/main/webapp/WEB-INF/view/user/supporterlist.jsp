<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 목록</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<div style="border-collapse:collapse; width:70%;margin-bottom:50px;margin:0 auto;">
<h2 class="w3-text-grey" style="background-color:#FEFEFE;font-weight:bold;">
<i class="fa fa-group w3-margin-right"></i>지원자 목록</h2>
</div>
<table border="1" style="border-collapse:collapse; width:70%;margin-bottom:50px;margin-top:50px;margin:0 auto;" class="table">
	<tr>
		<th class="th" style="font-weight:bold;">사진</th>
		<th class="th" style="font-weight:bold;">아이디</th>
		<th class="th" style="font-weight:bold;">이메일</th>
		<th class="th" style="font-weight:bold;">전화번호</th>
		<th class="th" style="font-weight:bold;">사용기술</th>
	</tr>
	<c:forEach items="${supporterlist}" var="user">
	<tr>
		<td align="center" class="th"><a href="../file/${user.fileurl}"> <img
						src="../file/${user.fileurl}"
						style="height: 120px; width: 90px; border-radius: 5px;margin:1px 1px 1px 1px;" alt="사진없음">
				</a></td>
		<td class="th">${user.userid}</td>
		<td class="th">${user.email}</td>
		<td class="th" align="center">${user.tel}</td>
		<td class="th">
		<c:if test="${!empty user.usetech }">
		<c:forEach var="utech" items="${user.usetech}" varStatus="g" begin="0">
        <span class="tag"><i class="fa fa-check" style="margin-right:3px;"></i>${utech}</span>
        <c:out value="${g.end}" />
        </c:forEach>
        </c:if>
        <c:if test="${empty user.usetech }">
        <span class="tag2">Empty Tech</span>
        </c:if>
        </td>
	</tr>
	<tr>
	<td class="th" align="center" colspan="5">
	  <button type="button" style="width:49%" id="accept" onclick="location.href='accept.duck?userid=${user.userid}&boardnum=${param.boardnum}'" class="button">수락</button>
	  <button type="button" style="width:49%" id="fail" onclick="location.href='fail.duck?userid=${user.userid}&boardnum=${param.boardnum}'" class="button1">거절</button>
	</td>
	</tr>
	</c:forEach>
</table>
<div class="table" style="width:70%;margin:0 auto;margin-bottom:50px;margin-top:50px;">
<h2 class="w3-text-grey" style="background-color:#FEFEFE;">
<i class="fa fa-copyright"></i>2019 QuickCoduck Corp</h2>
<button type="button" id="fail" onclick="location.href='../user/mypage_waitlist.duck'" class="button2" style="font-weight:bold;">
<i class="fa fa-navicon w3-margin-right w3-margin-left"></i>내 게시물 목록보기</button>
</div>
</body>
</html>