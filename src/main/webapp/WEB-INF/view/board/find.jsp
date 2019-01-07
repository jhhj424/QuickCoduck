<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/user_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>게시판 대략적인 폼</title>

<spring:url value="/resources/css/jquery.treemenu.css" var="treecss" />

<link href="${treecss}" rel="stylesheet" type="text/css"/>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


 
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
.w3-bar .w3-button {
  padding: 12px;
  margin:5px 15px 5px 15px;
}
</style>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
</head>
<body class="w3-light-grey"id="home">

<div class="w3-top">

 <div class="w3-bar w3-card" id="myNavbar" style="background-color:rgba(255, 255, 255, 0.7);height:50%">
    <!-- 상단 아이콘-->
    <div class="w3-hide-small">
    <a href="../user/main.duck" class="w3-left w3-bar-item w3-button w3-wide"> Quick Coduck
    <img src="../workpic/QuickCoduck.jpg" class="w3-circle" style="height:23px;width:23px" alt="Avatar"></a>
    </div>
    <div class="w3-right w3-hide-small">
      <a href="../board/find.duck" class="w3-bar-item w3-button"><i class="fa fa-info"></i> 이용방법</a>
      <c:if test="${sessionScope.loginUser.type == '1'}">
      <a href="../board/list.duck?type=1" class="w3-bar-item w3-button"><i class="fa fa-search"></i> opensource 찾기</a>
      </c:if>
      <c:if test="${sessionScope.loginUser.type == '2'}">
      <a href="../board/list.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 프로젝트 찾기</a>
      </c:if>
      <a href="../board/list.duck?type=2" class="w3-bar-item w3-button"><i class="fa fa-newspaper-o"></i> 자유게시판</a>
      <a href="../user/mypage_test.duck?id=${sessionScope.loginUser.userid}" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="#contact" class="w3-bar-item w3-button"onclick="document.getElementById('signup').style.display='block'"><i class="fa fa-envelope"></i>로그인/회원가입</a>
      </c:if>
      <c:if test="${!empty sessionScope.loginUser}">
      <a href="../user/logout.duck" class="w3-bar-item w3-button"><i class="fa fa-unlock-alt"></i> 로그아웃</a>
      </c:if>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>
<div class="w3-opacity"><br>
<div class="w3-clear"></div>
<header class="w3-center w3-margin-bottom" style="margin-top:60px;">
  <h1><b>프로젝트 찾기/opensource 찾기</b></h1>
  <p><b>Quick Coduck</b></p>
</header>
</div>
<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <!-- The Grid -->
  <div class="w3-row-padding" style="margin-bottom:50px">
  
    <!-- Left Column -->
    <div class="w3-third"style="padding-right:50px;padding-left:50px;">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-container"style="padding-left:10px;">
          <br>
          <p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
          <ul class="tree">
									<li><a>Development<input type="checkbox" id="checkall_develop"></a>
										<ul>
											<li><a>C<input type="checkbox" name="usetech_develop"value="C"></a></li>
											<li><a>C++<input type="checkbox" name="usetech_develop"value="C++"></a></li>
											<li><a>Java<input type="checkbox" name="usetech_develop"value="Java"></a></li>
											<li><a>JSP<input type="checkbox" name="usetech_develop"value="JSP"></a></li>
											<li><a>Python<input type="checkbox" name="usetech_develop"value="Python"></a></li>
											<li><a>Ajax<input type="checkbox" name="usetech_develop"value="Ajax"></a></li>
											<li><a>jQuery<input type="checkbox" name="usetech_develop"value="jQuery"></a></li>
											<li><a>Ruby<input type="checkbox" name="usetech_develop"value="Ruby"></a></li>
											<li><a>Android<input type="checkbox" name="usetech_develop"value="Android"></a></li>
											<li><a>Unity<input type="checkbox" name="usetech_develop"value="Unity"></a></li>
										</ul></li>

									<li><a>Design<input type="checkbox" id="checkall_design"></a>
										<ul>
											<li><a>HTMl<input type="checkbox" name="usetech_design"value="HTMl"></a></li>
											<li><a>CSS<input type="checkbox" name="usetech_design"value="CSS"></a></li>
											<li><a>BootStrap<input type="checkbox" name="usetech_design"value="BootStrap"></a></li>
											<li><a>DreamWeaver<input type="checkbox" name="usetech_design"value="DreamWeaver"></a></li>
											<li><a>PhotoShop<input type="checkbox" name="usetech_design"value="PhotoShop"></a></li>
											<li><a>XML<input type="checkbox" name="usetech_design"value="XML"></a></li>
											<li><a>Sketch<input type="checkbox" name="usetech_design"value="Sketch"></a></li>
											<li><a>JavaScript<input type="checkbox" name="usetech_design"value="JavaScript"></a></li>
											<li><a>Unity3d<input type="checkbox" name="usetech_design"value="Unity3d"></a></li>
											<li><a>iOS<input type="checkbox" name="usetech_design"value="iOS"></a></li>
										</ul></li>

								</ul>
        
						
					</div>
      </div><br>

      
<script>
$(document).ready(function(){
    $("#checkall_develop").click(function(){
        if($("#checkall_develop").prop("checked")){
            $("input[name=usetech_develop]").prop("checked",true);
        }else{
            $("input[name=usetech_develop]").prop("checked",false);
        }
    });
    $("#checkall_design").click(function(){
        if($("#checkall_design").prop("checked")){
            $("input[name=usetech_design]").prop("checked",true);
        }else{
            $("input[name=usetech_design]").prop("checked",false);
        }
    });
<%--    
    $("#checkbox").click(function() {

		$("input[name=usetech_develop]:checked").each(function() {

			var test = $(this).val();

			console.log(test);

		});

	});
	--%>
})
</script>

				<!-- End Left Column -->
    </div>

    <!-- Right Column -->
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Work Experience</h2>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Front End Developer / w3schools.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jan 2015 - <span class="w3-tag w3-teal w3-round">Current</span></h6>
          <p>Lorem ipsum dolor sit amet. Praesentium magnam consectetur vel in deserunt aspernatur est reprehenderit sunt hic. Nulla tempora soluta ea et odio, unde doloremque repellendus iure, iste.</p>
          <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Web Developer / something.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Mar 2012 - Dec 2014</h6>
          <p>Consectetur adipisicing elit. Praesentium magnam consectetur vel in deserunt aspernatur est reprehenderit sunt hic. Nulla tempora soluta ea et odio, unde doloremque repellendus iure, iste.</p>
          <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Graphic Designer / designsomething.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jun 2010 - Mar 2012</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p><br>
              <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Graphic Designer / designsomething.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jun 2010 - Mar 2012</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p><br>
              <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Graphic Designer / designsomething.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jun 2010 - Mar 2012</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p><br>
              <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>Graphic Designer / designsomething.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jun 2010 - Mar 2012</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p><br>
              <hr>
        </div>
      </div>

    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

<!-- Footer -->
<footer class="w3-center w3-black w3-padding-32">
  <div class="w3-xlarge w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i><br>
  </div>
  <p>Quick Coduck<a href="#home"class="w3-hover-text-green">  <i class="fa fa-arrow-up w3-margin-right">Up to top</i></a></p>
</footer>


</body>
</html>
