<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���̹� �ݹ� ������</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<!-- LoginWithBaverId Javscript SDK -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<!-- LoginWithBaverId Javscript ���� ���� �� �ʱ�ȭ -->
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "{hZgcybLLosz6OTLjGrZm}", //Ŭ���̾�Ʈ ID
		callbackUrl : "{http://localhost:8080/quickcoduck/user/main.duck}", //�ݹ� URL
		isPopup : true, //�ľ��� ���� ����ó�� ����
		callbackHandle: true
		/* callback �������� �и��Ǿ��� ��쿡 callback ������������ callbackó���� ���ټ� �ֵ��� ���� */
	});
	// �׾Ʒ� �α��� ������ �ʱ�ȭ�ϱ� ���� init ȣ��
	naverLogin.init();
	// Callback ó��. ���������� callback ó���� �Ϸ�� ��� main page�� redirect or �˾�â ����
	window.addEventListener('load', function(){
		naverLogin.getLoginStatus(function (status){
			if(status){
				//�ʼ������� �޾ƾ��ϴ� ������ ������ �ִٸ� callbackó�� ������ üũ
				var email = naverLogin.user.getEmail();
				if(email == undefined || email == null){
					alert("�̸��� ������ �ʼ��Դϴ�. ���������� ������ �ּ���.")
					naverLogin.reprompt();
					return;
				}
				window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/user/login.jsp");
			} else {
				console.log("callback ó�� ����")
			}
		});
	});
</script>
</body>
</html>