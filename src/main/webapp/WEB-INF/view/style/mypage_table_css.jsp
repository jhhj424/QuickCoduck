<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url("https://fonts.googleapis.com/css?family=Roboto:300,400,500");
.table {
	font-family: "Roboto", sans-serif;
	border-collapse:collapse;
	border: 2px solid #ada6a6;
	border-radius: 5px;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
	border-bottom-left-radius: inherit;
	border-bottom-right-radius: inherit;
	line-height: 3;
	background-color: #FEFEFE;
}

.th {
	font-family: "Roboto", sans-serif;
	font-size: 15px;
	font-weight: 500;
}

a {
	font-family: "Roboto", sans-serif;
	text-decoration: none;
}

font {
	font-family: "Roboto", sans-serif;
	font-size: 20px;
	color: #363636e0; font-weight : bold;
	text-shadow: 1px 0px 0px #666666;
	font-weight: bold;
}
.tag {
	background: #009688;
	color: #fff;
	border-radius : 10px;
	padding: 2px 4px;
	font-size: 13px;
	margin-right: 2px;
	margin-left: 2px;
	line-height: 30px;
	cursor: pointer;
	border-radius: 10px;
}
.tag2 {
	background: #f95959b8;
	color: #fff;
	border-radius: 10px;
	padding: 2px 5px;
	font-size: 13px;
	margin-right: 2px;
	margin-left: 2px;
	line-height: 30px;
	cursor: pointer;
}

.page {
	font-family: "Roboto", sans-serif;
	color: #141618;
	margin: 25px 0 25px 0;
	text-align: center;
	font-weight: 600;
	text-shadow: 0px 0px 0px #666666;
}
.button {
	background: #009688d1;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	width: 100%;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 18px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 96%;
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
.button1 {
	background: #f95959bf;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	width: 100%;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 18px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 96%;
}

.button1:hover {
	background: #fff;
	color: #f95959bf;
	border-radius: 5px;
}

.button1:before, .button1:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #f95959bf;
	transition: 400ms ease all;
}

.button1:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.button1:hover:before, .button1:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.button2 {
	background: #4c6979a3;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	width: 100%;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 18px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 96%;
}

.button2:hover {
	background: #fff;
	color: #4c6979a3;
	border-radius: 5px;
}

.button2:before, .button2:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #4c6979a3;
	transition: 400ms ease all;
}

.button2:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.button2:hover:before, .button2:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.search{
  width: 260px;
  height: 30px;
  padding-left: 10px;
  padding-top: 3px;
  padding-bottom: 3px;
  margin: 7px;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
.submit{
  width: 10%;
  line-height:0;
  height:30px;
  font-weight:bold;
  font-size: 18px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
input:focus {
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
input:hover{
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
select{
  width: 12%;
  line-height:0;
  font-align:center;
  height:30px;
  font-weight:bold;
  font-size: 15px;
  border-radius: 10px;
  background: #6978762e;
  border: none;
  transition: background 0.5s;
}
select:focus {
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
select:hover{
  outline-width: 0;
  background: #0096884f;
  transition: background 0.5s;
}
</style>
</head>
</html>