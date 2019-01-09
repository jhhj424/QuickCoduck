<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- swiper슬라이더 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.6/js/swiper.min.js"></script>

<meta charset="UTF-8">
<title>서브홈페이지</title>
<script>
/*
* Swipe 1.0
*
* Original Author : Brad Birdsall, Prime
* Modify Comsin
* Copyright 2011, Licensed GPL & MIT
*
*/

window.widgetSwipe = function(element, options) {

  // return immediately if element doesn't exist
  if (!element) return null;

  var _this = this;

  // retreive options
  this.options = options || {};
  this.index = this.options.startSlide || 0;
  this.speed = this.options.speed || 300;
  this.callback = this.options.callback || function() {};
  this.delay = this.options.auto || 0;

  // reference dom elements
  this.container = element;
  this.element = this.container.children[0]; // the slide pane

  // static css
  this.container.style.overflow = 'hidden';
  this.element.style.listStyle = 'none';
  this.element.style.margin = 0;

  var ua = navigator.userAgent;
  if(navigator.userAgent.indexOf("Android 1.6") > 0 || navigator.userAgent.indexOf("Android 2.1") > 0  || navigator.userAgent.indexOf("Android 2.2") > 0 || navigator.userAgent.indexOf("Android 2.3") > 0) this.Agent = false;  // 4.0 below
  else this.Agent = true; // 4.0 more


  // trigger slider initialization
  this.setup();

  // begin auto slideshow
  this.begin();

  // add event listeners
  if (this.element.addEventListener) {
    this.element.addEventListener('touchstart', this, false);
    this.element.addEventListener('touchmove', this, false);
    this.element.addEventListener('touchend', this, false);
    this.element.addEventListener('webkitTransitionEnd', this, false);
    this.element.addEventListener('msTransitionEnd', this, false);
    this.element.addEventListener('oTransitionEnd', this, false);
    this.element.addEventListener('transitionend', this, false);
    window.addEventListener('resize', this, false);
  }

};

