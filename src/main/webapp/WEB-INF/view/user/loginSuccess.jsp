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
<h2>ȯ���մϴ�. ${sessionScope.loginUser.userName }���� �α��� �ϼ̽��ϴ�.</h2>
<table border="1" cellspacing="0" cellpadding="0">
  <tr><td>���̵�</td><td>${loginUser.userid}</td></tr>
</table>
  <a href="mypage.shop?id=${loginUser.userId}">mypage</a>
  <%-- 1.���� ��ü ����.
  	   2.login.shop ������ �̵�   --%>
  <a href="logout.shop">�α׾ƿ�</a>
  <a href="../item/list.shop">��ǰ���</a>
</body>
</html>