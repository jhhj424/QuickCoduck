<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
  font-family: 'Roboto', sans-serif;
}

html {
  --card-color: #cacaca;
  --text-color: #e1e1e1;
}
.container {
  display: flex;
  width: 100%;
}
.card{
top:45%;
left:50%;
background-color:#f3f5f7;
transform:teanslate(-50%,-50%);
max-width:500px;
overflow:hidden;
}
.container .col1 .card {
  position: relative;
  width: 420px;
  height: 250px;
  margin-bottom: 30px;
  margin-right: 10px;
  border-radius: 17px;
  box-shadow: 0 5px 20px -5px rgba(0, 0, 0, 0.1);
  transition: all 1s;
  -webkit-transform-style: preserve-3d;
          transform-style: preserve-3d;
}
.container .col1 .card .front {
  position: absolute;
  background: #009688a3;
  border-radius: 17px;
  padding: 50px;
  width: 100%;
  height: 100%;
  transform: translateZ(1px);
  -webkit-transform: translateZ(1px);
  transition: background 0.3s;
  z-index: 50;
  background-image: repeating-linear-gradient(45deg, rgba(255, 255, 255, 0) 1px, rgba(255, 255, 255, 0.03) 2px, rgba(255, 255, 255, 0.04) 3px, rgba(255, 255, 255, 0.05) 4px), -webkit-linear-gradient(-245deg, rgba(255, 255, 255, 0) 40%, rgba(255, 255, 255, 0.2) 70%, rgba(255, 255, 255, 0) 90%);
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}
.container .col1 .card .front .type {
  position: absolute;
  width: 75px;
  height: 45px;
  top: 20px;
  right: 20px;
}
.container .col1 .card .front .type img {
  width: 100%;
  float: right;
}
.container .col1 .card .front .card_number {
  position: absolute;
  font-size: 26px;
  font-weight: 500;
  letter-spacing: -1px;
  top: 110px;
  color: #fefefe;
  word-spacing: 3px;
  transition: color 0.5s;
}
.container .col1 .card .front .date {
  position: absolute;
  bottom: 25px;
  right: 40px;
  width: 90px;
  height: 35px;
  color: #161515db;
  transition: color 0.5s;
}
.container .col1 .card .front .date .date_value {
  font-size: 12px;
  position: absolute;
  margin-left: 22px;
  margin-top: 12px;
  color: #161515db;
  font-weight: 500;
  transition: color 0.5s;
}
.container .col1 .card .front .date:after {
  content: 'MONTH / YEAR';
  position: absolute;
  display: block;
  font-size: 7px;
  margin-left: 20px;
}
.container .col1 .card .front .date:before {
  content: 'valid \a thru';
  position: absolute;
  display: block;
  font-size: 8px;
  white-space: pre;
  left:-10px;
}
.container .col1 .card .front .fullname {
  position: absolute;
  font-size: 20px;
  bottom: 25px;
  color: #161515db;
  transition: color 0.5s;
}
.chip {
  position: absolute;
  width: 55px;
  height: 40px;
  background: #bbb;
  border-radius: 7px;
}
.chip:after {
  content: '';
  display: block;
  width: 35px;
  height: 25px;
  border-radius: 4px;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  background: #ddd;
}

</style>
</head>
</html>