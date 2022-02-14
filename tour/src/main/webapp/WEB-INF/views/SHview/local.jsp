<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 화면</title>
</head>
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
	height: 70%;
	width: 80%;
}

h2 {
	padding-bottom: 5px;
	text-align: center;
}
.wrapper{
/*     height:700px; */
    /* background-color: lightgray; */
    display: flex;
    justify-content: center;
    align-items: center;
}
.container1{
    width:600px;
    height:400px;
    position: relative;
    overflow: hidden;
}
.slider{
    display: flex;
    position:absolute;
    top:0;
    left:0;
    -webkit-transition: all 0.25s cubic-bezier(1, .01, .32, 1);
    -o-transition: all 0.25s cubic-bezier(1, .01, .32, 1);
    transition: all 0.25s cubic-bezier(1, .01, .32, 1);
}
.item{
    width:600px;
    height:400px;
}

</style>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>
	<div class="content">
		<h2>${localCon.c_local} 둘러보기</h2>
 		<div class="wrapper">
	        <div class="container1">
	            <div class="slider">
	              <div>
	             	 <img class="item" src="resources/image/대표이미지/${localCon.c_local}1.jpg">
				  </div>
	              <div>
	              	<img class="item" src="resources/image/대표이미지/${localCon.c_local}2.jpg">
				  </div>
	              <div>
	             	<img class="item" src="resources/image/대표이미지/${localCon.c_local}3.jpg">
				  </div>
	            </div>
	        </div>
    	</div>
		<h3>지역 관광지!!</h3>
		<div style="text-align:right;"><a href="localAllList?c_category=관광지&c_local=${localCon.c_local}">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="tour" items="${localTourList}">
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
		
		<h3>지역 숙소!!</h3>
		<div style="text-align:right;"><a href="localAllList?c_category=숙소&c_local=${localCon.c_local}">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="hotel" items="${localHotelList}">
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

		<h3>지역 맛집!!</h3>
		<div style="text-align:right;"><a href="localAllList?c_category=음식점&c_local=${localCon.c_local}">전체보기</a></div>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach var="food" items="${localFoodList}">
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
	</div>
	<%@include file="../footer.jsp"%>
	
    
	
	<script type="text/javascript">
		var slideWrapper = document.querySelector('.container1');
		var slides = document.querySelectorAll('.item');
		var totalSlides = slides.length; // item의 갯수
		
		
		var sliderWidth = slideWrapper.clientWidth; // container의 width
		var slideIndex = 0;
		var slider = document.querySelector('.slider');
		
		slider.style.width = sliderWidth * totalSlides + 'px';
		
		showSlides()
		
		function showSlides() {
		    for(var i=0;i<slides.length;i++){
		        slider.style.left = -(sliderWidth * slideIndex) + 'px';    
		    }
		    slideIndex++;
		    if (slideIndex === totalSlides) {
		        slideIndex = 0;
		    }
		    setTimeout(showSlides, 3000); 
		}
	
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