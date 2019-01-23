<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/user_mypage_main_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="container">
  <main>
    <div class="chart radar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">회원 평균 점수</h3>
      <p class="tagline">${loginUser.rating } / 5 (5점 만점)</p>
      <canvas height="400" id="radarChartLight"></canvas>
    </div>
    <div class="chart polar-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">Top 5 Technology</h3>
      <p class="tagline">QuickCoduck (in 2018, from Development)</p>
      <canvas height="400" id="polarChartLight"></canvas>
    </div>
    <div class="chart line-chart light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">개발자 기술 / 클라이언트 프로젝트 기술</h3>
      <p class="tagline">5% in / 100%</p>
      <canvas height="400" id="lineChartLight"></canvas>
    </div>
    <div class="chart line-chart-curved light">
      <div class="header"><span class="left glyphicon glyphicon-menu-hamburger"></span><span class="right glyphicon glyphicon-cog"></span></div>
      <h3 class="title">프로젝트 평균금액</h3>
      <p class="tagline"> &#8361; 1,000,000  단위</p>
      <canvas height="400" id="lineChartCLight"></canvas>
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
    }
    Charts.prototype.initRadar = function () {
    	var userprofess = ${avguser.profess}
    	userprofess = userprofess.toFixed(2);
        var ctxD = $('#radarChartDark'), ctxL = $('#radarChartLight'), chartData = {
            type: 'radar',
            data: {
                labels: ["전문성", "적극성", "만족도", "일정준수", "의사소통"],
                datasets: [
                    {
                        label: "개발자",
                        backgroundColor: this.convertHex(this.colors[0], 20),
                        borderColor: this.colors[0],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [userprofess,${avguser.proaction}.toFixed(2),${avguser.prosatisfact}.toFixed(2),${avguser.prodate}.toFixed(2),${avguser.procommunicate}.toFixed(2)]
                    },
                    {
                        label: "클라이언트",
                        backgroundColor: this.convertHex(this.colors[1], 20),
                        borderColor: this.colors[1],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [${avgclient.profess}.toFixed(2),${avgclient.proaction}.toFixed(2),${avgclient.prosatisfact}.toFixed(2),${avgclient.prodate}.toFixed(2),${avgclient.procommunicate}.toFixed(2)]
                    },
                    {
                        label: "사용자",
                        backgroundColor: this.convertHex(this.colors[2], 20),
                        borderColor: this.colors[2],
                        borderWidth: 1,
                        pointRadius: 2,
                        data: [${loginUser.profess}.toFixed(2), ${loginUser.proaction}.toFixed(2),${loginUser.prosatisfact}.toFixed(2),${loginUser.prodate}.toFixed(2),${loginUser.procommunicate}.toFixed(2)]
                    }
                ]
            },
            options: {
                scale: {
                    pointLabels: {
                        fontColor: this.tickColor
                    },
                    ticks: {
                    	beginAtZero: true ,
                        display: false,
                        stepSize: 1.0
                    }
                },
                legend: {
                    position: "bottom",
                    labels: {
                        boxWidth: 10,
                        fontColor: this.tickColor,
                        fontSize: 12
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
                        data: [
                <c:forEach var="tvalue" items="${top5_value}" varStatus="g" begin="0">
                   ${tvalue},
                <c:out value="${g.end}" />
                </c:forEach>
                        	],
                        borderWidth: 1,
                        backgroundColor: [
                            this.convertHex(this.colors[0], 60),
                            this.convertHex(this.colors[1], 60),
                            this.convertHex(this.colors[2], 60),
                            "rgba(52,152,219,0.4)", 
                            "rgba(12,152,19,0.4)", 
                        ],
                        hoverBackgroundColor: [
                            this.colors[0],
                            this.colors[1],
                            this.colors[2],
                        ]
                    }],
                labels: [
                	<c:forEach var="tkey" items="${top5_key}" varStatus="h" begin="0">
                	"${tkey}",
                	<c:out value="${h.end}"/>
                	</c:forEach>
                ]
            },
            options: {
                scale: {
                    ticks: {
                        display: false,
                        stepSize: 5
                    }
                },
                legend: {
                    position: "bottom",
                    labels: {
                        boxWidth: 5,
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
                labels: [<c:forEach var="ukey" items="${user_key}" varStatus="a" begin="0">
            	"${ukey}",
            	<c:out value="${a.end}"/>
            	</c:forEach>],
                datasets: [
                    {
                        label: "개발자",
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
                        data: [
                        	<c:forEach var="uvalue" items="${user_value}" varStatus="b" begin="0">
                        	"${uvalue}",
                        	<c:out value="${b.end}"/>
                        	</c:forEach>
                        	]
                    },
                    {
                        label: "클라이언트",
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
                        data: [
                        	<c:forEach var="cvalue" items="${client_value}" varStatus="c" begin="0">
                        	"${cvalue}",
                        	<c:out value="${c.end}"/>
                        	</c:forEach>
                        ]
                    },
                    {
                        label: "프로젝트 공고",
                        fill: false,
                        lineTension: 0,
                        borderColor: this.colors[2],
                        pointBackgroundColor: this.colors[2],
                        pointBorderColor: "white",
                        pointBorderWidth: 1,
                        pointRadius: 4,
                        pointHoverBackgroundColor: this.colors[2],
                        pointHoverBorderColor: "white",
                        pointHoverBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHitRadius: 10,
                        data: [
                        	<c:forEach var="pvalue" items="${project_value}" varStatus="t" begin="0">
                        	"${pvalue}",
                        	<c:out value="${t.end}"/>
                        	</c:forEach>
                        ]
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 50,
                                stepSize: 5
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
                labels: ["500만원", "1000만원", "2500만원", "5000만원", "7500만원", "10000만원"],
                datasets: [
                    {
                        label: "QuickCoduck 평균",
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
                        data: [
                        	<c:forEach var="pcnt" items="${price_cnt}" varStatus="i" begin="0">
                        	"${pcnt}",
                        	<c:out value="${i.end}"/>
                        	</c:forEach>
                        ]
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                fontColor: this.tickColor,
                                min: 0,
                                max: 55,
                                stepSize: 5
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