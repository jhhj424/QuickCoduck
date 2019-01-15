<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var starClicked = false;
$(document).ready(function () {
  $('.star').click(function() {//클릭 했을때 속성 추가해서 별 색갈 바꿔주기

    $(this).children('.selected').addClass('is-animated');
    $(this).children('.selected').addClass('pulse');

    var target = this;

    setTimeout(function() {
      $(target).children('.selected').removeClass('is-animated');
      $(target).children('.selected').removeClass('pulse');
    }, 1000);

    starClicked = true;
  })

  $('.half').click(function() {//반개짜리 클릭시 반개 점수 가져오기
    if (starClicked == true) {
      setHalfStarState(this)
    }
 
    
    $(this).closest('.rating1').find('.js-score').text($(this).data('value'));
    $(this).closest('.rating1').data('vote', $(this).data('value'));
    $(this).closest('.rating2').find('.js-score').text($(this).data('value'));
    $(this).closest('.rating2').data('vote', $(this).data('value'));
    $(this).closest('.rating3').find('.js-score').text($(this).data('value'));
    $(this).closest('.rating3').data('vote', $(this).data('value'));
    $(this).closest('.rating4').find('.js-score').text($(this).data('value'));
    $(this).closest('.rating4').data('vote', $(this).data('value'));
    $(this).closest('.rating5').find('.js-score').text($(this).data('value'));
    $(this).closest('.rating5').data('vote', $(this).data('value'));
    
    console.log($(this).data('value'));
    calculateAverage()
    console.log(parseInt($(this).data('value')));

  })

  $('.full').click(function() {//전체 클릭시 전체 점수 가져오기
    if (starClicked == true) {
      setFullStarState(this)
    }
    $(this).closest('.rating1').find('.js-score').text($(this).data('value'));
    $(this).find('js-average').text(parseInt($(this).data('value')));
    $(this).closest('.rating1').data('vote', $(this).data('value'));
    
    $(this).closest('.rating2').find('.js-score').text($(this).data('value'));
    $(this).find('js-average').text(parseInt($(this).data('value')));
    $(this).closest('.rating2').data('vote', $(this).data('value'));
    
    $(this).closest('.rating3').find('.js-score').text($(this).data('value'));
    $(this).find('js-average').text(parseInt($(this).data('value')));
    $(this).closest('.rating3').data('vote', $(this).data('value'));
    
    $(this).closest('.rating4').find('.js-score').text($(this).data('value'));
    $(this).find('js-average').text(parseInt($(this).data('value')));
    $(this).closest('.rating4').data('vote', $(this).data('value'));
    
    $(this).closest('.rating5').find('.js-score').text($(this).data('value'));
    $(this).find('js-average').text(parseInt($(this).data('value')));
    $(this).closest('.rating5').data('vote', $(this).data('value'));
    
    console.log($(this).data('value'));
    calculateAverage()

    console.log(parseInt($(this).data('value')));
  })



function updateStarState(target) {//animation 부분
  $(target).parent().prevAll().addClass('animate');
  $(target).parent().prevAll().children().addClass('star-colour');

  $(target).parent().nextAll().removeClass('animate');
  $(target).parent().nextAll().children().removeClass('star-colour');
}

function setHalfStarState(target) {//half-animation 부분
  $(target).addClass('star-colour');
  $(target).siblings('.full').removeClass('star-colour');
  updateStarState(target)
}

function setFullStarState(target) {//full-animation 부분
  $(target).addClass('star-colour');
  $(target).parent().addClass('animate');
  $(target).siblings('.half').addClass('star-colour');

  updateStarState(target)
}

function calculateAverage() {
  var average = 0
  var profess = 0;
  var proaction = 0;
  var prosatisfact = 0;
  var prodate = 0;
  var procommunicate = 0;

  $('.rating1').each(function() {
    average += $(this).data('vote')
    profess += $(this).data('vote')
  })
  $('.rating2').each(function() {
    average += $(this).data('vote')
    proaction += $(this).data('vote')
  })
  $('.rating3').each(function() {
    average += $(this).data('vote')
    prosatisfact += $(this).data('vote')
  })
  $('.rating4').each(function() {
    average += $(this).data('vote')
    prodate += $(this).data('vote')
  })
  $('.rating5').each(function() {
    average += $(this).data('vote')
    procommunicate += $(this).data('vote')
  })

  $('.js-average').text((average/ 5).toFixed(1))
}
$('#btn').click(function(e){
	alert("클릭")
	var rating1 = $('.rating1').data('vote');
	var rating2 = $('.rating2').data('vote');
	var rating3 = $('.rating3').data('vote');
	var rating4 = $('.rating4').data('vote');
	var rating5 = $('.rating5').data('vote');
	console.log(rating1)
	console.log(rating2)
	console.log(rating3)
	console.log(rating4)
	console.log(rating5)
	$('#rt1').val(rating1);
	$('#rt2').val(rating2);
	$('#rt3').val(rating3);
	$('#rt4').val(rating4);
	$('#rt5').val(rating5);
	if(rating1 == 0 || rating2 == 0 || rating3 == 0 || rating4 == 0 || rating5 == 0){
		alert("조건")
		return e.preventDefault();
	}else{
		return e;
	}
})
});
</script>
</head>
</html>