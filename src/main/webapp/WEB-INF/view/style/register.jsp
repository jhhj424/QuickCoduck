<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#user_id").keydown(
						function() {
							var userid = $("#user_id").val()
							var userEmail = $("#user_email").val()
							var data = {
									"userid" : userid,
									"email" : userEmail,
									"pass" : " ",
									"pass2" : " "
							}
							$.ajax({
								url : "signup_test.duck",
								type:"post",
								data:data,
								dataType : "json",
								success : function(data){
									$(".id_chk").text(data.id_chk)
								},
								error : function(xhr, status, error){
									alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
								}
							})
						})
						
						$("#user_password2").keydown(
						function() {
							var password = $("#user_password").val()
							var chkpass = $("#user_password2").val()
							var data = {
									"pass" : password,
									"pass2" : chkpass,
									"userid" : " ",
									"email" : " "
							}
							$.ajax({
								url : "signup_test.duck",
								type:"post",
								data:data,
								dataType : "json",
								success : function(data){
									$(".corpass_chk").text(data.corpass_chk);
								},
								error : function(xhr, status, error){
									alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
								}
							})
						})
						$("#client_id").keydown(
						function() {
							var userid = $("#client_id").val()
							var userEmail = $("#client_email").val()
							var data = {
									"userid" : userid,
									"email" : userEmail,
									"pass" : " ",
									"pass2" : " "
							}
							$.ajax({
								url : "signup_test.duck",
								type:"post",
								data:data,
								dataType : "json",
								success : function(data){
									$(".cid_chk").text(data.id_chk)
								},
								error : function(xhr, status, error){
									alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
								}
							})
						})
						
						$("#client_password2").keydown(
						function() {
							var password = $("#client_password").val()
							var chkpass = $("#client_password2").val()
							var data = {
									"pass" : password,
									"pass2" : chkpass,
									"userid" : " ",
									"email" : " "
							}
							$.ajax({
								url : "signup_test.duck",
								type:"post",
								data:data,
								dataType : "json",
								success : function(data){
									$(".pass_chk").text(data.corpass_chk);
								},
								error : function(xhr, status, error){
									alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
								}
							})
						})
			})
</script>
</head>
