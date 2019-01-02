<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title><decorator:title /></title>

<script>
   jQuery(function($) {
      var tgC = $('.tg_cnt');
      $('.tg_btn').click(
            function() {
               var t = $(this);
               var h = t.attr('href');
               if (t.next(h).is(':visible')) {
                  t.focus().next().fadeOut(200);
               } else {
                  tgC.filter(':visible').hide();
                  t.next().fadeIn(200).find(
                        'a,input#uid,button:not(.tg_blur)').eq(0)
                        .focus();
               }
               ;
               return false;
            });
      function tgClose() {
         var closeId = tgC.filter(':visible').attr('id');
         tgC.fadeOut(200).prev('[href="#' + closeId + '"]').focus();
      }
      ;
      $(document).keydown(function(event) {
         if (event.keyCode != 27)
            return true; // ESC
         return tgClose();
      });
      $('.tg_blur').focusin(tgClose);
      $('.tg_close,#install_ng .close').click(tgClose);
   });
</script>
<!-- 태그 -->
<style>
   div {
    display: block;
}
   body {
    font-size: 13px;
    margin: 0px 0px;
    letter-spacing: 0.2px;
}
   body, input, textarea, select, button, table {
    font-family: NanumGothic,'Segoe UI',Meiryo,'Trebuchet MS','나눔고딕',NanumGothic,ng,'맑은 고딕','Malgun Gothic','돋움',Dotum,AppleGothic,sans-serif;
    line-height: 1.5;
}
   body {
    position: relative;
    word-wrap: break-word;
}
   a.skipToContent {
    display: block;
    position: absolute;
    top: -1px;
    width: 100%;
    height: 1px;
    overflow: hidden;
    text-align: center;
}
   a {
    text-decoration: none;
    color: #313131;
}
   a:-webkit-any-link {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: underline;
}
   ul, menu, dir {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}
   li {
    list-style: none;
    display: list-item;
    text-align: -webkit-match-parent;
}
   a img {
    border: 0;
}
   ul {
    margin: 0;
    padding: 0;
}
   ol ul, ul ol, ul ul, ol ol {
    margin-block-start: 0px;
    margin-block-end: 0px;
}
   ul ul, ol ul {
    list-style-type: circle;
}
   h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
   form {
    display: block;
    margin-top: 0em;
}
   fieldset {
    display: block;
    margin-inline-start: 2px;
    margin-inline-end: 2px;
    padding-block-start: 0.35em;
    padding-inline-start: 0.75em;
    padding-inline-end: 0.75em;
    padding-block-end: 0.625em;
    min-inline-size: min-content;
    border-width: 2px;
    border-style: groove;
    border-color: threedface;
    border-image: initial;
}
   label {
    cursor: default;
}
</style>
<!-- 아이디 -->
<style>
   #top_h_left {
    position: absolute;
    z-index: 9999;
    list-style: none;
    margin: 0;
    padding: 3px 0px;
    border-top: 0px solid #444;
    left: 23px;
    top: 8px;
}
   #top_h_left .item {
    display: inline-block;
    margin: 0 -1px;
    
}
   #top_h_left a {
    color: #000;
}
   #gnb_wrp {
    z-index: 1500;
}
   #gnb_wrp {
    z-index: 10;
    height: 60px; /*수정한거30->50*/
    border-top: 0px solid #444;
    border-bottom: 0px solid #444;
    background: url(../img/gnb_wrp.png)\9;
    background: #1D1D1D;
    margin: 0 0 5px;
    text-align: center;
    padding: 10px;
}
   #menu {
    width: 1200px;
    padding-left: 0px;
    padding-top: 8px;
    float: none;
    color: #6B6B6B;
}
   #menu {
    font-family: 'Economica', sans-serif !important;
    margin: 0px;
    /* padding: 0px; */
    list-style: none;
    color: #505050;
    line-height: 1;
    display: inline-block;
    z-index: 10;
    width: 1300px;
    float: center;
}
   #menu>li {
    padding: 1px 22px 30px;
    text-decoration: none;
    font-weight: bold;
    letter-spacing: 2px;
}
   #menu > li {
    font-family: 'HelveticaNeue' !important;
    background: 0;
    cursor: pointer;
    float: none;
    position: relative;
    padding: 1px 16px;
    display: inline;
    font-size: 13px;
}
   #menu li ul {
    position: absolute;
    left: 6px;
    top: 0px;
    margin-top: 20px;
    width: 140px;
    line-height: 16px;
    background-color: #1D1D1D;
    color: #fff;
    display: none;
    letter-spacing: 0.1px;
    border: 0px solid #908F83;
    margin: 0px;
    text-align: left;
}
   #help {
    z-index: 200;
}
   #menu li ul li:first-child {
    border-top: none;
}
   #menu li ul li {
    display: block;
    margin: 5px 15px;
    padding: 7px 0 7px;
    /* border-top: dotted 1px #606060; */
    list-style-type: none;
    font-size: 13px;
}
   #menu li ul li a {
    display: block;
    color: #fff;
    font-family: 'Noto Sans KR';
    font-weight: 400;
    font-size: 13px;
}
   #menu a {
    color: #fff;
    text-decoration: none;
    font-weight: bold;
}
   #top_h {
    top: 11px;
}
   #top_h {
    position: absolute;
    z-index: 999;
    list-style: none;
    margin: 0;
    padding: 0px 0px;
    border-top: 0px solid #444;
    right: 27px;
    top: 13px;
}
   #top_h .item {
    display: inline-block;
    margin: 0 -1px;
    *display: inline;
    *zoom: 1;
}
   #top_h .tg_btn, #top_h .login_h, #top_h .sitemap {
    border: 0;
    font-family: 'HelveticaNeue' !important;
    font-weight: 600;
    letter-spacing: 0px;
    padding: 4px 8px;
    font-size: 12px;
    background: 0;
    color: #C0C0C0;
    line-height: 17px;
}
   #site_login {
        width: 280px;/*수정한거 246->280*/
}
   #install_ng, #site_login, #profile {
    padding: 25px;
    border: 2px solid #444;
    -webkit-box-shadow: 0 0 6px rgba(0, 0, 0, .1);
    box-shadow: 0 0 6px rgba(0, 0, 0, .1);
}
   #top_h h2 {
    margin: 0 0 16px;
    font-size: 23px;
    line-height: 1em;
    font-family: 'noto sans kr';
    color: #000;
}
   #top_h h2 {
    margin: 0 0 16px;
    font-size: 15px;
    line-height: 1em;
}
   #site_login fieldset {
    position: relative;
    margin: 0;
    padding: 0;
    border: 0;
    *margin: -15px 0;
}
   #site_login .itx_wrp {
    position: relative;
    display: block;
    margin: 12px 0;
    line-height: 20px;
}
   #site_login .itx_wrp label {
    position: absolute;
    top: 8px;
    left: 8px;
    font-size: 13px;
}
   #site_login .itx {
    width: 224px;
    height: 35px; /*수정한거20->35*/
    padding: 8px;
    font-size: 16px;
    background: #F6F6F6;
    border-width: 1px;
    border-style: solid;
    border-color: #AAA #CCC #CCC #AAA;
    border-radius: 3px;
    -webkit-box-shadow: inset 1px 1px 2px rgba(0, 0, 0, .1);
    box-shadow: inset 1px 1px 2px rgba(0, 0, 0, .1);
    filter: alpha(opacity: 60);
    opacity: .6;
    -ms-transition: all .5s;
    -moz-transition: all .5s;
    -webkit-transition: all .5s;
    transition: all .5s;
}
   #site_login .btn_area {
    text-align: right;
}
   #site_login .btn_area {
    text-align: right;
}
   #install_ng a, #site_login .login_btn, .close_ul2 {
    width: 80px;
    height: 30px;
    border-width: 1px;
    border-style: solid;
    border-color: #DDD #CCC #BBB #D6D6D6;
    border-radius: 3px;
    background: #F9F9F9 url(../img/bg_f_f9.gif) repeat-x;
    background: -moz-linear-gradient(top, #FFF, #F9F9F9);
    background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#FFF), to(#F9F9F9));
    font-weight: bold;
    line-height: 30px;
    cursor: pointer;
    letter-spacing: -1px;
    text-align: center;
    box-shadow: 0 1px 1px rgba(0, 0, 0, .1);
    color: #000;
}
   #site_login .help {
    clear: both;
    margin: 15px -15px -5px;
    text-align: center;
    letter-spacing: -1px;
    color: #DDD;
}
   #site_login .help a {
    padding: 0 5px;
    font-size: 11px;
    color: #666;
}
   #gnb {
    float: left;
    margin: 0 10px;
    padding: 0;
}
   #footer {
    border: 0;
    margin-top: 100px;
    padding: 100px 36px 0;
    height: 260px;
}
   #footer {
    background: #1C1C1C;
    border-top: 2px solid #999;
    bottom: 0;
    color: #4E4E4E;
    font-family: 'proxima-nova-n4', 'proxima-nova', sans-serif;
    font-style: normal;
    font-size: 11px;
    left: 0;
    height: 240px;
    text-align: center;
    margin: 0 auto;
    padding: 60px 36px 0;
    max-width: 928px;
    min-width: 928px;
}
   #footer_w {
    margin: 0 auto;
}
   #footer_link {
    font-family: 'noto sans kr', sans-serif;
    font-weight: 300;
    font-size: 14px;
}
   #footer_link a {
    color: #8A8A8A;
}
   #footer_copy {
    margin-top: 15px;
    font-weight: bold;
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    color: #666;
    letter-spacing: 0.1px;
    text-align: center;
}
</style>
<!-- 클래스 -->
<style>
   .clear {
    display: block;
    position: relative;
    clear: both;
    zoom: 1;
}
   .clear:after {
    content: "";
    display: block;
    clear: both;
}
   .fr {
    float: right;
}
   .sub_logo {
    float: left;
    width: 25%;
    left: 190px;
    position: fixed;
    top: 15px;
    left: 15px;
    text-align: right;
}
   .tg_cnt {
    display: none;
    position: absolute;
    top: 26px;
    right: 6px;
    background-color: #FFF;
    white-space: nowrap;
}
   .tg_blur {
    position: absolute;
    top: 0;
    right: 0;
    border: 0;
    background: none;
    width: 1px;
    height: 1px;
    overflow: hidden;
}
   .tg_close {
    position: absolute;
    cursor: pointer;
    border: 0;
    top: 0;
    right: 0;
    width: 24px;
    height: 24px;
    font: 18px/24px Tahoma;
    color: #888;
    background: transparent;
}
   .row-fluid .span4 {
    width: 99.5%;
    text-align: center;
    border-top: 0px dotted #4E4E4E;
    padding: 3px 0 0 0;
    margin: 54px 0 5px 0;
    color: #666;
    text-align: center;
}
   .row-fluid [class*="span"] {
    -moz-box-sizing: border-box;
    display: block;
    float: left;
    min-height: 30px;
}
   .copyright_name {
    color: #CCC;
    font-weight: bold;
    letter-spacing: 0.1px;
}



   .hp-container {
    position: relative;
    width: 1200px;
    margin: 0 auto;
    background-color: #fff;
}
   .ec #container, .ece #container {
    padding-left: 140px;
}
   .ece #content {
    max-width: 840px;
}
</style>
<!-- 그외 -->
<style>
   @media screen and (max-width: 533px){
   #hd2 {
       padding-top: 0 !important;
    }
}
   img[Attributes Style] {
    width: 150px;
}
   @media only screen and (max-width: 1190px){
   #gnb_wrp {
       height: auto;
    }
}
   @media screen and (max-width: 533px){
   #gnb_wrp {
    position: relative !important;
    width: auto !important;
    height: auto;
    max-height: 46px;
    margin-bottom: 10px;
    }
}
   @media only screen and (max-width: 1190px){
   #menu {
    width: 100%;
    margin-top: 36px;
    border-top: 1px solid #666;
    padding: 12px 16px 0 0;
    margin-left: -16px;
    }
}
   @media only screen and (max-width: 1300px){
   #menu {
    padding-top: 10px;
    }
}
   @media only screen and (max-width: 1190px){
   #menu>li {
    font-size: 0.9em;
    padding: 1px 0px 15px 16px;
    }
}
   @media only screen and (max-width: 1300px){
   #menu>li {
    padding: 1px 0px 30px 10px;
    font-size: 1em;
    letter-spacing: 1px;
}
   @media only screen and (max-width: 1550px){
   #menu>li {
    padding: 1px 0px 30px 20px;
    }
}
   @media screen and (max-width: 533px){
   #top_h {
    float: none;
    border-bottom: 1px solid #DDD;
    background: #F9F9F9 url(../img/bg_f_f9.gif) repeat-x;
    background: -moz-linear-gradient(top, #FFF, #F9F9F9);
    background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#FFF), to(#F9F9F9));
    text-align: center;
    }
}
   @media screen and (max-width: 533px){
   #top_h .item {
    margin: 2px 0;
    width: 24%;
    }
}
   @media screen and (max-width: 533px){
   #top_h .tg_btn, #top_h .login_btn, #top_h .sitemap {
    font-size: 12px;
    }
}
   @media screen and (max-width: 240px){
   #site_login {
    padding: 15px;
    width: 186px;
    }
}
   @media screen and (max-width: 240px){
   .tg_cnt {
    white-space: normal;
    }
}
   @media screen and (max-width: 533px){
   #gnb {
    float: none;
    }
}
</style>
<decorator:head />
<body>
<div id="all" class="ece">
 <div id="hp-container" style="width:100%">
 <!-- 헤더 -->
  <div id="hd2" class="clear">
   <a href="#content" class="skipToContent" onclick="jQuery('#content a:first').focus();return false">
   Skip to content</a>
   <ul id="top_h_left" class="">
    <li class="item">
     <div class="sub_logo">
      <a href="${path}/decorator/hiphop_home.jsp">
      <img src="${path}/decorator/img/123123.png" width="150">
      </a>
     </div>
    </li>
   </ul>
   
   <div id="gnb_wrp" class="clear" style="position: fixed; width: 100%;">
    <ul id="menu">
     <div class="w3-dropdown-hover">
  <button class="w3-black w3-button">Lable</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-black">H1yer Music</a>
    <a href="#" class="w3-bar-item w3-button w3-black">Indgo Music</a>
    <a href="#" class="w3-bar-item w3-button w3-black">HiLite</a>
  </div>
  </div>
  <div class="w3-dropdown-hover">
  <button class="w3-black w3-button">Arties</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="${path}/model2/board/artist.art" class="w3-bar-item w3-button w3-black">스웨이디</a>
    <a href="${path}/model2/board/artist.art" class="w3-bar-item w3-button w3-black">나플라</a>
    <a href="${path}/model2/board/artist.art" class="w3-bar-item w3-button w3-black">루피</a>
  </div>
  </div>
  <div class="w3-dropdown-hover">
  <button class="w3-black w3-button">Album</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">스웨이디</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">나플라</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">루피</a>
  </div>
