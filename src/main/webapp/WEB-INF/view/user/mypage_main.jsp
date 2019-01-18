<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
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
<body>

<div class="container">
  <main>
    <div class="chart radar-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Household Expenditure</h3>
      <p class="tagline">Yearly</p>
      <canvas height="400" id="radarChartDark"></canvas>
    </div>
    <div class="chart radar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Household Expenditure</h3>
      <p class="tagline">Yearly</p>
      <canvas height="400" id="radarChartLight"></canvas>
    </div>
    <div class="chart polar-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Exports of goods</h3>
      <p class="tagline">2016 (in billion US$)</p>
      <canvas height="400" id="polarChartDark"></canvas>
    </div>
    <div class="chart polar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Exports of goods</h3>
      <p class="tagline">2016 (in billion US$)</p>
      <canvas height="400" id="polarChartLight"></canvas>
    </div>
    <div class="chart line-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">March 2016</h3>
      <p class="tagline">Area chart</p>
      <canvas height="400" id="lineChartDark"></canvas>
    </div>
    <div class="chart line-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">March 2016</h3>
      <p class="tagline">Area chart</p>
      <canvas height="400" id="lineChartLight"></canvas>
    </div>
    <div class="chart line-chart-curved dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">March 2016</h3>
      <p class="tagline">Area chart</p>
      <canvas height="400" id="lineChartCDark"></canvas>
    </div>
    <div class="chart line-chart-curved light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">March 2016</h3>
      <p class="tagline">Area chart</p>
      <canvas height="400" id="lineChartCLight"></canvas>
    </div>
    <div class="chart bar-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Monthly revenue</h3>
      <p class="tagline">2015 (in thousands US$)</p>
      <canvas height="400" id="barChartDark"></canvas>
    </div>
    <div class="chart bar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Monthly revenue</h3>
      <p class="tagline">2015 (in thousands US$)</p>
      <canvas height="400" id="barChartLight"></canvas>
    </div>
    <div class="chart bar-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Monthly revenue</h3>
      <p class="tagline">2015 (in thousands US$)</p>
      <canvas height="400" id="barChartHDark"></canvas>
    </div>
    <div class="chart bar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Monthly revenue</h3>
      <p class="tagline">2015 (in thousands US$)</p>
      <canvas height="400" id="barChartHLight"></canvas>
    </div>
    <div class="chart doughnut-chart dark">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Exports of Goods</h3>
      <p class="tagline">2015 (in billion US$)</p>
      <canvas height="400" id="doughnutChartDark"></canvas>
    </div>
    <div class="chart doughnut-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Exports of Goods</h3>
      <p class="tagline">2015 (in billion US$)</p>
      <canvas height="400" id="doughnutChartLight"></canvas>
    </div>
  </main>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
