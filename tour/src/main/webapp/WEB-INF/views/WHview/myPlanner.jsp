<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../header1.jsp" %>
<%@include file="./bootStrap.jsp"%>
	<!-- 이미지 위치 -->
	<div class="jumbotron">
		<h2>이미지</h2>
	</div>
	<!-- left -->
	<div class="aside-left">
		<h3>마이페이지</h3>
			<ul>
			<li><a href="myInfo">개인정보</a></li>
			<li><a href="myPlannerList">내플래너</a></li>
			</ul>
	</div>
	<div class="content">
			<div class="content-item">
				<h3>day1</h3>
				<div class="content-item"><a href="#">1일차일정</a></div>
			</div>
			<div class="content-item">
				<h3>day2</h3>
				<div class="content-item"><a href="#">2일차일정</a></div>
			</div>
	</div>
	<div class="content-map">
		<div style="height:200px;">
			지도위치
		</div>
	</div>
	<%@include file="../footer.jsp" %>
</body>
</html>