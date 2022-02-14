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
	<!-- 전체를 감싸는 태그 -->
	<div id="page-wrapper">
		<div id="content">
			<!-- left -->
				<div class="aside-left">
					<h3>마이페이지</h3>
					<ul>
						<li><a href="memberUpdate">개인정보</a></li>
						<li><a href="myPlannerList">내플래너</a></li>
					</ul>
				</div>
				
			<!-- right -->
			<div class="aside-right">
					<h3>내 플래너</h3>
					<ul>
						<li><a href="#">플래너작성-팝업창에서 이페이지에서 뜨게 - 밑에 form태그랑 연계</a></li>
					</ul>
		<div>
			<form action="myPlannerWrite">
				<h3>플래너만들기 창 인풋3개</h3>
				<input>
				<input>
				<input>
				<input type="submit" value="플래너 만들기">
			</form>
		</div>
		<div class="right-item">
			<h3>지역 관광지!!</h3>
				<div class="right-itemdetail">
				<div class="right-items"><a href="myPlannerList">플래너정보</a></div>
				<div class="right-items"><a href="myPlannerList">플래너정보</a></div>
				<div class="right-items"><a href="myPlannerList">플래너정보</a></div>
				</div>
		</div>
			</div>
	</div>
	<div>
		<h3>지도위치</h3>
	</div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>