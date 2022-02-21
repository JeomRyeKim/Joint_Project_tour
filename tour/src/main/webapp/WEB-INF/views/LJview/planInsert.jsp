<!--
사용자가 원하는 일정을 짤 수 있는 플래너 작성 페이지
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../bootStrap.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너 작성</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plannerStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function() {

        	/* day1,2,... 클릭시 선택유무에 따른 컬러 변경 */
            $('.planI-daybox').click(function(e) {
                e.preventDefault();
                $('.planI-daybox').css("background-color","#FFC478");
                $(this).css("background-color","#ffffff");
            });

            $(".planI-header__button--sumbit").click(function () {
            	// 일정은 여러개니까 배열로 객체 선언
                var date = [];
                var place = [];
                var plan_intro = [];
                var x = [];
                var y = [];
                var time = [];
                var title = document.getElementById('title').value;
                var f_date = document.getElementById('f_date').value;
                var l_date = document.getElementById('l_date').value;
                var planner_intro = document.getElementById('intro').value;

                /* 일정이 빠진 day가 있는지 확인 */
                var isValid = true;
                $('.planI-plansbox').each(function (i){
                    if($(this).children().length < 2){
                        Swal.fire({
	                        icon: 'warning',
	                        title: '여행 일정이 비어 있습니다',
	                        text: '각 여행일에는 최소 1개의 일정을 추가해주세요.'
	                    });
	                    	isValid = false;
                    }
                });

                // 일정추가하면 각배열에 추가하기
                if(isValid == true){
                    $('.planI-planbox').each(function (i){
                        date.push($(this).attr("data-date"));
                    });

                    $('.planI-plandetail__span--place').each(function (i){
                        place.push($(this).attr("title"));
                    });

                    $('.planI-plandetail__input--intro').each(function (i){
                        if($(this).val() == null){
                            plan_intro.push(" ");
                        }else{
                            plan_intro.push($(this).val());
                        }
                    });

                    $('.planI-planbox').each(function (i){
                        y.push($(this).attr("data-y"));
                    });

                    $('.planI-planbox').each(function (i){
                        x.push($(this).attr("data-x"));
                    });

                    $('.planI-plandetail__input--time').each(function (i){
                        time.push($(this).val());
                    });
					
                    // 시간이 입력 안됬으면 알림
                    for(var i=0;i<time.length;i++){
                        if(time[i] == ""){
                            Swal.fire({
    	                        icon: 'warning',
    	                        title: '시간을 정해주세요',
    	                        text: '시간은 필수 입력 항목입니다.'
    	                    });
    	                    	 return false;
                        }
                    }

                    $.ajax({		// 요청할 서버url
                        url:"${pageContext.request.contextPath}/plannerInsert?id=${sessionScope.m_id}",
                        data:{ // 보낼 데이터 (Object , Array)
                            date : date,
                            place : place,
                            plan_intro : plan_intro,
                            y : y,
                            x : x,
                            time : time,
                            // 보낼 데이터 (Object , String)
                            title : title,
                            fDate : f_date,
                            lDate : l_date,
                            intro : planner_intro
                        },
                        type:"post",
                        success: function (data) {  // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                            location.href="${pageContext.request.contextPath}/" + data;
                        }
                    });
                }

            });
        });
    </script>
    
    <script>
	    function closePlanner(){
	    	Swal.fire({ 
    			icon: 'question', 
        		title: '플래너 취소', 
    			text: '작성중이던 플래너를 취소하고 돌아가시겠습니까?', 
    			showCancelButton: true, 
    			confirmButtonColor: '#d33',
    			cancelButtonColor: '#3085d6', 
    			confirmButtonText: '작성취소', 
    			cancelButtonText: '다시작성하기' 
    		}).then(function(result){ 
	    			if (result.isConfirmed) { 
	    				window.location.href='${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}';
	    			}  
    			});
	    }
    </script>
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

    <!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->
    <input type="hidden" name="title" id="title" value="${planner_user.title}" />
    <input type="hidden" name="site" id="site" value="${planner_user.site}" />
    <input type="hidden" name="fDate" id="f_date" value="<fmt:formatDate value="${planner_user.getFDate()}" pattern="yyyy-MM-dd" />" />
    <input type="hidden" name="lDate" id="l_date" value="<fmt:formatDate value="${planner_user.getLDate()}" pattern="yyyy-MM-dd" />" />
        <input type="hidden" name="intro" id="intro" value="${planner_user.intro}" />
    <!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->


    <!-- 플래너 작성 container -->
    <div class="planI-container">
        <!-- DAYS 나타내는 div -->
        <div class="planI-daysbox">
        
			<button class="planI-daysboxtitle--return" style="border-bottom: 1px solid #ffffff; font-size: 18px;" onclick="closePlanner()">
				<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
  					<path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5z"/>
				</svg>
			</button>
			
            <div class="planI-daysboxtitle" style="border-bottom: 1px solid #292929;">
            	<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-calendar2-week-fill" viewBox="0 0 16 16">
  					<path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zm9.954 3H2.545c-.3 0-.545.224-.545.5v1c0 .276.244.5.545.5h10.91c.3 0 .545-.224.545-.5v-1c0-.276-.244-.5-.546-.5zM8.5 7a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1zM3 10.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1z"/>
				</svg> Plan
            </div>

            <c:forEach items="${days}" var="day" varStatus="status">
                <div class="planI-daybox" onclick="plansChange(${status.count})">
                    <span class="planI-day">
                    	DAY${status.count} <br>
                    	<a style="font-size: 17px; margin-left: -4px;"><fmt:formatDate value="${day}" pattern="MM.dd (E)" /></a>
            		</span>
                </div>
            </c:forEach>

        </div>
        <!-- // DAYS 나타내는 div -->

        <!-- 해당 날짜에 대한 일정들 나타나는 div -->
        <div class="planI-planscontainer">
			<button class="planI-header__button--sumbit">
				<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-check2-square" viewBox="0 0 16 16">
				  	<path d="M3 14.5A1.5 1.5 0 0 1 1.5 13V3A1.5 1.5 0 0 1 3 1.5h8a.5.5 0 0 1 0 1H3a.5.5 0 0 0-.5.5v10a.5.5 0 0 0 .5.5h10a.5.5 0 0 0 .5-.5V8a.5.5 0 0 1 1 0v5a1.5 1.5 0 0 1-1.5 1.5H3z"/>
				    <path d="m8.354 10.354 7-7a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0z"/>
				</svg>
			플래너 저장하기</button>

            <c:forEach items="${days}" var="day" varStatus="status">
                <div class="planI-plansbox" data-date="${day}">
                    <div class="planI-plansboxtitle">DAY${status.count} | <fmt:formatDate value="${day}" pattern="MM.dd E요일" /></div>
                </div>
            </c:forEach>

        </div>
        <!-- // 해당 날짜에 대한 일정들 나타나는 div -->

        <!-- 키워드로 장소 검색하는 div -->
        <div id="planI-searchbox">

			<div class="planI-search" style="border-left: none; border-bottom: none; text-align: left; font-size: 22px;
											 padding: 18px 0 0 20px; color: #4d4d4d;">
		 		<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-chat-right-dots" viewBox="0 0 16 16">
				  <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
				  <path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
				</svg>	
				검색예시<p> (부산 맛집, 제주도 숙소)..
			</div>
			
            <div class="planI-search" style="position: sticky">
                <form onsubmit="searchPlaces(); return false;">
                   <input type="text" value="${planner_user.site}" id="keyword" size="15">
                    <button type="submit">
                    	<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
                    </button>
                </form>
            </div>
            <ul id="planI-searchbox__ul--gray"></ul>
            
            <div id="planI-pagination"></div>
        </div>
            

        <!-- // 키워드로 장소 검색하는 div -->

        <!-- 지도 div -->
        <div class="planI-mapbox" style="top: 0px;">
            <div class="planI-map" id="planI-map"></div>
    	</div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e47a393473d9bf60bc248b17b6d8a8aa&libraries=services"></script>
        <script>
            // 지도 생성 코드
            var markers = [];
            var container = document.getElementById('planI-map');

            var options = {						
                center: new kakao.maps.LatLng(37.5536472, 126.9678003),
                level: 3
            };

            var map = new kakao.maps.Map(container, options);
            
            
         	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
            var mapTypeControl = new kakao.maps.MapTypeControl();

            // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
            // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
            var zoomControl = new kakao.maps.ZoomControl();
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
            
            

            // 검색을 위한 코드 시작
            var ps = new kakao.maps.services.Places();

            // 키워드로 장소를 검색합니다
            searchPlaces();

            // 키워드 검색을 요청하는 함수입니다
            function searchPlaces() {

                var keyword = document.getElementById('keyword').value;

                if (!keyword.replace(/^\s+|\s+$/g, '')) {
                    alert('키워드를 입력해주세요!');
                    return false;
                }

                // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
                ps.keywordSearch( keyword, placesSearchCB);
            }

            // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면
                    // 검색 목록과 마커를 표출합니다
                    displayPlaces(data);

                    // 페이지 번호를 표출합니다
                    displayPagination(pagination);

                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    alert('검색 결과가 존재하지 않습니다.');
                    return;
                } else if (status === kakao.maps.services.Status.ERROR) {
                    alert('검색 결과 중 오류가 발생했습니다.');
                    return;
                }
            }

            // 검색 결과 목록과 마커를 표출하는 함수입니다
            function displayPlaces(places) {

                var listEl = document.getElementById('planI-searchbox__ul--gray'),
                    menuEl = document.getElementById('planI-searchbox'),
                    fragment = document.createDocumentFragment(),
                    bounds = new kakao.maps.LatLngBounds(),
                    listStr = '';

                // 검색 결과 목록에 추가된 항목들을 제거합니다
                removeAllChildNods(listEl);

                // 지도에 표시되고 있는 마커를 제거합니다
                removeMarker();

                for ( var i=0; i<places.length; i++ ) {

                    // 마커를 생성하고 지도에 표시합니다
                    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                        marker = addMarker(placePosition, i),
                        itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                    // LatLngBounds 객체에 좌표를 추가합니다
                    bounds.extend(placePosition);
                    fragment.appendChild(itemEl);
                }
                // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
                listEl.appendChild(fragment);
                menuEl.scrollTop = 0;

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                map.setBounds(bounds);
            }

            // 검색결과 항목을 Element로 반환하는 함수입니다
            function getListItem(index, places) {

                var el = document.createElement('li'),
                    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                        '<div class="info">' +
                        '   <h5>' + places.place_name + '</h5>';

                if (places.road_address_name) {
                    itemStr += '    <span>' + places.road_address_name + '</span>';
                } else {
                    itemStr += '    <span>' +  places.address_name  + '</span>';
                }

                itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                    '</div>';

                itemStr += '<div class="placelist-div"><button class="placelist-div__button" onclick="planInsert(\'' + places.place_name + '\',\'' + places.y + '\',\'' + places.x +  '\')">' 
                		  + '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">'
                		  +		'<path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>'
                	      +	'</svg>'
                          +'</button></div>';

                el.innerHTML = itemStr;
                el.className = 'item';

                return el;
            }

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            function addMarker(position, idx, title) {
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                    imgOptions =  {
                        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                marker.setMap(map); // 지도 위에 마커를 표출합니다
                markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                return marker;
            }

            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            function removeMarker() {
                for ( var i = 0; i < markers.length; i++ ) {
                    markers[i].setMap(null);
                }
                markers = [];
            }

            // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
            function displayPagination(pagination) {
                var paginationEl = document.getElementById('planI-pagination'),
                    fragment = document.createDocumentFragment(),
                    i;

                // 기존에 추가된 페이지번호를 삭제합니다
                while (paginationEl.hasChildNodes()) {
                    paginationEl.removeChild (paginationEl.lastChild);
                }

                for (i=1; i<=pagination.last; i++) {
                    var el = document.createElement('a');
                    el.href = "#";
                    el.innerHTML = i;

                    if (i===pagination.current) {
                        el.className = 'on';
                    } else {
                        el.onclick = (function(i) {
                            return function() {
                                pagination.gotoPage(i);
                            }
                        })(i);
                    }

                    fragment.appendChild(el);
                }
                paginationEl.appendChild(fragment);
            }

            // 검색결과 목록의 자식 Element를 제거하는 함수입니다
            function removeAllChildNods(el) {
                while (el.hasChildNodes()) {
                    el.removeChild (el.lastChild);
                }
            }

        </script>
        <!-- // 지도 div -->

	</div>
    <!-- // 플래너 작성 container -->
    
<footer class="footer">
	<%@include file="../footer.jsp" %>
</footer>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/plannerJs.js"></script>
</body>
</html>