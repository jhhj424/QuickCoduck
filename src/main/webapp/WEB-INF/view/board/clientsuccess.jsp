<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ŭ���̾�Ʈ �۾��� �Ϸ�</title>
</head>
<body>
<div id="client_main" align="center" style="border: 3px solid">
<h1>������Ʈ ���� ���� �ԽÿϷ�!</h1>
<table border="1" style="border-collapse: collapse; width: 100%">
<thead>
	<tr>
		<th>�۾���</th>
		<th>����</th>
		<th>�����</th>
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
<input type="button" value="��Ī���纸��" onclick="location.href='../user/matchuser.duck'">
<input type="button" value="��Ϻ���" onclick="location.href='../board/find.duck?type=${board.type}'">
</div>
</div >
</body>
</html>