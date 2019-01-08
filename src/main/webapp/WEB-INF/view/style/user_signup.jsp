<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	
    'use strict';

    var usernameError = true,
        emailError    = true,
        passwordError = true,
        passConfirm   = true;

    // Label effect
    $('input').focus(function () {

        $(this).siblings('label').addClass('active');
    });
    
    //id valued check
    $("#user_id").keydown(function(){
    		var userid = $("#user_id").val()
    		var data = {
    			"userid" : userid
    		}
    		$.ajax({
    			url : "user_idchk.duck",
    			type: "post",
    			data: data,
    			dataType: "json",
    			success: function(data){
    				
    			if(data.id_chk == 0){
    				 $(".name").siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasError');
   					 $(".name").siblings('span.error').text('').fadeIn().parent('.form-group').addClass('hasCor');
   		                usernameError = false;	
   				}else if(data.id_chk == 1){
    				 $(".name").siblings('span.error').text('중복입니다.').fadeIn().parent('.form-group').removeClass('hasCor');
    				 $(".name").siblings('span.error').text('중복입니다.').fadeIn().parent('.form-group').addClass('hasError');
    		            usernameError = true;
    			}else if(data.id_chk == 2){
    				$(".name").siblings('span.error').text('중복입니다.').fadeIn().parent('.form-group').removeClass('hasCor');
    				$(".name").siblings('span.error').text('3자 이상 10자 이하입니다').fadeIn().parent('.form-group').addClass('hasError');
    				    usernameError = true;
    			}else if(data.id_chk == 3){
    				$(".name").siblings('span.error').text('중복입니다.').fadeIn().parent('.form-group').removeClass('hasCor');
    				$(".name").siblings('span.error').text('필수입력 입니다').fadeIn().parent('.form-group').addClass('hasError');
				        usernameError = true;
				        alert(data.id_chk);
			}
    				
    			},
    			error: function(xhr,status,error){
    				alert("서버오류 : "+xhr.status + ", error : "+error + ", status : "+status);
    			}
    		})
    });

    // Form validation
    $('input').blur(function () {

        // User Name
        if ($(this).hasClass('name')) {
            if ($(this).val().length === 0) {
                $(this).siblings('span.error').text('필수입력 입니다').fadeIn().parent('.form-group').addClass('hasError');
                usernameError = true;
            }
        }
        // Email
        if ($(this).hasClass('email')) {
            if ($(this).val().length == '') {
                $(this).siblings('span.error').text('필수입력 입니다').fadeIn().parent('.form-group').addClass('hasError');
                emailError = true;
            } else {
            	$(this).siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasError');
                $(this).siblings('span.error').text('').fadeOut().parent('.form-group').addClass('hasCor');
                emailError = false;
            }
        }

        // PassWord
        if ($(this).hasClass('pass')) {
            if ($(this).val().length == 0) {
            	$(this).siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasCor');
                $(this).siblings('span.error').text('필수입력 입니다').fadeIn().parent('.form-group').addClass('hasError');
                passwordError = true;
            }else if($('.pass').val().length <4 || $('.pass').val().length >12){
            	$(this).siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasCor');
                $(this).siblings('span.error').text('4자 이상 12자 이하만 가능합니다').fadeIn().parent('.form-group').addClass('hasError');
                passwordError = true;
            }else {
            	$(this).siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasError');
                $(this).siblings('span.error').text('').fadeOut().parent('.form-group').addClass('hasCor');
                passwordError = false;
            }
        }

        // PassWord confirmation
        if ($('.pass').val() !== $('.passConfirm').val() || $('.passConfirm').val() == '') {
        	$('.passConfirm').siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasCor');
            $('.passConfirm').siblings('span.error').text('비밀번호가 일치하지 않습니다').fadeIn().parent('.form-group').addClass('hasError');
            passConfirm = false;
        } else {
        	$('.passConfirm').siblings('span.error').text('').fadeIn().parent('.form-group').removeClass('hasError');
            $('.passConfirm').siblings('span.error').text('').fadeOut().parent('.form-group').addClass('hasCor');
            passConfirm = false;
        }

        // label effect
        if ($(this).val().length > 0) {
            $(this).siblings('label').addClass('active');
        } else {
            $(this).siblings('label').removeClass('active');
        }
    });


    // form switch
    $('a.switch').click(function (e) {
        $(this).toggleClass('active');
        e.preventDefault();

        if ($('a.switch').hasClass('active')) {
            $(this).parents('.form-peice').addClass('switched').siblings('.form-peice').removeClass('switched');
        } else {
            $(this).parents('.form-peice').removeClass('switched').siblings('.form-peice').addClass('switched');
        }
    });

    // Form submit
    $('form.signup-form').submit(function (event) {

        if (usernameError == true || emailError == true || passwordError == true || passConfirm == true) {
            $('.name, .email, .pass, .passConfirm').blur();
            return event.preventDefault();
        }else if(usernameError == false && emailError == false && passwordError == false && passConfirm == false){
        	return event;
        }
    });  

});
</script>
</head>
</html>