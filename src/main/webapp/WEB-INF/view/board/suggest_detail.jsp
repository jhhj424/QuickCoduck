<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제안받은 프로젝트</title>
<c:set var="path" value="${pageContext.request.contextPath}" />
</head>
<body>
<div class="table" style="width:70%;margin:0 auto;margin-bottom:50px;">
<h2 class="w3-padding-16" style="font-weight:bold;color:#181a1bd1;">
<i class="fa fa-handshake-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>제안받은 프로젝트
</h2>
<table style="width:100%">
<tr>
<c:if test="${board.boardtype==1 || board.boardtype==2}">
<tr>
<td align="center" colspan="2"class="th" style="font-weight:bold;">
<input class="recview" style="text-align: center;" readonly value="추천수 : ${board.recmd}">
</td>
					</tr>
					</c:if>
					<c:if test="${board.boardtype==3}">
					<tr>
						<td class="th" style="font-weight:bold;">프로젝트 기간</td>
						<td class="th" style="font-weight:bold;">${board.schedule} 일</td>
					</tr>
					<tr>
						<td class="th" style="font-weight:bold;">프로젝트 금액</td>
						<td class="th" style="font-weight:bold;">${board.price} 원</td>
					</tr>
					</c:if>
				</tr>
				<tr>
					<td width="15%"class="th" style="font-weight:bold;">글쓴이</td>
					<td width="85%"class="th" style="font-weight:bold;">${board.userid}</td>
				</tr>
				<tr>
					<td class="th" style="font-weight:bold;">제목</td>
					<td class="th" style="font-weight:bold;">${board.subject}</td>
				</tr>
				<tr>
					<td class="th" style="font-weight:bold;">내용</td>
					<td class="th" style="font-weight:bold;">
						<table style = "width:100%; height:250" class="table">
							<tr>
								<td class="th" style="font-weight:bold;">
								<c:if test="${!empty board.fileurl }">
									<img src="${path}/file/${board.fileurl}" style="max-width: 500px; max-height:500px;">
									<br>
								</c:if>
								<div style="padding: 30px; margin: 30px; text-align: left; min-width: 800px;max-width: 800px">
								${fn:replace(board.content, cn, br)}
								</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="th" style="font-weight:bold;">첨부파일</td>
					<td class="th" style="font-weight:bold;">&nbsp; <c:if test="${!empty board.fileurl}"><a href="../file/${board.fileurl}">${board.fileurl}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="th" style="font-weight:bold;">
							<button onclick="location.href='suggest_accept.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" class="button"> 수락</button>
							<button onclick="location.href='suggest_refuse.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" class="button1"> 거절</button>
							<button onclick="location.href='../user/mypage_suggestlist.duck?id=${loginUser.userid}&ducktype=6'" class="button"> 목록</button>
						</td>
					</tr>
				</table>
</div>
</body>
</html>