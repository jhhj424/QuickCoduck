<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.rating1,.rating2,.rating3,.rating4,.rating5 {
  text-align: center;
  margin-top: 50px;
  position: relative;
  width: 45%;
  float: left;
}

.hidden {
  opacity: 0;
}

.star {
  display: inline-block;
  margin: 5px;
  font-size: 30px;
  color: #b2b2b25c;
  position: relative;
}
.star.animate {
  -webkit-animation: stretch-bounce .5s ease-in-out;
}
.star.hidden {
  opacity: 0;
}

.full:before {
  font-family: fontAwesome;
  display: inline-block;
  content: "\f005";
  position: relative;
  float: right;
  z-index: 2;
}

.half:before {
  font-family: fontAwesome;
  content: "\f089";
  position: absolute;
  float: left;
  z-index: 3;
}

.star-colour {
  color: #ffd700;
}

@-webkit-keyframes stretch-bounce {
  0% {
    -webkit-transform: scale(1);
  }
  25% {
    -webkit-transform: scale(1.5);
  }
  50% {
    -webkit-transform: scale(0.9);
  }
  75% {
    -webkit-transform: scale(1.2);
  }
  100% {
    -webkit-transform: scale(1);
  }
}
.selected:before {
  font-family: fontAwesome;
  display: inline-block;
  content: "\f005";
  position: absolute;
  top: 0;
  left: 0;
  -webkit-transform: scale(1);
  opacity: 1;
  z-index: 1;
}
.selected.pulse:before {
  -webkit-transform: scale(3);
  opacity: 0;
}
.selected.is-animated:before {
  transition: 1s ease-out;
}

.score {
  font-family: arial;
  font-size: 20px;
  color: green;
  margin-top: 20px;
  margin-left: 50px;
}

.score-rating {
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

.average {
  font-family: arial;
  font-size: 20px;
  color: green;
  text-align: center;
  margin-top: 60px;
  position: relative;
  width: 50%;
  float: left;
}
.average .score-average {
  padding-top: 30px;
  padding-bottom:30px;
  font-family: arial;
  font-size: 30px;
}

</style>
</head>
</html>