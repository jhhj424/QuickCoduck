<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ����</title>
</head>
<body>
<h2>ȯ���մϴ�. ${sessionScope.loginUser.userid }���� �α��� �ϼ̽��ϴ�.</h2>
<table border="1" cellspacing="0" cellpadding="0">
  <tr><td>���̵�</td><td>${loginUser.userid}</td></tr>
</table>
  <a href="mypage.duck?id=${loginUser.userid}">mypage</a>
  <%-- 1.���� ��ü ����.
  	   2.login.duck ������ �̵�   --%>
  <a href="logout.duck">�α׾ƿ�</a>
  <a href="../board/list.duck?type=1">���¼ҽ��Խ���</a>
  <a href="../board/list.duck?type=2">�����������Խ���</a>
  <a href="../board/list.duck?type=3">������Ʈ��������Խ���</a>
</body>
</html>