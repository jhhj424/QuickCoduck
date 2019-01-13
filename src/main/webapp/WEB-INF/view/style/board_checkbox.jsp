<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
label {
  cursor: pointer;
  position: relative;
  display: flex;
  align-items: center;
}

/*================ */
.usetech_develop:not(:checked),
.usetech_develop:checked {
  position: absolute;
  left: -9999px;
}

/* checkbox effect #6 */
.usetech_develop:not(:checked) + label:before,
.usetech_develop:checked + label:before {
  content: "";
  display: inline-block;
  width: 16px;
  height: 16px;
  border: 2px solid #5a5a5a;
  box-sizing: border-box;
  border-radius: 3px;
  margin-right: 20px;
}

.usetech_develop:not(:checked) + label:after,
.usetech_develop:checked + label:after {
  content: "\f00c";
  font-family: fontawesome;
  font-size: 21px;
  display: flex;
  height: 100%;
  align-items: center;
  position: absolute;
  top: -2px;
  left: 1px;
  color: #C42021;
  text-shadow: 0px -1px 0px #fff;
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.usetech_develop:not(:checked) + label:after {
  -webkit-transform: scale(1, 0);
          transform: scale(1, 0);
}

.usetech_develop:checked + label:after {
  -webkit-transform: scale(1, 1);
          transform: scale(1, 1);
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
}

/*================ */
.usetech_design:not(:checked),
.usetech_design:checked {
  position: absolute;
  left: -9999px;
}

/* checkbox effect #6 */
.usetech_design:not(:checked) + label:before,
.usetech_design:checked + label:before {
  content: "";
  display: inline-block;
  width: 16px;
  height: 16px;
  border: 2px solid #5a5a5a;
  box-sizing: border-box;
  border-radius: 3px;
  margin-right: 20px;
}

.usetech_design:not(:checked) + label:after,
.usetech_design:checked + label:after {
  content: "\f00c";
  font-family: fontawesome;
  font-size: 21px;
  display: flex;
  height: 100%;
  align-items: center;
  position: absolute;
  top: -2px;
  left: 1px;
  color: #C42021;
  text-shadow: 0px -1px 0px #fff;
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.usetech_design:not(:checked) + label:after {
  -webkit-transform: scale(1, 0);
          transform: scale(1, 0);
}

.usetech_design:checked + label:after {
  -webkit-transform: scale(1, 1);
          transform: scale(1, 1);
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
}
/*================ */
.checkall_develop:not(:checked),
.checkall_develop:checked {
  position: absolute;
  left: -9999px;
}

/* checkbox effect #6 */
.checkall_develop:not(:checked) + label:before,
.checkall_develop:checked + label:before {
  content: "";
  display: inline-block;
  width: 16px;
  height: 16px;
  border: 2px solid #5a5a5a;
  box-sizing: border-box;
  border-radius: 3px;
  margin-right: 20px;
}

.checkall_develop:not(:checked) + label:after,
.checkall_develop:checked + label:after {
  content: "\f00c";
  font-family: fontawesome;
  font-size: 21px;
  display: flex;
  height: 100%;
  align-items: center;
  position: absolute;
  top: -2px;
  left: 1px;
  color: #C42021;
  text-shadow: 0px -1px 0px #fff;
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.checkall_develop:not(:checked) + label:after {
  -webkit-transform: scale(1, 0);
          transform: scale(1, 0);
}

.checkall_develop:checked + label:after {
  -webkit-transform: scale(1, 1);
          transform: scale(1, 1);
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
}
/*================ */
.checkall_design:not(:checked),
.checkall_design:checked {
  position: absolute;
  left: -9999px;
}

/* checkbox effect #6 */
.checkall_design:not(:checked) + label:before,
.checkall_design:checked + label:before {
  content: "";
  display: inline-block;
  width: 16px;
  height: 16px;
  border: 2px solid #5a5a5a;
  box-sizing: border-box;
  border-radius: 3px;
  margin-right: 20px;
}

.checkall_design:not(:checked) + label:after,
.checkall_design:checked + label:after {
  content: "\f00c";
  font-family: fontawesome;
  font-size: 21px;
  display: flex;
  height: 100%;
  align-items: center;
  position: absolute;
  top: -2px;
  left: 1px;
  color: #C42021;
  text-shadow: 0px -1px 0px #fff;
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.checkall_design:not(:checked) + label:after {
  -webkit-transform: scale(1, 0);
          transform: scale(1, 0);
}

.checkall_design:checked + label:after {
  -webkit-transform: scale(1, 1);
          transform: scale(1, 1);
  transition-property: all;
  transition-duration: 0.2s;
  transition-timing-function: linear;
  transition-delay: 0s;
}

</style>
</head>
</html>