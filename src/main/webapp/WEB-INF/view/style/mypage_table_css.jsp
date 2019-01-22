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
.page {
	font-family: "Roboto", sans-serif;
	color: #141618;
	margin: 25px 0 25px 0;
	text-align: center;
	font-weight: 600;
	text-shadow: 0px 0px 0px #666666;
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