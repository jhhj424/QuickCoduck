<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../workpic/QuickCoduck.jpg" rel="shortcut icon" type="image/x-icon">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function() {
	  
    var N = 0;
    var K = 0;
    var tt
    
    START();

    function START() {
      tt = setInterval(NEXT, 3000);
    }

    function NEXT() {

      if( N < $('.photo-slider-img').length - 1 ) {
        N++;
      } else {
        N = 0;
      }

      CHANGE();
    }

    function CHANGE() {
      K = 1;   
      $('.photo-slider-img.NOW').stop().animate({left: '-100%'}, 500);
      $('.photo-slider-img').eq(N).stop().css({left: '100%'}).animate({left: 0}, 500, OK);
    }

    function OK() {
      K = 0;
      $('.photo-page').removeClass('active').eq(N).addClass('active');
      $('.photo-slider-img').removeClass('NOW').eq(N).addClass('NOW');
    }



    $('.photo-page').on('click', function() {

      if( $(this).index() == N || K == 1 ) return;
      
      if ( tt ) {
         clearInterval( tt );
         tt = 0;
         N = $(this).index();
         CHANGE();
         START();
       }
    });

});

</script>
<style type="text/css">
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif;}
html, body.b1 {
	font-family: "Roboto", sans-serif;
	font-size: 11px;
	line-height: 1.5;
	background-color:#FEFEFE;
}

.table14_11 table {
	width: 100%;
	margin: 15px 0;
	border: 0;
}

.table14_11 th {
	font-weight: bold;
	background-color: #cde6fe;
	color: #2052fe;
	font-size: large;
}

.table14_10, .table14_10 th, .table14_10 td {
	font-size: 0.99em;
	text-align: center;
	padding: 4px;
	border-collapse: collapse;
	font-style: normal;
}

.table14_10 th, .table14_10 td {
	border: 1px solid #ffffff;
	border-width: 1px
}

.table14_10 th {
	border: 1px solid #cde6fe;
	border-width: 1px 0 1px 0
}

.table14_10 tr {
	border: 1px solid #ffffff;
}

.table14_10 tr:nth-child(odd) {
	background-color: #f7f7f7;
}

.table14_10 tr:nth-child(even) {
	background-color: #ffffff;
}

.table14_10 td {
	border: 1px solid #eeeeee;
	border-width: 2px 2px 2px 2px;
}
</style>
<style>
body, html {
  height: 100%;
  line-height: 1.8;
  background-color:#FEFEFE;
}
/* Full height image header */
.bgimg-1 {
  background-position: center;
  background-size: cover;
  min-height: 55%;
}
.project {
 border-color: 1px solid gray;
}

.w3-bar .w3-button {
  padding: 12px;
  margin:10px 15px 10px 15px;
}
</style>
<style>
.container2 {
    width: 100%;
    overflow: hidden;
    margin: 0 auto;
}

.row {
    overflow: hidden;
}

.photo-slider {
    width: 100%;
    overflow: hidden;
    height: 650px;
    position: relative;
    -webkit-box-shadow: 0px 5px 5px black; 
    box-shadow: 0px 5px 5px black;       
}

.photo-slider .photo-slider-img {
    width: 100%;
    height: auto;
    position: absolute;
    left: 100%;
    top: 0
}

.photo-slider .photo-slider-img.NOW {
    left: 0
}

.photo-controls {
    width: 100%;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    text-align: center;
    margin-top: 10px
}

.photo-pagination .photo-page {
    cursor: pointer;
    display: inline-block;
    zoom:1}

.photo-pagination .photo-page span {
    display: block;
    width: 12px;
    height: 12px;
    margin: 5px 7px;
    filter: Alpha(Opacity=50);
    opacity: 0.5;
    border-radius: 20px;
    background: #869791
}

.photo-pagination .photo-page.active span {
    filter: Alpha(Opacity=100);
    opacity: 1
}

</style>
</head>
</html>