widgetSwipe.prototype = {

  setup: function() {

    // get and measure amt of slides
    this.slides = this.element.children;
    this.length = this.slides.length;

    // return immediately if their are less than two slides
    if (this.length < 2) return null;

    // determine width of each slide
    this.width = Math.ceil(("getBoundingClientRect" in this.container) ? this.container.getBoundingClientRect().width : this.container.offsetWidth);

    // return immediately if measurement fails
    if (!this.width) return null;

    // hide slider element but keep positioning during setup
    this.container.style.visibility = 'hidden';

    // dynamic css
    this.element.style.width = Math.ceil(this.slides.length * this.width) + 'px';
    var index = this.slides.length;
    while (index--) {
      var el = this.slides[index];
      el.style.width = this.width + 'px';
      el.style.display = 'table-cell';
      el.style.verticalAlign = 'top';
    }

    // set start position and force translate to remove initial flickering
    this.slide(this.index, 0);

    // show slider element
    this.container.style.visibility = 'visible';

  },

  slide: function(index, duration) {

    var style = this.element.style;

    // fallback to default speed
    if (duration == undefined) {
        duration = this.speed;
    }

    // set duration speed (0 represents 1-to-1 scrolling)
    style.webkitTransitionDuration = style.MozTransitionDuration = style.msTransitionDuration = style.OTransitionDuration = style.transitionDuration = duration + 'ms';

    // translate to given index position
    if(this.Agent) style.MozTransform = style.webkitTransform = 'translate3d(' + -(index * this.width) + 'px,0,0)';
    else style.MozTransform = style.webkitTransform = 'translateX(' + -(index * this.width) + 'px)';
    	
    style.msTransform = style.OTransform = 'translateX(' + -(index * this.width) + 'px)';

    // set new index to allow for expression arguments
    this.index = index;

  },

  getPos: function() {
    
    // return current index position
    return this.index;

  },

  prev: function(delay) {

    // cancel next scheduled automatic transition, if any
    this.delay = delay || 0;
    clearTimeout(this.interval);

    // if not at first slide

    	if(this.index==0) this.slide(this.length-1, this.speed); //if last slide return to start
    	else this.slide(this.index-1, this.speed);


  },

  next: function(delay) {

    // cancel next scheduled automatic transition, if any
    this.delay = delay || 0;
    clearTimeout(this.interval);

    if (this.index < this.length - 1) this.slide(this.index+1, this.speed); // if not last slide
    else this.slide(0, this.speed); //if last slide return to start

  },

  begin: function() {

    var _this = this;

    this.interval = (this.delay)
      ? setTimeout(function() {
        _this.next(_this.delay);
      }, this.delay)
      : 0;
  
  },
  
  stop: function() {
    this.delay = 0;
    clearTimeout(this.interval);
  },
  
  resume: function() {
    this.delay = this.options.auto || 0;
    this.begin();
  },

  handleEvent: function(e) {
    switch (e.type) {
      case 'touchstart': this.onTouchStart(e); break;
      case 'touchmove': this.onTouchMove(e); break;
      case 'touchend': this.onTouchEnd(e); break;
      case 'webkitTransitionEnd':
      case 'msTransitionEnd':
      case 'oTransitionEnd':
      case 'resize': this.setup(); break;
    }
  },

  transitionEnd: function(e) {
    
    if (this.delay) this.begin();

    this.callback(e, this.index, this.slides[this.index], this.slides[this.index].id);

  },

  onTouchStart: function(e) {
    
    this.start = {

      // get touch coordinates for delta calculations in onTouchMove
      pageX: e.touches[0].pageX,
      pageY: e.touches[0].pageY,

      // set initial timestamp of touch sequence
      time: Number( new Date() )

    };

    // used for testing first onTouchMove event
    this.isScrolling = undefined;
    
    // reset deltaX
    this.deltaX = 0;

    // set transition time to 0 for 1-to-1 touch movement
    this.element.style.MozTransitionDuration = this.element.style.webkitTransitionDuration = 0;
    
    e.stopPropagation();
  },

  onTouchMove: function(e) {

    // ensure swiping with one touch and not pinching
    if(e.touches.length > 1 || e.scale && e.scale !== 1) return;

    this.deltaX = e.touches[0].pageX - this.start.pageX;

    // determine if scrolling test has run - one time test
    if ( typeof this.isScrolling == 'undefined') {
      this.isScrolling = !!( this.isScrolling || Math.abs(this.deltaX) < Math.abs(e.touches[0].pageY - this.start.pageY) );
    }

    // if user is not trying to scroll vertically
    if (!this.isScrolling) {

      // prevent native scrolling
      e.preventDefault();

      // cancel slideshow
      clearTimeout(this.interval);

      // increase resistance if first or last slide
      this.deltaX =
        this.deltaX /
          ( (!this.index && this.deltaX > 0 // if first slide and sliding left
            || this.index == this.length - 1 // or if last slide and sliding right
            && this.deltaX < 0 // and if sliding at all
          ) ?
          ( Math.abs(this.deltaX) / this.width + 1 )
          : 1 ); // no resistance if false
      
      // translate immediately 1-to-1
      if(this.Agent) this.element.style.MozTransform = this.element.style.webkitTransform = 'translate3d(' + (this.deltaX - this.index * this.width) + 'px,0,0)';
      else this.element.style.MozTransform = this.element.style.webkitTransform = 'translateX(' + (this.deltaX - this.index * this.width) + 'px)';
      e.stopPropagation();
    }

  },

  onTouchEnd: function(e) {

    // determine if slide attempt triggers next/prev slide
    var isValidSlide =
          Number(new Date()) - this.start.time < 250 // if slide duration is less than 250ms
          && Math.abs(this.deltaX) > 20 // and if slide amt is greater than 20px
          || Math.abs(this.deltaX) > this.width/2,

    // determine if slide attempt is past start and end
        isPastBounds =
          !this.index && this.deltaX > 0 // if first slide and slide amt is greater than 0
          || this.index == this.length - 1 && this.deltaX < 0; // or if last slide and slide amt is less than 0

    // if not scrolling vertically
    if (!this.isScrolling) {

      // call slide function with slide end value based on isValidSlide and isPastBounds tests
      this.slide( this.index + ( isValidSlide && !isPastBounds ? (this.deltaX < 0 ? 1 : -1) : 0 ), this.speed );

    }
    
    e.stopPropagation();
  }

};
</script>
<script>
	window.onload = function() {
		//initialize swiper when document ready
		var mySwiper = new Swiper('.swiper-container', {
			// Optional parameters
			loop : true,
			autoplay : {
				delay : 3000,
			},
			// If we need pagination
			pagination : {
				el : '.swiper-pagination',
				clickable : true,
			},
			// Navigation arrows
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
		})
	};
