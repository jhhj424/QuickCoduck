<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* common styles !!!YOU DON'T NEED THEM  */
body {
  font-family: 'Niramit', sans-serif;
  font-size: 16px;
  color: #101010;
}

.container {
  width: 950px;
  margin: 50px auto 0px auto;
  text-align: center;
}

h1 {
  margin: 0;
  font-weight: 400;
  font-size: 35px;
}
h1 span {
  font-family: 'Mali', cursive;
  font-weight: bold;
  color: #7A306C;
}

.link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 80%;
  margin: 30px auto 0;
}
.link a {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
  display: inline-flex;
  align-items: center;
  margin-right: 20px;
  font-size: 17px;
  color: #1f1f1f;
  text-decoration: none;
}
.link a:last-child {
  margin-right: 0;
}
.link a:hover {
  color: #7A306C;
}
.link a i {
  color: #7A306C;
  margin-right: 5px;
}

.content-block {
  margin-top: 50px;
}
.content-block h2 {
  margin-bottom: 30px;
}

.content-block__effect {
  margin-bottom: 50px;
}

/* effects styles !!!YOU NEED THEM */
/* don't forget to add your own colors and parameters */
.portfolio-effect {
  display: flex;
  justify-content: space-between;
}

.portfolio-item {
  position: relative;
  overflow: hidden;
  width: 300px;
  height: 300px;
}
.portfolio-item img {
  position: absolute;
  top: 50%;
  left: 50%;
  width: auto;
  height: auto;
  min-width: 100%;
  min-height: 100%;
  max-width: 100%;
  max-height: 100%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
}

.portfolio-item__info {
  position: absolute;
  top: 7px;
  left: 7px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: calc(100% - 2 * 7px);
  height: calc(100% - 2 * 7px);
  background-color: rgba(200, 200, 200, 0.6);
}

.portfolio-item__header {
  position: relative;
  margin: 0 0 20px 0;
  padding: 15px 0;
  font-size: 22px;
  text-transform: uppercase;
  letter-spacing: 2px;
}
.portfolio-item__header:after {
  position: absolute;
  left: 0;
  bottom: 0;
  display: block;
  height: 2px;
  width: 100%;
  content: '';
  background-color: #8D909B;
}

.portfolio-item__links {
  display: flex;
}

.portfolio-item__link-block {
  position: relative;
  width: 35px;
  height: 35px;
  margin-right: 10px;
}
.portfolio-item__link-block:last-child {
  margin-right: 0;
}

.portfolio-item__link {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  color: #101010;
  text-decoration: none;
  border: 1px solid #101010;
  border-radius: 50%;
}
.portfolio-item__link:hover {
  color: #fff;
  background-color: #101010;
}

/* EFFECT #1 STYLES */
.portfolio-item--eff1 .portfolio-item__info {
  -webkit-transform: scale(1.1);
          transform: scale(1.1);
  opacity: 0;
}
.portfolio-item--eff1 .portfolio-item__header {
  top: -10px;
  opacity: 0;
}
.portfolio-item--eff1 .portfolio-item__header:after {
  -webkit-transform: scaleX(0);
          transform: scaleX(0);
}
.portfolio-item--eff1 .portfolio-item__link-block {
  top: 20px;
  opacity: 0;
}

