<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 화면</title>
<style>
.content-item-detail {
	margin:auto;
	width:80%;
	padding: 0 10px;
	display: grid;
	grid-template-columns:1fr 1fr 1fr;
	gap: 30px 10px;
	grid-template-rows: repeat(${total},200px);
}
.detail-items {
	position: relative;
}
.detail-items a{
	text-decoration: none;
	color: black;
}

.image_box {
	position: absolute;
	top: 25%;
	left: 15%;
	width: 70%;
	height: 70%;
	object-fit: cover;
	border-radius: 5px;
}

.content_title {
	display: block;
	text-align: center;
	font-size: 20px;
}

h1{
	padding: 50px 0;
}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>

	<h1 style="text-align: center; margin: 20px 0px;">전체 보기</h1>

	<div class="content-item-detail">
		<c:forEach var="all" items="${allList}">
			<div class="detail-items">
				<a class="content_title" href="detail?c_no=${all.c_no}">${all.c_title}
					<img class="image_box"
					src="resources/image/${all.c_local}/${all.c_image1}">
				</a>
			</div>
		</c:forEach>
	</div>
	<%@include file="../footer.jsp"%>
	
	
</body>
</html>
