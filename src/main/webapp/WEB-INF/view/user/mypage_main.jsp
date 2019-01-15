<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/style/mypage_star_rating_css.jsp" %>
<%@ include file="/WEB-INF/view/style/mypage_star_rating_js.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

</script>
</head>
<body>
<form action="#" method="post" name="f">
<div class="rating1" data-vote="0">
  <div class="star hidden">
    <span class="full"data-value="0"></span>
    <span class="half"data-value="0"></span>
  </div>
  <div class="star">
    <span class="full" data-value="1"></span>
    <span class="half" data-value="0.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="2"></span>
    <span class="half" data-value="1.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="3"></span>
    <span class="half" data-value="2.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="4"></span>
    <span class="half" data-value="3.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="5"></span>
    <span class="half" data-value="4.5"></span>
    <span class="selected"></span>
  </div>
  <div class="score">
    <span>전문성</span>&nbsp;&nbsp;
    <span class="score-rating js-score">0</span>
    <span>/</span>
    <span class="total">5</span>
  </div>
</div>
    
  <div class="rating2" data-vote="0">
  <div class="star hidden">
    <span class="full"data-value="0"></span>
    <span class="half"data-value="0"></span>
  </div>
  <div class="star">
    <span class="full" data-value="1"></span>
    <span class="half" data-value="0.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="2"></span>
    <span class="half" data-value="1.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="3"></span>
    <span class="half" data-value="2.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="4"></span>
    <span class="half" data-value="3.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="5"></span>
    <span class="half" data-value="4.5"></span>
    <span class="selected"></span>
  </div>
  <div class="score">
    <span>적극성</span>&nbsp;&nbsp;
    <span class="score-rating js-score">0</span>
    <span>/</span>
    <span class="total">5</span>
  </div>
</div>
<div class="rating3"  data-vote="0" >
  <div class="star hidden">
    <span class="full"data-value="0"></span>
    <span class="half"data-value="0"></span>
  </div>
  <div class="star">
    <span class="full" data-value="1"></span>
    <span class="half" data-value="0.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="2"></span>
    <span class="half" data-value="1.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="3"></span>
    <span class="half" data-value="2.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="4"></span>
    <span class="half" data-value="3.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="5"></span>
    <span class="half" data-value="4.5"></span>
    <span class="selected"></span>
  </div>
  <div class="score">
    <span>만족도</span>&nbsp;&nbsp;
    <span class="score-rating js-score">0</span>
    <span>/</span>
    <span class="total">5</span>
  </div>
</div>
  <div class="rating4"  data-vote="0">
  <div class="star hidden">
    <span class="full"data-value="0"></span>
    <span class="half"data-value="0"></span>
  </div>
  <div class="star">
    <span class="full" data-value="1"></span>
    <span class="half" data-value="0.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="2"></span>
    <span class="half" data-value="1.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="3"></span>
    <span class="half" data-value="2.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="4"></span>
    <span class="half" data-value="3.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="5"></span>
    <span class="half" data-value="4.5"></span>
    <span class="selected"></span>
  </div>
  <div class="score">
    <span>일정준수</span>&nbsp;&nbsp;
    <span class="score-rating js-score">0</span>
    <span>/</span>
    <span class="total">5</span>
  </div>
</div>

  <div class="rating5"  data-vote="0">
  <div class="star hidden">
    <span class="full"data-value="0"></span>
    <span class="half"data-value="0"></span>
  </div>
  <div class="star">
    <span class="full" data-value="1"></span>
    <span class="half" data-value="0.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="2"></span>
    <span class="half" data-value="1.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="3"></span>
    <span class="half" data-value="2.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="4"></span>
    <span class="half" data-value="3.5"></span>
    <span class="selected"></span>
  </div>
  <div class="star">
    <span class="full" data-value="5"></span>
    <span class="half" data-value="4.5"></span>
    <span class="selected"></span>
  </div>
  <div class="score">
    <span>의사소통</span>&nbsp;&nbsp;
    <span class="score-rating js-score">0</span>
    <span>/</span>
    <span class="total">5</span>
  </div>
</div>

<div class="average">
  <span class="text">Your average score is</span><div class=" score-average js-average"></div>
</div>
<input type="submit" id="btn" value="시발">
<input type="hidden" value="" id="rt1" name="profess">
<input type="hidden" value="" id="rt2" name="proaction">
<input type="hidden" value="" id="rt3" name="prosatisfact">
<input type="hidden" value="" id="rt4" name="prodate">
<input type="hidden" value="" id="rt5" name="procommunicate">
</form>
</body>
</html>