.portfolio-item--eff1:hover .portfolio-item__info {
  transition-property: all;
  transition-duration: 0.4s;
  transition-timing-function: linear;
  transition-delay: 0s;
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff1:hover .portfolio-item__header {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.45s;
  top: 0;
  opacity: 1;
}
.portfolio-item--eff1:hover .portfolio-item__header:after {
  transition-property: all;
  transition-duration: 0.3s;
  transition-timing-function: cubic-bezier(0.63, 0.01, 0, 1.39);
  transition-delay: 0.65s;
  -webkit-transform: scaleX(1);
          transform: scaleX(1);
}
.portfolio-item--eff1:hover .portfolio-item__link-block {
  top: 0;
  opacity: 1;
}
.portfolio-item--eff1:hover .portfolio-item__link-block:first-child {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.85s;
}
.portfolio-item--eff1:hover .portfolio-item__link-block:nth-child(2) {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.95s;
}

/* EFFECT #2 STYLES */
.portfolio-item--eff2 .portfolio-item__info {
  top: -100%;
}
.portfolio-item--eff2 .portfolio-item__header {
  left: -25px;
  opacity: 0;
}
.portfolio-item--eff2 .portfolio-item__header:after {
  -webkit-transform: scaleX(0);
          transform: scaleX(0);
  -webkit-transform-origin: right center;
          transform-origin: right center;
}
.portfolio-item--eff2 .portfolio-item__link-block {
  -webkit-transform: scale(1.2);
          transform: scale(1.2);
  opacity: 0;
}

.portfolio-item--eff2:hover .portfolio-item__info {
  transition-property: all;
  transition-duration: 0.35s;
  transition-timing-function: cubic-bezier(0.63, 0.01, 0, 1.39);
  transition-delay: 0s;
  top: 7px;
}
.portfolio-item--eff2:hover .portfolio-item__header {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.45s;
  left: 0;
  opacity: 1;
}
.portfolio-item--eff2:hover .portfolio-item__header:after {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.6s;
  -webkit-transform: scaleX(1);
          transform: scaleX(1);
}
.portfolio-item--eff2:hover .portfolio-item__link-block {
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff2:hover .portfolio-item__link-block:first-child {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.85s;
}
.portfolio-item--eff2:hover .portfolio-item__link-block:nth-child(2) {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.95s;
}

/* EFFECT #3 STYLES */
.portfolio-item--eff3 .portfolio-item__info {
  transition-property: -webkit-transform;
  transition-property: transform;
  transition-property: transform, -webkit-transform;
  transition-duration: 0.3s;
  transition-timing-function: linear;
  transition-delay: 0s;
  -webkit-transform: scale(0, 1);
          transform: scale(0, 1);
  -webkit-transform-origin: right top;
          transform-origin: right top;
}
.portfolio-item--eff3 .portfolio-item__header {
  -webkit-transform: scale(0.4);
          transform: scale(0.4);
  opacity: 0;
}
.portfolio-item--eff3 .portfolio-item__header:after {
  bottom: -20px;
  opacity: 0;
}
.portfolio-item--eff3 .portfolio-item__link-block {
  opacity: 0;
}
.portfolio-item--eff3 .portfolio-item__link-block:first-child {
  -webkit-transform: translateX(-50%);
          transform: translateX(-50%);
}
.portfolio-item--eff3 .portfolio-item__link-block:nth-child(2) {
  -webkit-transform: translateX(50%);
          transform: translateX(50%);
}

.portfolio-item--eff3:hover .portfolio-item__info {
  transition-property: -webkit-transform;
  transition-property: transform;
  transition-property: transform, -webkit-transform;
  transition-duration: 0.3s;
  transition-timing-function: linear;
  transition-delay: 0s;
  -webkit-transform: scale(1, 1);
          transform: scale(1, 1);
  -webkit-transform-origin: left top;
          transform-origin: left top;
}
.portfolio-item--eff3:hover .portfolio-item__header {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.45s;
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff3:hover .portfolio-item__header:after {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.6s;
  bottom: 0;
  opacity: 1;
}
.portfolio-item--eff3:hover .portfolio-item__link-block {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.85s;
  -webkit-transform: translateX(0);
          transform: translateX(0);
  opacity: 1;
}

/* EFFECT #4 STYLES */
.portfolio-item--eff4 .portfolio-item__info {
  -webkit-transform: scale(0.4);
          transform: scale(0.4);
  opacity: 0;
}
.portfolio-item--eff4 .portfolio-item__header {
  -webkit-transform: scale(1.3);
          transform: scale(1.3);
  opacity: 0;
}
.portfolio-item--eff4 .portfolio-item__header:after {
  -webkit-transform: scaleX(1.3);
          transform: scaleX(1.3);
  opacity: 0;
}
.portfolio-item--eff4 .portfolio-item__link-block {
  -webkit-transform: scale(0);
          transform: scale(0);
  opacity: 0;
}

.portfolio-item--eff4:hover .portfolio-item__info {
  transition-property: all;
  transition-duration: 0.3s;
  transition-timing-function: linear;
  transition-delay: 0s;
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff4:hover .portfolio-item__header {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.45s;
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff4:hover .portfolio-item__header:after {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.65s;
  -webkit-transform: scaleX(1);
          transform: scaleX(1);
  opacity: 1;
}
.portfolio-item--eff4:hover .portfolio-item__link-block {
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff4:hover .portfolio-item__link-block:first-child {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.85s;
}
.portfolio-item--eff4:hover .portfolio-item__link-block:nth-child(2) {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.95s;
}

/* EFFECT #5 STYLES */
.portfolio-item--eff5 .portfolio-item__info {
  -webkit-transform: scale(0.4);
          transform: scale(0.4);
  -webkit-transform-origin: right top;
          transform-origin: right top;
  opacity: 0;
}
.portfolio-item--eff5 .portfolio-item__header {
  opacity: 0;
}
.portfolio-item--eff5 .portfolio-item__header:after {
  height: 100%;
  opacity: 0;
}
.portfolio-item--eff5 .portfolio-item__link-block {
  opacity: 0;
}
.portfolio-item--eff5 .portfolio-item__link-block:first-child {
  -webkit-transform: translateX(30%);
          transform: translateX(30%);
}
.portfolio-item--eff5 .portfolio-item__link-block:nth-child(2) {
  -webkit-transform: translateX(-30%);
          transform: translateX(-30%);
}

.portfolio-item--eff5:hover .portfolio-item__info {
  transition-property: all;
  transition-duration: 0.3s;
  transition-timing-function: linear;
  transition-delay: 0s;
  -webkit-transform: scale(1);
          transform: scale(1);
  opacity: 1;
}
.portfolio-item--eff5:hover .portfolio-item__header {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.45s;
  opacity: 1;
}
.portfolio-item--eff5:hover .portfolio-item__header:after {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.65s;
  height: 2px;
  opacity: 1;
}
.portfolio-item--eff5:hover .portfolio-item__link-block {
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0.85s;
  -webkit-transform: translate(0);
          transform: translate(0);
  opacity: 1;
}

</style>
</head>
</html>