<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content-item-detail {
	padding: 0 10px;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	gap: 20px 10px;
	grid-template-rows: repeat(${total},200px);
}
.detail-items {
	position: relative;
}

.image_box {
	position: absolute;
	top: 15%;
	left: 10%;
	width: 80%;
	height: 80%;
	object-fit: cover;
}

.content_title {
	display: block;
	text-align: center;
}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>

	<h2 style="text-align: center; margin: 20px 0px;">전체 보기</h2>

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
