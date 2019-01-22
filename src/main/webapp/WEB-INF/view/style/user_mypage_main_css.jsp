<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.chart {
  border-radius: 3px;
  box-shadow: 0 0 10px -3px black;
  float: left;
  margin: 15px 2.5%;
  position: relative;
  width: 45%;
}
canvas {
  height: 400px;
  margin: 20px 0;
  width: 100%;
}
.header {
  *zoom: 1;
}
.header:before,
.header:after {
  content: "";
  display: table;
}
.header:after {
  clear: both;
}
.header span {
  cursor: pointer;
  display: inline-block;
  font-size: 20px;
  margin: 5px;
  padding: 4px;
}
.header .left {
  float: left;
}
.header .right {
  float: right;
}
.title {
  font-size: 18px;
  margin: 0;
  padding: 15px 0 5px;
}
.title + .tagline {
  margin-top: 10px;
}
.tagline {
  font-size: 12px;
}
.light {
  background-color: #FBFCFD;
  color: #274A61;
}
.dark {
  background-color: #274A61;
  color: #FBFCFD;
}
main {
  text-align: center;
}
.hidden {
  display: none;
}
.container {
  *zoom: 1;
  font-size: 0;
  margin: 0 auto 145px;
  max-width: 960px;
  padding: 0;
  width: 100%;
}
.container:before,
.container:after {
  content: "";
  display: table;
}
.container:after {
  clear: both;
}

</style>
</head>
</html>