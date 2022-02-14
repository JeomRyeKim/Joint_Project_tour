<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
<style>
h3 {
	padding-top: 20px;
	padding-bottom:10px;
	text-align: center;
}

.swiper-container {
	height: 400px;
	border: 5px solid silver;
	border-radius: 7px;
	box-shadow: 0 0 20px #ccc inset;
	padding-bottom: 20px;
}

.swiper-slide {
	text-align: center;
}

.swiper-slide img {
	box-shadow: 0 0 5px #555;
	max-width: 100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	/* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
	height: 80%;
	width: 80%;
}
</style>
</head>
<body>
	<%@include file="./header1.jsp"%>
	<%@include file="./header2.jsp"%>
	<div class="jumbotron"
		style="height: 150px; padding: 20px 30px; text-align: center;">
		<h2>전국 여행 정보 !!</h2>
		<form action="content_Search" method="get">
			<input type="text" name="search" placeholder="검색어를 입력하세요"
				maxlength="20">
		</form>
	</div>
	<div class="content">
		<h3>전체 관광지!!</h3>
		<div style="text-align: right;"><a href="AllList?c_category=관광지">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="tour" items="${tourList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${tour.c_no}"> 
							<span style="display: block; padding: 10px;">${tour.c_title}</span> 
							<img src="resources/image/${tour.c_local}/${tour.c_image1}">
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
		<h3>전체 숙소!!</h3>
		<div style="text-align: right;"><a href="AllList?c_category=숙소">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="hotel" items="${hotelList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${hotel.c_no}"> 
							<span style="display: block; padding: 10px;">${hotel.c_title}</span> 
							<img src="resources/image/${hotel.c_local}/${hotel.c_image1}">
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
		<h3>전체 맛집!!</h3>
		<div style="text-align: right;"><a href="AllList?c_category=음식점">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="food" items="${foodList}">
					<div class="swiper-slide">
						<a href="detail?c_no=${food.c_no}"> 
							<span style="display: block; padding: 10px;">${food.c_title}</span> 
							<img src="resources/image/${food.c_local}/${food.c_image1}">
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
		<div class="content-item">
			<h3 style="padding-bottom: 20px;">베스트 후기글</h3>
			<div class="content-item-detail">
				<c:forEach var="board" items="${boardList}" begin="0" end="3">
					<div class="detail-items">
						<a href="detail?b_no=${board.b_no}" class="content_title"
							style="padding-bottom: 30px;">${board.b_title}</a> 좋아요 수 :
						${board.b_like_cnt}<br> 조회 수 : ${board.b_hit }<br> 게시글
						카테고리 : ${board.b_kind}
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<%@include file="./footer.jsp"%>



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