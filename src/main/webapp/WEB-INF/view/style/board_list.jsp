<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.pagenation {
	position: relative;
	text-align: center;
	margin: 1em auto;
}

a {
	color: #000;
	text-decoration: none;
}

a:hover {
	color: #CECECE;
}


.pager-home {
	display: inline-block;
}

.pager-arrow {
	position: absolute;
	top: 0;
	display: table;
	vertical-align: middle;
}

.pager-arrow-next {
	left: .5em;
}
. pager-arrow-border {
     transform : rotate( -135deg);
	-webkit-transform: rotate(-135deg);
	-ms-transform: rotate(-135deg);
}
.pager-arrow-prev {
	right: .5em;
}
. pager-arrow-border {
     transform : rotate( 45deg);
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
}
.pager-arrow-border {
	display: table-cell;
	width: 1.5em;
	height: 1.5em;
}

.pager-arrow-mask {
	position: relative;
	display: block;
	width: 100%;
	height: 100%;
	background: #7d97a5;
	top: 1px;
	right: 1px;
}

.pager-arrow-label {
	display: table-cell;
	text-align: right;
	vertical-align: middle;
	position: relative;
	z-index: 2;
}
</style>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
input.delete{
-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    max-width: 180px;
    text-decoration: none;
    border-radius: 4px;
    padding: 10px 10px;
    font-weight:bold;
}
	
	input.delete[type=submit]{
    color: #000;
    box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}
input.delete[type=submit]:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow:#327a81 0 0px 0px 40px inset;
}
body * {
	box-sizing: border-box;
}

.header {
	background-color: #7d97a5;
	color: white;
	font-size: 1.5em;
	padding: 1rem;
	text-align: center;
	border:1px solid grey;
    border-radius: 3px;
}

.table-users {
	border: 1px solid #4d636f;
	border-radius: 10px;
	box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
	max-width: calc(100% - 2em);
	margin: 1em auto;
	overflow: hidden;
	width: 100%;
}

table {
	width: 100%;
}

table td, table th {
	padding: 10px;
}

table td {
	text-align: center;
	vertical-align: middle;
	border:1px solid #a9a9a9a1;
    border-radius: 3px;
}

table td.buttom {
	text-align: right;
	border:1px solid #a9a9a9a1;
	border-radius: 3px;
	vertical-align: middle;
}

table td.subject {
	text-align: left;
	vertical-align: middle;
}

table td:last-child {
	font-size: 0.95em;
	line-height: 1.4;
	text-align: middle;
}

table th {
	background-color: #fefefe;
	border:1px solid #a9a9a9a1;
	border-radius: 3px;
	font-weight: 300;
}

table tr:nth-child(2n) {
	background-color: white;
	border:1px solid grey;
	border-radius: 3px;
}

table tr:nth-child(2n+1) {
	background-color: #fefefe;
	border:1px solid grey;
	border-radius: 3px;
}
sup.admin{
color:#2ac1bc;
font-weight:bold;
font-size:15px;
}
sup.user{
color:#000;
font-weight:bold;
font-size:15px;
}

@media screen and (max-width: 700px) {
	table, tr, td {
		display: block;
		border:1px solid grey;
	border-radius: 3px;
	}
	td:first-child {
		position: absolute;
		top: 50%;
		-webkit-transform: translateY(-50%);
		transform: translateY(-50%);
		width: 100px;
	}
	td:not (:first-child ) {
		clear: both;
		margin-left: 100px;
		padding: 4px 20px 4px 90px;
		position: relative;
		text-align: left;
	}
	td:not (:first-child ):before {
		color: #91ced4;
		border:1px solid grey;
	border-radius: 3px;
		content: '';
		display: block;
		left: 0;
		position: absolute;
	}
	td:nth-child(2):before {
		content: 'Name:';
	}
	td:nth-child(3):before {
		content: 'Email:';
	}
	td:nth-child(4):before {
		content: 'Phone:';
	}
	td:nth-child(5):before {
		content: 'Comments:';
	}
	tr {
		padding: 10px 0;
		position: relative;
		border:1px solid grey;
	    border-radius: 3px;
	}
	tr:first-child {
		display: none;
	}
}

@media screen and (max-width: 500px) {
	.header {
		background-color: transparent;
		color: white;
		font-size: 2em;
		font-weight: 700;
		padding: 0;
		text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
	}
	img {
		border: 3px solid;
		border-color: #daeff1;
		height: 100px;
		width: 100px;
	}
	td:first-child {
		background-color: #c8e7ea;
		border-bottom: 1px solid #91ced4;
		border-radius: 10px 10px 0 0;
		position: relative;
		top: 0;
		-webkit-transform: translateY(0);
		transform: translateY(0);
		width: 100%;
	}
	td:not (:first-child ) {
		margin: 0;
		padding: 5px 1em;
		width: 100%;
		border:1px solid grey;
	    border-radius: 3px;
	}
	td:not (:first-child ):before {
		font-size: .8em;
		padding-top: 0.3em;
		position: relative;
		border:1px solid grey;
	    border-radius: 3px;
	}
	td:last-child {
		padding-bottom: 1rem !important;
		border:1px solid grey;
	    border-radius: 3px;
	}
	tr {
		background-color: white !important;
		border:1px solid grey;
	    border-radius: 3px;
		box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
		margin: 0.5rem 0;
		padding: 0;
	}
	.table-users {
		border:1px solid grey;
	    border-radius: 3px;
		overflow: visible;
	}
	#wrap {
		position: relative;
		width: auto;
		padding: 10px;
		border:1px solid grey;
	    border-radius: 3px;
		background: #f1f1f1;
		padding-right: 200px;
		padding-left: 200px
	}
}
</style>
</head>
</html>