</script>
<!-- 태그 스타일 -->
<style>
body {
	font-size: 13px;
	letter-spacing: 0.2px;
	line-height: 1.5;
}
div {
	display: block;
}

a {
	text-decoration: none;
	color: #313131;
}

ul {
	margin: 0;
	padding: 0;
}

ul ul, ol ul {
	list-style-type: circle;
}

ul, menu, dir {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 0px;
}

li {
	list-style: none;
}

input, textarea, select, button {
	text-rendering: auto;
	color: initial;
	letter-spacing: normal;
	word-spacing: normal;
	text-transform: none;
	text-indent: 0px;
	text-shadow: none;
	display: inline-block;
	text-align: start;
	margin: 0em;
	font: 400 13.3333px Arial;
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

a img {
	border: 0;
}

script {
	display: none;
}

p {
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

a img {
	border: 0;
}

a:hover, a:active, a:focus {
	text-decoration: none;
}

li {
    display: list-item;
    text-align: -webkit-match-parent;
}
:focus {
    outline: -webkit-focus-ring-color auto 5px;
}
a:-webkit-any-link {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: underline;
}
</style>

<!-- 클래스 스타일 -->
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

a.skipToContent {
	display: block;
	position: absolute;
	top: -1px;
	width: 100%;
	height: 1px;
	overflow: hidden;
	text-align: center;
}

.ui_font {
	font-family: 'Segoe UI', Meiryo, 'Trebuchet MS', '나눔고딕', NanumGothic, ng,
		'맑은 고딕', 'Malgun Gothic';
}

.hp-container {
	position: relative;
	width: 1200px;
	margin: 0 auto;
	background-color: #fff;
}

.c #content {
	float: none !important;
}

.mline {
	text-align: center;
	font-size: 1.1rem;
	color: #1a1a1a;
	letter-spacing: 2px;
	margin-top: 90px;
	margin-bottom: 0px;
}

.mline>span {
	position: relative;
	display: inline-block;
	padding-bottom: 10px;
}

.xe-widget-wrapper {
	overflow: hidden;
}

.widget_box2 {
	position: relative;
	overflow: hidden;
	display: block;
	border: 0;
}

.widgetContainer {
	position: relative;
	border: 0;
	overflow: hidden;
}

.top_tab {
	overflow: hidden;
	width: 100%;
	border-bottom: 1px solid #c8c8c8;
	background: #f9f9f9;
	background: -webkit-gradient(linear, 0 0, 0 100%, from(#fcfcfc),
		to(#f6f6f6));
}

.top_tab ul {
	box-shadow: none;
	text-align: center;
	white-space: nowrap;
	-webkit-box-shadow: inset 0 1px 1px #eeeff2;
}

.top_tab li {
	float: left;
}

.top_tab li a {
	display: block;
	position: relative;
	line-height: 25px;
	padding: 5px 10px 5px 10px;
	font-size: 12px;
	color: #666666;
	letter-spacing: -1px;
	text-align: left;
	white-space: nowrap;
	margin-left: 3px;
}

#widgetTabBox_2018cms.top_tab li {
	float: none;
	display: inline-block;
}

.top_tab li.on a {
	color: #555;
	font-weight: bold;
}

.top_tab li a:first-child {
	padding-left: 5px;
}

.widgetContainer .normal_list {
	overflow: hidden;
}

.widgetContainer .normal_list li {
	position: relative;
	float: left;
	display: block;
	width: 100%;
	border-bottom: 1px solid #EAEAEA;
	padding: 5px 0;
}

.widgetContainer .normal_list li.nb {
	border-bottom: 0;
	text-align: center;
}

.widgetContainer .normal_list li.nb a {
	display: inline-block;
	text-align: left;
	margin: 0 auto;
}

.widgetContainer .normal_list li a {
	color: #434341;
	display: block;
	font-size: 13px;
	padding: 0 5px;
	position: relative;
	z-index: 999;
	vertical-align: middle;
	line-height: 20px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li.nb a {
	border: 1px solid #ccc;
	padding: 0;
	padding-bottom: 30px;
}

.widgetContainer .normal_list li a div.thumb_bl {
	position: relative;
	display: block;
	margin: 2px 0;
}

.widgetContainer .normal_list li a div.thumb_lr .thumbbox,
	.widgetContainer .normal_list li a div.thumb_bl .thumbbox {
	display: inline-block;
	border: 1px solid #DDDDE1;
}

.widgetContainer .normal_list li a div.thumb_lr .thumbbox .thumb,
	.widgetContainer .normal_list li a div.thumb_bl .thumbbox .thumb {
	position: relative;
	display: block;
}

.widgetContainer .normal_list li a span {
	display: inline;
	color: #567088;
	letter-spacing: -1px;
	font-size: 13px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox .thumb img
	{
	width: 100% !important;
	height: auto !important;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title {
	margin-top: 30px;
	height: 6.5em;
	font-size: 17px;
	font-weight: 700;
	line-height: 25px;
	overflow: hidden;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.browsertitle,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.regdate
	{
	display: block;
	text-align: center;
	padding: 0 30px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.browsertitle,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.regdate
	{
	display: block;
	text-align: center;
	padding: 0 30px;
}

.widgetContainer .normal_list li a span.browsertitle {
	color: #617A90;
	font-weight: bold;
}

.widgetContainer .comsin_fixed ul {
	display: -webkit-box;
	display: -moz-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
}

.widgetContainer .comsin_fixed li {
	/* width: 25%; */
	
}

.widgetContainer .comsin_fixed li img {
	width: 100%;
}

.widgetContainer:after {
	display: block;
	clear: both;
	content: "";
}

.top_tab ul:after {
	display: block;
	clear: both;
	content: '';
}

.clear:after {
	content: "";
	display: block;
	clear: both;
}

.widgetContainer .normal_list li:after {
	display: block;
	clear: both;
	content: "";
}

.cm_csw_widgetContainer .csw_typeB .caption .title {
	color: #fff !important;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li.nb,
	.widgetContainer .comsin_fixed li {
	box-sizing: border-box;
	padding: 7px;
}

.widgetContainer .comsin_fixed {
	margin-bottom: 70px;
}

.widgetContainer .comsin_fixed ul {
	display: -webkit-box; /* OLD - iOS 6-, Safari 3.1-6 */
	display: -moz-box; /* OLD - Firefox 19- (buggy but mostly works) */
	display: -ms-flexbox; /* TWEENER - IE 10 */
	display: -webkit-flex; /* NEW - Chrome */
	display: flex; /* NEW, Spec - Opera 12.1, Firefox 20+ */
}

.widgetContainer .comsin_fixed li {
	
}

.widgetContainer .comsin_fixed li img {
	width: 100%;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li.nb a {
	border: 1px solid #ccc;
	padding: 0;
	padding-bottom: 30px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox
	{
	margin: 0;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox .thumb.noimage
	{
	width: 271px !important;
	height: 163px !important;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox .thumb img
	{
	width: 100% !important;
	height: auto !important;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.browsertitle,
	.widgetContainer #widgetPageBox_2018cms .normal_list li a span.regdate
	{
	display: block;
	text-align: center;
	padding: 0 30px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title {
	margin-top: 30px;
	height: 6.5em;
	font-size: 17px;
	font-weight: 700;
	line-height: 25px;
	overflow: hidden;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a span.title span
	{
	font-size: 17px;
	line-height: 25px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox
	{
	border: none;
}

.top_tab ul {
	box-shadow: none;
}

.mline>span:after {
	position: absolute;
	left: calc(50% - 25px);
	bottom: 0;
	width: 50px;
	height: 1px;
	background: #FF2E2E;
	content: "";
}

.top_tab li a:after {
	position: absolute;
	left: 100%;
	top: 13px;
	width: 1px;
	height: 10px;
	background: #ccc;
	content: '';
}

.ba_c {
	width: 100%;
	margin: 30px 0 60px;
	text-align: center;
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
</style>

<!-- 아이디 스타일 -->
<style>
#all {
	font-family: "Noto Sans KR", sans-serif;
	position: relative;
	padding: 0px;
}
#hd .hgroup {
    text-align: center;
}
#hd .hgroup {
    min-height: 38px;
    padding: 65px 248px 40px 270px;
    background-color: #FFF;
}

#mainslider {
	width: 100%;
	padding: 0 26px;
	box-sizing: border-box;
	max-width: 1552px;
	min-width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

#container {
	padding: 5px 32px 10px;
}

#content {
	display: block;
	position: relative;
	float: left;
	width: 100%;
	margin: 0 auto;
}

#widgetTabBox_2018cms.top_tab {
	background: none;
	border: none;
}

#widgetTabBox_2018cms.top_tab li {
	float: none;
	display: inline-block;
}

#widgetTabBox_2018cms.top_tab li a:after {
	display: none;
}

#widgetTabBox_2018cms.top_tab li a {
	font-size: 16px;
	margin-bottom: 10px;
	padding-left: 10px;
	cursor: pointer;
}

.copyright_name {
	color: #CCC;
	font-weight: bold;
	letter-spacing: 0.1px;
}
</style>

<!-- 그외 -->
<style type="text/css">

@media screen and (max-width: 533px) {
	#container {
		padding: 0 !important;
	}
}

@media screen and (max-width: 768px) {
	#container {
		padding: 20px 0 !important;
	}
}

@media screen and (max-width: 533px) {
	#content {
		padding: 20px 0 !important;
	}
}

@media screen and (max-width: 768px) {
	#container, #content {
		position: relative !important;
		top: 0 !important;
		left: 0 !important;
		width: 100% !important;
		height: auto !important;
		margin: 0 !important;
		padding: 0 !important;
	}
}

@media screen and (max-width: 768px) {
	#gap {
		margin: 0 !important;
	}
}

</style>

</head>
<body>
	<div id="all">
		<div class="hp-container">
			<div id="container" class="clear" style="padding: 0px 26px 0px;">
				<div id="content">
					<div id="gap">
						<!------------------- Mainpage css ------------------------>

						
						<!-- 여기부터 -->
						<!-- 구분선 'COMMUNITY' -->
						<script
							src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.6/js/swiper.min.js"></script>
						<div class="mline" style="margin-bottom: 20px;">
							<span> OPENSOURCE & PROJECT </span>
						</div>
						<div>
							<div class="xe-widget-wrapper " style="">
								<div style="*zoom: 1; padding: 0px 0px 0px 0px !important;">
									<div class="widget_box2">
										<div class="widgetContainer">
											<div id="widgetTabBox_2018cms" class="top_tab">
												<ul>
													<li><a onclick="javascript:widgetPageSlider_2018cms.slide(0, 300);$('.on').removeClass('on');$(this).parent().addClass('on');return false;"
														title="인기 소스" id=opso>인기 소스</a></li>
													<li><a onclick="javascript:widgetPageSlider_2018cms.slide(1, 300);$('.on').removeClass('on');$(this).parent().addClass('on');return false;"
														title="인기 프로젝트">인기 프로젝트</a></li>
												</ul>
											</div>

											<!----- 배너 4개 ------>
											<div id="widgetPageBox_2018cms" style="overflow: hidden; visibility: visible;">
												<ul style="list-style: none; margin: 0px; width: 9184px; transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
												<!-- 오픈소스 슬라이더 -->
													<li id="widgetPage_2018cms_0_0"
														style="width: 1148px; display: table-cell; vertical-align: top;">
														<ul class="normal_list">
														
														<c:forEach var="board" items="${boardlist}" end="3">
															<li class="nb" style="width: 25%;"><a target="_self"
																href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}"> <!-- 링크 -->
																	<div class="thumb_bl">
																		<p class="thumbbox">
																			<span class="thumb"> <img class="thumbnail"
																				src="${board.pic}"
																				style="width: 300px; height: 180px"><!-- 사진 -->
																			</span>
																		</p>
																	</div> <span class="title"> ${board.subject}<!-- 제목 -->
																		<span style="margin-left: 5px; color: #EE3366; font-size: 0.8em; font-weight: 300;"></span>
																</span> <span class="browsertitle">
																<!-- 보드타입 -->
																<c:if test="${board.boardtype==1}">OpenSource</c:if></span>
																</span>
																<span class="regdate">
																<!-- 작성일 -->
																<!-- 오늘올린 게시물이면 HH:mm  //  과거에 올렸던건 yy/MM/dd -->
																<jsp:useBean id ="day" class="java.util.Date"/>
																<fmt:formatDate value="${day}" pattern="yyyyMMdd" var="today"/>
                  												<fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate" />
                  													<c:if test="${today == rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
                  													</c:if>
              														<c:if test="${today != rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="yy/MM/dd"/>
                  													</c:if>
																</span>
															</a></li>
															</c:forEach>
															
														</ul> <!-- contents more --->
													</li>
													<li id="widgetPage_2018cms_1_0"
														style="width: 1148px; display: table-cell; vertical-align: top;">
														<ul class="normal_list">
														
														<c:forEach var="board" items="${boardlist2}" end="3">
															<li class="nb" style="width: 25%;"><a target="_self"
																href="../board/detail.duck?num=${board.boardnum}&type=${board.boardtype}"> <!-- 링크 -->
																	<div class="thumb_bl">
																		<p class="thumbbox">
																			<span class="thumb"> <img class="thumbnail"
																				src="${board.pic}"
																				style="width: 300px; height: 180px"><!-- 사진 -->
																			</span>
																		</p>
																	</div> <span class="title"> ${board.subject}<!-- 제목 -->
																		<span style="margin-left: 5px; color: #EE3366; font-size: 0.8em; font-weight: 300;"></span>
																</span> <span class="browsertitle">
																<!-- 보드타입 -->
																<c:if test="${board.boardtype==3}">Project</c:if></span>
																<span class="regdate">
																<!-- 작성일 -->
																<!-- 오늘올린 게시물이면 HH:mm  //  과거에 올렸던건 yy/MM/dd -->
																<fmt:formatDate value="${day}" pattern="yyyyMMdd" var="today"/>
                  												<fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate" />
                  													<c:if test="${today == rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
                  													</c:if>
              														<c:if test="${today != rdate }">
                     													<fmt:formatDate value="${board.regdate}" pattern="yy/MM/dd"/>
                  													</c:if>
																</span>
																</span>
															</a></li>
															</c:forEach>
														</ul> <!-- contents more --->
													</li>																											
												</ul>
												
											</div>
											<script type="text/javascript">
												var widgetPageSlider_2018cms = new widgetSwipe(
														document.getElementById('widgetPageBox_2018cms'),{
															auto : 0,
															callback : function(event, tm,p, pid) {
																setTab('2018cms',pid);
															},
												});
											</script>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 하단 BAR -->
</body>
</html>