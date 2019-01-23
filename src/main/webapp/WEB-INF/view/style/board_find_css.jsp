<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
input[type=checkbox] {
	margin-left: 5px;
}

.readcnt {
	font-weight: bold;
	font-size: 15px;
	top: -0.15em;
}

.div {
	font-family: "Roboto", sans-serif;
	border: 2px solid #ada6a6;
	border-radius: 5px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
	border-bottom-left-radius: inherit;
	border-bottom-right-radius: inherit;
}

.content {
	filter: grayscale(30%);
	font-family: "Roboto", sans-serif;
	margin: 10px 10px 10px 10px;
	box-shadow: 0 0 3px rgba(0, 0, 0, 1);
	border-radius: 5px;
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 10% 62%;
}

.h3 {
	font-family: "Roboto", sans-serif;
	text-align: left;
	color: #2d3a45;
	margin: 15px 0 0 15px;
	font-weight: 600;
	text-shadow: -1px 1px 1px #666666;
}

.button {
	background: #009688;
	border-radius: 5px;
	margin-bottom: 20px;
	width: 100%;
	color: #fff;
	border: none;
	position: relative;
	height: 60px;
	font-size: 1.8em;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 99%;
}

.button:hover {
	background: #fff;
	color: #009688;
	border-radius: 5px;
}

.button:before, .button:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #009688;
	transition: 400ms ease all;
}

.button:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.button:hover:before, .button:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}

.page {
	font-family: "Roboto", sans-serif;
	color: #141618;
	margin: 25px 0 25px 0;
	text-align: center;
	font-weight: 600;
	text-shadow: 0px 0px 0px #666666;
}

.form {
	margin-bottom: 30px;
}

.listcount_div {
	margin: 10px 10px 10px 0;
}

.listcount_b {
	margin: 10px 10px 10px 0;
}

.span {
	margin-left: 12px;
	background: #009688;
	border-radius: 6px;
	margin-right: 10px;
	color: #fefefe;
	font-size: 16px;
	padding: 0px 7px;
}

.recmd {
	background: #45515acf;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	font-weight: lighter;
	margin-left: 10px;
	line-height: 30px;
	cursor: pointer;
}

.recmd_best {
	background: #ff9800;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	font-weight: lighter;
	margin-left: 10px;
	line-height: 30px;
	cursor: pointer;
}

.span2 {
	margin-left: 12px;
	background: #f95959b8;
	border-radius: 6px;
	margin-right: 10px;
	color: #fefefe;
	font-size: 16px;
	padding: 0px 7px;
}

a {
	font-family: "Roboto", sans-serif;
	text-decoration: none;
}

.thumb {
	color: #878787c9;
	font-family: "Roboto", sans-serif;
	width: 40%;
	max-width: 330px;
	height: 80px;
	max-height: 85px;
	overflow: hidden;
	float: left;
	margin: 10px 0 0 20px;
	line-height: initial;
	resize: none;
	border: 2px solid #ada6a6;
	border-radius: 10px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
	word-break: break-all;
}

.right {
	font-family: "Roboto", sans-serif;
	overflow: visible;
	text-overflow: ellipsis;
	word-break: normal;
}

.tag_new {
	background: #ff7800;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
	font-weight: lighter;
}

.tag {
	background: #009688;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.tag_check {
	background: #00bc70;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.tag2 {
	background: #f95959b8;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.tag3 {
	background: #364756c9;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	line-height: 30px;
	cursor: pointer;
}

.tag4 {
	background: #2099bb;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	font-weight: lighter;
	margin-left: 10px;
	margin-right: 10px;
	line-height: 30px;
	cursor: pointer;
}

.tag5 {
	background: #022dcfd6;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	font-weight: lighter;
	margin-right: 10px;
	line-height: 30px;
	cursor: pointer;
}

.tag_duck {
	background: #3034bac2;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	font-weight: lighter;
	margin-left: 10px;
	line-height: 30px;
	cursor: pointer;
}

.tag:hover {
	background: #435761;
}
</style>
</head>
<body>

</body>
</html>