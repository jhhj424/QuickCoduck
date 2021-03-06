<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<style>
<style>

body,h1,h2,h3,h4,h5,h6,sup {font-family: "Raleway", Arial, Helvetica, sans-serif}
.w3-badge, .w3-tag{
margin-bottom:5px;
}
.leftdiv{
width:30%;
float:left;
max-height:100%;
margin:0 0 0 1px;
height:100%;
text-align:center;
background-color: #FEFEFE;
border-radius: 10px;
box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
}
.centerdiv{
width:40%;
height:100%;
margin:0 auto;
text-align:center;
max-height:100%;
max-width:300px;
background-color: #FEFEFE;
border-radius: 10px;
box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
}
.rightdiv{
width:30%;
margin:0 1px 0 0;
height:100%;
float:right;
max-height:100%;
text-align:center;
background-color: #FEFEFE;
border-radius: 10px;
box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
}
.card {
  background-color: #f3f5f7;
  box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  max-width: 500px;
  height: 300px;
  border-radius: 10px;
  overflow: hidden;
}

.card .about {
  height: 150px;
  padding: 20px;
  box-sizing: border-box;
}

.card .about h3,
.card .about .lead {
  font-weight: 300;
  margin: 0;
}

.card .about h3 {
  font-size: 24px;
}

.card .about .lead {
  color: #aaa;
}
.tooltip-placeholder {
  background-color: #fff;
  border-radius: 4px;
  color: #aaa;
  font-size: 15px;
  position: fixed;
  padding: 4px 0;
  display: none;
  z-index: 2;
}
.score_main {
  font-family: arial;
  font-size: 20px;
  color: green;
  margin-top: 15px;
}

.score_main-rating {
  vertical-align: sup;
  top: -5px;
  position: relative;
  font-size: 150%;
}
.total {
  vertical-align: sub;
  top: 0px;
  position: relative;
  font-size: 100%;
}
.rating_main{
  margin-top:10px;
}
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  color:#000;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #f95959;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content:"";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #46c95e;
}

input:focus + .slider {
  box-shadow: 0 0 1px #46c95e;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}


</style>
</head>
</html>