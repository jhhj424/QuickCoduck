<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuickCoduck_Main</title>
</head>
<body>
<h1>메인 페이지 입니다</h1>
<h1><a href="logout.duck">로그아웃</a></h1>
<h1><a href="mypage.duck?id=${sessionScope.loginUser.userid}">mypage</a></h1>
<h1><a href="../board/find.duck?type=1">[게시판테스트중] - 오픈소스,프로젝트공고 게시판Form</a></h1>
<h1><a href="../board/list.duck?type=1">오픈소스게시판</a></h1>
<h1><a href="../board/list.duck?type=2">개발자자유게시판</a></h1>
<h1><a href="../board/list.duck?type=3">프로젝트공고모집게시판</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=1&type=1">덕한거보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=1&type=3">스크랩보기</a></h1>
<h1><a href="../user/myduck.duck?id=${user.userid}&ducktype=2&type=3">신청프로젝트보기</a></h1>
<h1><a href="submain.duck">서브메인</a></h1>
<h1>테스트 용입니다</h1>
</body>
</html>