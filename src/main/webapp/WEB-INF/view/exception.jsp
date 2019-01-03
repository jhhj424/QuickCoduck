<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%-- isErrorPage="true" : 현재 페이지가 error 페이지임.
						  exception 객체가 전달.
						  exception 객체 : exception.CartEmptyException 객체임.
						  내장객체로 전달
${exception.message} : exception.CartEmptyException.getMessage() : 메서드 호출
${exception.url} : exception.CartEmptyException.getUrl() : 메서드 호출
 --%>
<script>
	alert("${exception.message}");
	location.href="${exception.url}";
</script>