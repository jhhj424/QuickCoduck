<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url(https://fonts.googleapis.com/css?family=Lato:400,300,700);

@import
	url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

*, *:before, *:after {
	box-sizing: border-box;
}

.movie-card {
	font: 14px/22px "Lato", Arial, sans-serif;
	color: #A9A8A3;
	padding: 40px 0;
}

.container {
	margin: 0 auto;
	width: 80%;
	height: 105%;
	background: #f0f0ed8a;
	border-radius: 5px;
	position: relative;
	border-radius: 10px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
}

.hero {
	height: 342px;
	margin: 0;
	position: relative;
	overflow: hidden;
	z-index: 0;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.hero:before {
	content: '';
	width: 100%;
	height: 100%;
	position: absolute;
	overflow: hidden;
	top: 0;
	left: 0;
	background: url("../workpic/title3.jpg");
	filter: grayscale(30%);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 10% 20%;
	z-index: -1;
	-webkit-transform: skewY(-2.2deg);
	transform: skewY(-2.2deg);
	-webkit-transform-origin: 0 0;
	transform-origin: 0 0;
	-webkit-backface-visibility: hidden;
}

.cover {
	position: absolute;
	top: 140px;
	left: 30px;
	width: 310px;
	height: 310px;
	z-index: 1;
	border-radius: 30px;
}

.details {
	padding: 125px 0 0 0;
}

.details .title1 {
	color: #151414;
	background-color: #fefefe;
	text-shadow: -1px 2px 2px white;
	width: 60%;
	line-height: 2;
	margin: 0 auto;
	border-radius: 10px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
	font-size: 30px;
	font-weight: 900;
	margin-bottom: 50px;
	position: relative;
}

.details .title1 span {
	position: relative;
	text-shadow: none;
	top: 15px;
	margin-left: 20px;
	background: #009688;
	border-radius: 5px;
	color: #fefefe;
	font-size: 15px;
	padding: 0px 10px;
}

.details .title2 {
	color: #151414;
	position: relative;
	background-color: #fefefe;
	font-size: 30px;
	font-weight: 900;
	margin-bottom: 30px;
	width: 60%;
	line-height: 3;
	margin: 0 auto;
	border-radius: 10px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
}

.details .likes {
	margin-left: 24px;
}

.details .likes:before {
	content:
		url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/195612/icon_like.png");
	position: relative;
	top: 2px;
	padding-right: 7px;
}

.description {
	bottom: 0px;
	width: 100%;
	font-size: 16px;
	line-height: 26px;
	color: #000;
}

.column1 {
	padding-left: 50px;
	padding-top: 120px;
	width: 220px;
	float: left;
	text-align: center;
}

.tag {
	background: #435761;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.tag:hover {
	background: #ddd;
}

.column2 {
	padding-left: 41px;
	padding-top: 30px;
	margin-left: 20px;
	width: 480px;
	float: left;
}

.avatars {
	margin-top: 23px;
}

.avatars img {
	cursor: pointer;
}

.avatars img:hover {
	opacity: 0.6;
}

.avatars a:hover {
	text-decoration: none;
}

fieldset, label {
	margin: 0;
	padding: 0;
}

/****** Style Star Rating Widget *****/
.rating {
	border: none;
	float: left;
}

.rating>input {
	display: none;
}

.rating>label:before {
	margin: 5px;
	margin-top: 0;
	font-size: 1em;
	font-family: FontAwesome;
	display: inline-block;
	content: "\f005";
}

.rating>.half:before {
	content: "\f089";
	position: absolute;
}

.rating>label {
	color: #ddd;
	float: right;
}

/***** CSS Magic to Highlight Stars on Hover *****/
.rating>input:checked ~ label, .rating:not (:checked ) >label:hover,
	.rating:not (:checked ) >label:hover ~ label {
	color: #FFD700;
}

/* hover previous stars in list */
.rating>input:checked+label:hover, .rating>input:checked ~ label:hover,
	.rating>label:hover ~ input:checked ~ label, .rating>input:checked ~
	label:hover ~ label {
	color: #FFED85;
}
</style>
</head>
</html>