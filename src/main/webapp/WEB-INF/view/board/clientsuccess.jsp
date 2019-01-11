<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>클라이언트 글쓰기 완료</title>
</head>
<body>
<div id="client_main" align="center" style="border: 3px solid">
<h1>프로젝트 모집 공고 게시완료!</h1>
<table border="1" style="border-collapse: collapse; width: 100%">
<thead>
	<tr>
		<th>글쓴이</th>
		<th>제목</th>
		<th>사용기술</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>${board.userid}</td>
		<td>${board.subject}</td>
		<td>${board.usetech}</td>
	</tr>
</tbody>
</table>
<div id="client_select" align="center" style="border: 1px solid">
<input type="button" value="매칭인재보기" onclick="location.href='../user/matchuser.duck'">
<input type="button" value="목록보기" onclick="location.href='../board/find.duck?type=${board.type}'">
</div>
</div >
</body>
</html>