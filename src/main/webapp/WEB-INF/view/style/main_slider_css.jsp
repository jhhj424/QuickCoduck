<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 태그 스타일 -->
<style>
div {
	display: block;
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


li {
    display: list-item;
    text-align: -webkit-match-parent;
}
:focus {
    outline: -webkit-focus-ring-color auto 5px;
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
	color: #555;
	letter-spacing: -1px;
	font-size: 13px;
}

.widgetContainer #widgetPageBox_2018cms .normal_list li a div.thumb_bl .thumbbox .thumb img
	{
	width: 270px !important;
	height: 230px !important;
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
	color: #555;
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
	width: 270px !important;
	height: 230px !important;
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
</html>