<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>제안받은 프로젝트</title>
<c:set var="path" value="${pageContext.request.contextPath}" />
</head>
<body>
<div class="w3-container">
		<div class="w3-ul w3-card-4">
			<table class="table14_10" style="width: 100%">
				<tr>
					<td colspan="2">
					<h2>제안받은 프로젝트</h2>
					</td>
					<c:if test="${board.boardtype==1 || board.boardtype==2}">
					<tr>
						<td align="center" colspan="2">
							<input class="recview" style="text-align: center;" readonly value="추천수 : ${board.recmd}">
						</td>
					</tr>
					</c:if>
					<c:if test="${board.boardtype==3}">
					<tr>
						<td align="center">
							프로젝트 기간
						</td>
						<td align="center">
							${board.schedule} 일
						</td>
					</tr>
					<tr>
						<td align="center">
							프로젝트 금액
						</td>
						<td align="center">
							${board.price} 원
						</td>
					</tr>
					</c:if>
				</tr>
				<tr>
					<td width="15%">글쓴이</td>
					<td width="85%">${board.userid}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${board.subject}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<table style = "width:100%; height:250">
							<tr>
								<td>
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
					<td>첨부파일</td>
					<td>&nbsp; <c:if test="${!empty board.fileurl}"><a href="../file/${board.fileurl}">${board.fileurl}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
							<button onclick="location.href='suggest_accept.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" > 수락</button>
							<button onclick="location.href='suggest_refuse.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" > 거절</button>
							<button onclick="location.href='../user/mypage_suggestlist.duck?id=${loginUser.userid}&ducktype=6'" > 목록</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
</body>
</html>