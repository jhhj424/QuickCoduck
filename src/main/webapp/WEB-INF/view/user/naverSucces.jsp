<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    var uniqId = ${result}.response.uniqId;
    var email = ${result}.response.email;
    $("#name").html("ȯ���մϴ�. "+uniqId+"��");
    $("#email").html(email);
    });
  //location.href = "${pageContext.request.contextPath}/";
</script>
</head>
<body>
	<script>
    $(function () {
      $("body").hide();
      $("body").fadeIn(1000);  // 1�� �ڿ� ��� ���� 
     
      setTimeout(function(){$("body").fadeOut(1000);},1000);
      setTimeout(function(){location.href= "${pageContext.request.contextPath}/user/main"},2000);
// 2�� �ڿ� ���� ȭ�� ���� ����  
    
    })
  </script>
</body>
</html>