<script>
var Charts = /** @class */ (function () {
    function Charts() {
        this.colors = ["#DB66AE", "#8185D6", "#89D9DF", "#E08886"];
        this.tickColor = "#757681";
        this.initRadar();
        this.initPolar();
        this.initLine();
        this.initLineCurved();
        this.initBar();
        this.initBarHorizontal();
        this.initDoughnut();
    }
    Charts.prototype.initRadar = function () {
        var ctxD = $('#radarChartDark'), ctxL = $('#radarChartLight'), chartData = {
            type: 'radar',
            data: {
                labels: ["Education", "Food", "Transport", "Drinks", "Other"],
                datasets: [
                    {
                        label: "2014",
                        backgroundColor: this.convertHex(this.colors[0], 20),
                        borderColor: this.colors[0],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [51, 67, 90, 31, 16]
                    },
                    {
                        label: "2015",
                        backgroundColor: this.convertHex(this.colors[1], 20),
                        borderColor: this.colors[1],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [75, 44, 19, 22, 43]
                    },
                    {
                        label: "2015",
                        backgroundColor: this.convertHex(this.colors[2], 20),
                        borderColor: this.colors[2],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [7, 14, 29, 82, 33]
                    }
                ]
            },
            options: {
                scale: {
                    pointLabels: {
                        fontColor: this.tickColor
                    },
                    ticks: {
                        display: false,
                        stepSize: 25
                    }
                },
                legend: {
                    position: "bottom",
                    labels: {
                        boxWidth: 11,
                        fontColor: this.tickColor,
                        fontSize: 11
                    }
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initPolar = function () {
        var ctxD = $('#polarChartDark'), ctxL = $('#polarChartLight'), chartData = {
            type: 'polarArea',
            data: {
                datasets: [{
                        data: [41, 66, 71, 88],
                        borderWidth: 1,
                        backgroundColor: [
                            this.convertHex(this.colors[0], 60),
                            this.convertHex(this.colors[1], 60),
                            this.convertHex(this.colors[2], 60),
                            this.convertHex(this.colors[3], 60),
                        ],
                        hoverBackgroundColor: [
                            this.colors[0],
                            this.colors[1],
                            this.colors[2],
                            this.colors[3],
                        ]
                    }],
                labels: ["Brasil", "Germany", "India", "China"]
            },
            options: {
                scale: {
                    ticks: {
                        display: false,
                        stepSize: 25
                    }
                },
                legend: {
                    position: "bottom",
                    labels: {
                        boxWidth: 11,
                        fontColor: this.tickColor,
                        fontSize: 11
                    }
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initLine = function () {
        var ctxD = $("#lineChartDark"), ctxL = $("#lineChartLight"), chartData = {
            type: 'line',
            data: {
                labels: ["A", "B", "C", "D", "E", "F"],
                datasets: [
                    {
                        label: "Current",
                        fill: false,
                        lineTension: 0,
                        borderColor: this.colors[0],
                        pointBackgroundColor: this.colors[0],
                        pointBorderColor: "white",
                        pointBorderWidth: 1,
                        pointRadius: 4,
                        pointHoverBackgroundColor: this.colors[0],
                        pointHoverBorderColor: "white",
                        pointHoverBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHitRadius: 10,
                        data: [24, 109, 48, 157, 56, 165, 5]
                    },
                    {
                        label: "Last",
                        fill: false,
                        lineTension: 0,
                        borderColor: this.colors[1],
                        pointBackgroundColor: this.colors[1],
                        pointBorderColor: "white",
                        pointBorderWidth: 1,
                        pointRadius: 4,
                        pointHoverBackgroundColor: this.colors[1],
                        pointHoverBorderColor: "white",
                        pointHoverBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHitRadius: 10,
                        data: [130, 86, 69, 101, 127, 77, 44]
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 175,
                                stepSize: 25
                            }
                        }],
                    xAxes: [{
                            ticks: {
                                fontColor: this.tickColor
                            }
                        }]
                },
                legend: {
                    labels: {
                        boxWidth: 11,
                        fontColor: this.tickColor,
                        fontSize: 11
                    }
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initLineCurved = function () {
        var ctxD = $("#lineChartCDark"), ctxL = $("#lineChartCLight"), chartData = {
            type: 'line',
            data: {
                labels: ["A", "B", "C", "D", "E", "F"],
                datasets: [
                    {
                        label: "Current",
                        lineTension: 0.3,
                        borderColor: this.colors[0],
                        backgroundColor: this.convertHex(this.colors[0], 50),
                        pointBorderColor: "white",
                        pointBackgroundColor: this.colors[0],
                        pointBorderWidth: 0,
                        pointHoverRadius: 0,
                        pointHoverBackgroundColor: this.colors[0],
                        pointHoverBorderColor: "white",
                        pointHoverBorderWidth: 0,
                        pointRadius: 0,
                        pointHitRadius: 10,
                        data: [83, 109, 88, 117, 81, 95, 95]
                    },
                    {
                        label: "Last",
                        lineTension: 0.3,
                        borderColor: this.colors[1],
                        backgroundColor: this.convertHex(this.colors[1], 50),
                        pointBackgroundColor: this.colors[1],
                        pointBorderColor: "white",
                        pointBorderWidth: 0,
                        pointRadius: 0,
                        pointHoverBackgroundColor: this.colors[1],
                        pointHoverBorderColor: "white",
                        pointHoverBorderWidth: 0,
                        pointHoverRadius: 0,
                        pointHitRadius: 10,
                        data: [130, 86, 69, 101, 127, 77, 44]
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 175,
                                stepSize: 25
                            }
                        }],
                    xAxes: [{
                            ticks: {
                                fontColor: this.tickColor
                            }
                        }]
                },
                legend: {
                    labels: {
                        boxWidth: 11,
                        fontColor: this.tickColor,
                        fontSize: 11
                    }
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initBar = function () {
        var ctxD = $("#barChartDark"), ctxL = $("#barChartLight"), chartData = {
            type: 'bar',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                        data: [27, 59, 18, 26, 79, 55, 36, 23, 44, 30, 55, 64],
                        backgroundColor: this.colors[0],
                        hoverBackgroundColor: this.convertHex(this.colors[0], 70)
                    },
                    {
                        data: [36, 23, 44, 30, 79, 55, 61, 14, 27, 59, 18, 91],
                        backgroundColor: this.colors[1],
                        hoverBackgroundColor: this.convertHex(this.colors[1], 70)
                    },
                    {
                        data: [28, 31, 87, 61, 14, 27, 59, 18, 96, 26, 79, 14],
                        backgroundColor: this.colors[2],
                        hoverBackgroundColor: this.convertHex(this.colors[2], 70)
                    }]
            },
            options: {
                scales: {
                    xAxes: [{
                            stacked: true,
                            ticks: {
                                fontColor: this.tickColor
                            },
                            gridLines: {
                                drawOnChartArea: false
                            }
                        }],
                    yAxes: [{
                            stacked: true,
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 175,
                                stepSize: 25
                            }
                        }]
                },
                legend: {
                    display: false
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initBarHorizontal = function () {
        var ctxD = $("#barChartHDark"), ctxL = $("#barChartHLight"), chartData = {
            type: 'horizontalBar',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                        data: [27, 59, 68, 26, 79, 55, 36, 43, 44, 30, 55, 64],
                        backgroundColor: this.colors[0],
                        hoverBackgroundColor: this.convertHex(this.colors[0], 70)
                    },
                    {
                        data: [136, 23, 44, 30, 79, 55, 61, 94, 27, 59, 98, 91],
                        backgroundColor: this.colors[1],
                        hoverBackgroundColor: this.convertHex(this.colors[1], 70)
                    },
                    {
                        data: [88, 31, 87, 61, 77, 27, 59, 58, 136, 26, 79, 85],
                        backgroundColor: this.colors[2],
                        hoverBackgroundColor: this.convertHex(this.colors[2], 70)
                    }]
            },
            options: {
                barThickness: 10,
                scales: {
                    xAxes: [{
                            stacked: true,
                            ticks: {
                                fontColor: this.tickColor
                            },
                            gridLines: {
                                drawOnChartArea: false
                            }
                        }],
                    yAxes: [{
                            stacked: true,
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 175,
                                stepSize: 25
                            }
                        }]
                },
                legend: {
                    display: false
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.initDoughnut = function () {
        var ctxD = $('#doughnutChartDark'), ctxL = $('#doughnutChartLight'), chartData = {
            type: 'doughnut',
            data: {
                labels: ["Brasil", "India", "China"],
                datasets: [{
                        data: [300, 50, 100],
                        borderWidth: 0,
                        backgroundColor: [
                            this.convertHex(this.colors[0], 60),
                            this.convertHex(this.colors[1], 60),
                            this.convertHex(this.colors[2], 60),
                        ],
                        hoverBackgroundColor: [
                            this.colors[0],
                            this.colors[1],
                            this.colors[2],
                        ]
                    }]
            },
            options: {
                responsive: true,
                legend: {
                    position: "bottom",
                    labels: {
                        boxWidth: 11,
                        fontColor: this.tickColor,
                        fontSize: 11
                    }
                }
            }
        }, myDarkRadarChart = new Chart(ctxD, chartData), myLightRadarChart = new Chart(ctxL, chartData);
    };
    Charts.prototype.convertHex = function (hex, opacity) {
        hex = hex.replace('#', '');
        var r = parseInt(hex.substring(0, 2), 16);
        var g = parseInt(hex.substring(2, 4), 16);
        var b = parseInt(hex.substring(4, 6), 16);
        var result = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity / 100 + ')';
        return result;
    };
    return Charts;
}());
new Charts();

</script>
</body>
</html>