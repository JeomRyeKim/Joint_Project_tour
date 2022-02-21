<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
.header2_header {
	width: 80%;
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	grid-template-rows: 40px;
	column-gap: 15px;
	margin: auto;
}

.header2_items {
	
	text-align: center;
	position: relative;
	top: 47%;
	transform: translateY(-50%);
}

.header2_header a {
	border: 1px solid black;
	border-radius: 10px;
	text-decoration: none;
	font-weight: 1000;
	color: black;
}

.header2_Container{
	padding:10px 0;
	position: sticky;
 	top: 0;
 	z-index: 10;
 	background-color: white;
 	margin-top: 1px;
}
</style>
</head>
<body>

	<div class="header2_Container">
		<div class="header2_header">
			<a href="local?c_local=서울">
				<div class="header2_items">서울</div>
			</a> 
			<a href="local?c_local=경기도">
				<div class="header2_items">경기도</div>
			</a>
			 <a href="local?c_local=강원도">
				<div class="header2_items">강원도</div>
			</a> 
			<a href="local?c_local=충청도">
				<div class="header2_items">충청도</div>
			</a>
			<a href="local?c_local=경상도">
				<div class="header2_items">경상도</div>
			</a>
			<a href="local?c_local=전라도">
				<div class="header2_items">전라도</div>
			</a>
			<a href="local?c_local=제주도">
				<div class="header2_items">제주도</div>
			</a>
		</div>
	</div>
</body>
</html>