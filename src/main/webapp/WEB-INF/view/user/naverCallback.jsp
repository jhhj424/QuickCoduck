<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("{hZgcybLLosz6OTLjGrZm}","http://localhost:8080/quickcoduck/user/main.duck");
	// ���� ��ū �� ���
	alert(naver_id_login.oauthParams.access_token);
	
	//���̹� ����� ������ ��ȸ
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	//���̹� ����� ������ ��ȸ ���� ������ ������ ó���� callback function
	function naverSignInCallback(){
		var id = naver_id_login.getProfileData('id')+"@n";
		var email = naver_id_login.getProfileData('email');
		
		$.ajax({
			url : "",
			method : "POST",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			successs : function(idchk){
				if(idchk == true){ //DB�� ���̵� ���� ��� => ȸ������
					console.log("ȸ�� ���� ���Դϴ�.");
				$.ajax({
					url : "",
					method : "POST",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						userId : id,
						userEmail : email,
						password : pass,
					}),
					success : function(JSONData){
						alert("ȸ�������� �Ǿ����ϴ�.");
						window.close();
						top.opener.location="/user/loginForm";
					}
					})
				}
				if(idchk == false){ //DB�� ���̵� �����ϴ� ��� => �α���
					console("�α��� ���Դϴ�.")
					window.close();
					top.opener.location="/user/loginForm";
				}
			}
		})
	}
</script>
<form name=""></form>
</body>
</html>