</div>
<div class="w3-dropdown-hover">
  <button class="w3-black w3-button">Music</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="${path}/model2/board/music.mu" class="w3-bar-item w3-button w3-black">Interview</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">MV</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">MICSWAGGER</a>
  </div>
</div>
<%-- <div class="w3-dropdown-hover">
  <button class="w3-black w3-button">Video(미구현)</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="${path}/model2/board/music.mu" class="w3-bar-item w3-button w3-black">Interview</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">MV</a>
    <a href="${path}/model2/board/album.al" class="w3-bar-item w3-button w3-black">MICSWAGGER</a>
  </div>
</div> --%>
<div class="w3-dropdown-hover">
  <button class="w3-black w3-button">게시판</button>
  <div class="w3-dropdown-content w3-bar-block">
    <a href="${path}/model2/board/list.bo" class="w3-bar-item w3-button w3-black">자유게시판</a>
    <a href="${path}/model2/board/list.bo" class="w3-bar-item w3-button w3-black">일반</a>
    <a href="${path}/model2/board/list.bo" class="w3-bar-item w3-button w3-black">리뷰</a>
  </div>
</div>
     
    </ul>
    <ul id="top_h" class="">
     <li class="item">
     <c:if test="${empty sessionScope.login}">
     <!-- 모달 링크 부분 -->
     <a href="#site_login" class="tg_btn">Login</a>
     </c:if>
     <c:if test="${!empty sessionScope.login }">
     ${sessionScope.login} | <a href="${path}/model2/member/logout.me">로그아웃</a>
    </c:if>
    <!-- modal창 부분 -->
     <div id="site_login" class="tg_cnt">
      <button type="button" class="tg_blur"></button>
       <h2>로그인</h2>
       <script>
      function logincheck(f){
         if(f.id.value==""){
            alert('아이디를 입력하세요');
            f.id.focus
            return false;
         }   
         if(f.pass.value==""){
            alert('비밀번호를 입력하세요');
            f.pass.focus
            return false;
         }
      }
      </script>
        <form action="${path}/model2/member/login.me" method="post" onsubmit="return logincheck(this)">
         <input type="hidden" name="error_return_url" value="/" />
         <input type="hidden" name="mid" value="main" />
         <input type="hidden" name="vid" value="" />
         <input type="hidden" name="ruleset" value="@login" />
         <fieldset>
          <input type="hidden" name="act" value="procMemberLogin" />
          <input type="hidden" name="success_return_url" value="/" />
         <div class="itx_wrp">
          <span class="itx_wrp">
          <label for="uid">아이디</label>
           <input type="text" name="id" id="uid" value="" class="itx" />
          </span>
          <span class="itx_wrp">
           <label for="upw">비밀번호</label>
            <input type="password" name="pass" id="upw" value="" class="itx" />
          </span>
         </div>
         <div class="btn_area">
         <span>
          <input type="submit" value="로그인" class="login_btn" />
         </span>
         </div>
         <div class="help">
          <a href="${path}/model2/member/joinForm.me" class="join">
           <strong>회원가입</strong>
          </a>
          <a href="${path}/model2/member/joinForm.me" class="find">
           <strong>ID/PW찾기(미구현)</strong>
          </a>
         </div>
       </fieldset>
      </form>
       <button type="button" class="tg_blur"></button>
       <button type="button" class="tg_close" title="CLose this layer">X</button>
     </div>
     <!-- modal 끝 -->
     </li>
     <li class="item"></li>
     
    </ul>
    <!-- GNB -->
    <ul id="gnb" class="ul_font"></ul>
    
   </div>
   
  </div>
  <!-- 헤더 끝 -->
  </div>
  
 <div class="hp-container">
  <div id="container" class="clear" style="padding:100px 26px 100px;">
  <decorator:body />
  </div>
 </div>
  
  
  <!-- footer -->
 <div id="footer">
      <div id="footer_w">
         <div class="container">
            <div class="row-fluid">
               <!-- 푸터 로고 -->
               <a href="http://hiphople.com"><img
                  src="http://real5781.cdn2.cafe24.com/logo/logo_2018_white_400.png"
                  width="400"></a>
               <!-- 푸터 로고 끝 -->
               <br> <br>
               <div class="span4" style="margin: -10px 0 5px;">
                  <div id="footer_link">
                     <a href="http://hiphople.com/about">ABOUT</a>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="http://hiphople.com/advertise">ADVERTISEMENT</a>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="http://hiphople.com/recruit">RECRUIT</a>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="http://hiphople.com/privacy">PRIVACY</a>
                     <!---  --->
                  </div>
                  <div style="font-size: 11px; color: #9F9F9F; margin-top: 50px;">
                     경기도 고양시 행신3동 서정마을2로 6, 5층 | 010-7332-5349 | email: vmfkrhszzz@gmail.com<br>
                     등록일자: 2018.10.31 | 발행·편집인: 이창민 | 힙합-커뮤니티
                  </div>
                  <div id="footer_copy">
                     <span class="copyright_name">HIHM</span> All Right Reserved.
                     <p></p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
 <!-- footer END -->
</div>
</body>
</html>