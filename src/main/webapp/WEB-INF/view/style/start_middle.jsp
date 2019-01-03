<!DOCTYPE html>
<html>
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<head>
<style>
body {
  font-family: "Squada One",sans-serif;
  background: #000e12;
  color: #daf6ff;
}

.bluelight {
  display: table;
  width: 200px;
  height: 200px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.bluelight a {
  display: table-cell;
  font-size: 3em;
  text-decoration: none;
  text-align: center;
  vertical-align: middle;
  border-radius: 50%;
  transition: background 1s, border-width 0.5s cubic-bezier(0.075, 0.82, 0.165, 1), text-shadow 0.5s;
  color: #daf6ff;
  text-shadow: 0 0 20px #0aafe6, 0 0 20px rgba(10, 175, 230, 0);
  box-shadow: 0 0 0 rgba(10, 175, 230, 0), inset 0 0 0 rgba(10, 175, 230, 0);
  background-image: radial-gradient(ellipse cover at center, rgba(10, 175, 230, 0) 0%, rgba(10, 175, 230, 0) 90%);
  border: 0 dotted rgba(10, 175, 230, 0);
}
.bluelight a:hover {
  color: #fff;
  text-shadow: 0 0 50px #0aafe6, 0 0 50px #0aafe6;
  background-image: radial-gradient(ellipse cover at center, rgba(10, 175, 230, 0.3) 0%, rgba(10, 175, 230, 0) 60%);
}
.bluelight:before, .bluelight:after, .bluelight a:before, .bluelight a:after {
  transition: 0.2s ease-in-out;
  content: "";
  display: block;
  position: absolute;
  border-radius: 50%;
  border: 60px dashed transparent;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.bluelight:before {
  animation: rotate 20s linear 0s infinite;
  width: 180%;
  height: 180%;
  border: 3px dotted rgba(10, 175, 230, 0);
  z-index: -1;
}
.bluelight:after {
  animation: rotate 10s linear 0s infinite reverse;
  border: 80px dashed rgba(10, 175, 230, 0);
  width: 160%;
  height: 160%;
  z-index: -2;
}
.bluelight a:before {
  animation: rotate 5s ease-in-out 0s infinite alternate;
  width: 120%;
  height: 120%;
  border: 50px dashed rgba(10, 175, 230, 0);
}
.bluelight a:after {
  animation: rotate 5s linear 0s infinite;
  border: 18px dashed rgba(10, 175, 230, 0);
  width: 120%;
  height: 120%;
}
.bluelight:hover:before {
  border-color: rgba(10, 175, 230, 0.3);
}
.bluelight:hover:after {
  border-color: rgba(10, 175, 230, 0.1);
}
.bluelight:hover a:before {
  border-color: rgba(10, 175, 230, 0.3);
}
.bluelight:hover a:after {
  border-color: rgba(10, 175, 230, 0.3);
}

@keyframes rotate {
  0% {
    transform: translate(-50%, -50%) rotate(0deg);
  }
  100% {
    transform: translate(-50%, -50%) rotate(360deg);
  }
}
p.caption {
  font-size: 0.7em;
  text-align: center;
  position: fixed;
  width: 100%;
  bottom: 0;
  letter-spacing: 0.2em;
  text-shadow: 0 0 20px #0aafe6, 0 0 20px rgba(10, 175, 230, 0);
}
</style>
</head>
</html>