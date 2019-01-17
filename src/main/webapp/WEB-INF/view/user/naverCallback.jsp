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
	// 접근 토큰 값 출력
	alert(naver_id_login.oauthParams.access_token);
	
	//네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	//네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
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
				if(idchk == true){ //DB에 아이디가 없을 경우 => 회원가입
					console.log("회원 가입 중입니다.");
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
						alert("회원가입이 되었습니다.");
						window.close();
						top.opener.location="/user/loginForm";
					}
					})
				}
				if(idchk == false){ //DB에 아이디가 존재하는 경우 => 로그인
					console("로그인 중입니다.")
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