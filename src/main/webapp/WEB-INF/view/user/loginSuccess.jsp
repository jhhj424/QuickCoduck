<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 성공</title>
</head>
<body>
<h2>환영합니다. ${sessionScope.loginUser.userid }님이 로그인 하셨습니다.</h2>
<table border="1" cellspacing="0" cellpadding="0">
  <tr><td>아이디</td><td>${loginUser.userid}</td></tr>
</table>
  <a href="mypage.duck?id=${loginUser.userid}">mypage</a>
  <%-- 1.세션 객체 제거.
  	   2.login.duck 페이지 이동   --%>
  <a href="logout.duck">로그아웃</a>
  <a href="../board/list.duck?type=1">오픈소스게시판</a>
  <a href="../board/list.duck?type=2">개발자자유게시판</a>
  <a href="../board/list.duck?type=3">프로젝트공고모집게시판</a>
</body>
</html>