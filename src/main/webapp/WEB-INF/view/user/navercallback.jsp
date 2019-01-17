<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>네이버 콜백 페이지</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<!-- LoginWithBaverId Javscript SDK -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<!-- LoginWithBaverId Javscript 설정 정보 및 초기화 -->
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "{hZgcybLLosz6OTLjGrZm}", //클라이언트 ID
		callbackUrl : "{http://localhost:8080/quickcoduck/user/main.duck}", //콜백 URL
		isPopup : true, //파업을 통한 연동처리 여부
		callbackHandle: true
		/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정 */
	});
	// 네아로 로그인 정보를 초기화하기 위한 init 호출
	naverLogin.init();
	// Callback 처리. 정상적으로 callback 처리가 완료될 경우 main page로 redirect or 팝업창 종료
	window.addEventListener('load', function(){
		naverLogin.getLoginStatus(function (status){
			if(status){
				//필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시정에 체크
				var email = naverLogin.user.getEmail();
				if(email == undefined || email == null){
					alert("이메일 정보는 필수입니다. 정보제공을 동의해 주세요.")
					naverLogin.reprompt();
					return;
				}
				window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/user/login.jsp");
			} else {
				console.log("callback 처리 실패")
			}
		});
	});
</script>
</body>
</html>