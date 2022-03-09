<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>+82Trip</title>
</head>
<style>
h1 {
	padding-top: 80px;
	padding-bottom: 20px;
	text-align: center;
}

.swiper-container {
	width: 80%;
	height: 380px;
	border: 3px solid #BBDFC8;
	border-radius: 30px;
	box-shadow: 0 0 20px #BBDFC8 inset;
	padding-bottom: 20px;
}

.swiper-slide {
	text-align: center;
}

.swiper-slide img {
	box-shadow: 0 0 5px #555;
	max-width: 100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	/* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
	height: 70%;
	width: 70%;
	border-radius: 5px;
}
.swiper-slide a{
	font-size: 20px;
}
h2 {
	padding-bottom: 5px;
	text-align: center;
}

.item {
	width: 600px;
	height: 400px;
}

.index_category_container {
	width: 80%;
	margin: auto;
}

.local_main_image {
	width: 80%;
	margin: auto;
	height: 450px;

}

.local_main_container {
	display: grid;
	width: 100%;
	height: 100%;
	grid-template-columns: 1.5fr 1fr;
	gap: 10px 10px;
	grid-template-rows: 1fr 1fr;
	grid-template-columns: 1.5fr 1fr;
}

#item1 {
	grid-row: 1/3;
	width: 100%;
	height: 100%;
}

.local_item {
	position: relative;
}

.item_image {
	object-fit: cover;
	position: absolute;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 5px;
}

</style>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>




	<div class="content">
		<h1>${localCon.c_local} 둘러보기</h1>
		<div class="local_main_image">
			<div class="local_main_container">
				<div class="local_item" id="item1">
					<img class="item_image" src="resources/image/대표이미지/${localCon.c_local}1.jpg">
				</div>
				<div class="local_item">
					<img class="item_image"
						src="resources/image/대표이미지/${localCon.c_local}2.jpg">
				</div>
				<div class="local_item">
					<img class="item_image"
						src="resources/image/대표이미지/${localCon.c_local}3.jpg">
				</div>
			</div>
		</div>
		<div class="index_category_container">
			<h1>${localCon.c_local} 관광지</h1>
			<div style="text-align: right;">
				<a href="localAllList?c_category=관광지&c_local=${localCon.c_local}" style="padding-right: 10px;">전체보기</a>
			</div>
		</div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="tour" items="${localTourList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${tour.c_no}&c_local=${tour.c_local}"> <span
							style="display: block; padding:20px 10px;">${tour.c_title}</span> <img
							src="resources/image/${tour.c_local}/${tour.c_image1}">
						</a>
					</div>

				</c:forEach>
			</div>
			<!-- 네비게이션 -->
			<div class="swiper-button-next"></div>
			<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div>
			<!-- 이전 버튼 -->
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
		<div class="index_category_container">
			<h1>${localCon.c_local} 숙소</h1>
			<div style="text-align: right;">
				<a href="localAllList?c_category=숙소&c_local=${localCon.c_local}" style="padding-right: 10px;">전체보기</a>
			</div>
		</div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="hotel" items="${localHotelList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${hotel.c_no}&c_local=${hotel.c_local}"> <span
							style="display: block; padding:20px 10px;">${hotel.c_title}</span> <img
							src="resources/image/${hotel.c_local}/${hotel.c_image1}">
						</a>
					</div>

				</c:forEach>
			</div>
			<!-- 네비게이션 -->
			<div class="swiper-button-next"></div>
			<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div>
			<!-- 이전 버튼 -->
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
		<div class="index_category_container">
			<h1>${localCon.c_local} 맛집</h1>
			<div style="text-align: right;">
				<a href="localAllList?c_category=음식점&c_local=${localCon.c_local}" style="padding-right: 10px;">전체보기</a>
			</div>
		</div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="food" items="${localFoodList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${food.c_no}&c_local=${food.c_local}"> <span
							style="display: block; padding:20px 10px;">${food.c_title}</span> <img
							src="resources/image/${food.c_local}/${food.c_image1}">
						</a>
					</div>

				</c:forEach>
			</div>
			<!-- 네비게이션 -->
			<div class="swiper-button-next"></div>
			<!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			<div class="swiper-button-prev"></div>
			<!-- 이전 버튼 -->
			<!-- 페이징 -->
			<div class="swiper-pagination"></div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>



	<script type="text/javascript">
		new Swiper('.swiper-container', {

			slidesPerView : 3, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 20, // 슬라이드간 간격
			slidesPerGroup : 3, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

			// 그룹수가 맞지 않을 경우 빈칸으로 메우기
			// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
			loopFillGroupWithBlank : true,

			loop : true, // 무한 반복

			pagination : { // 페이징
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
		});
	</script>

</body>
</html>