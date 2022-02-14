<!--
사용자가 원하는 일정을 짤 수 있는 플래너 작성 페이지
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../bootStrap.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너 작성</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plannerStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function() {

        	/* day1,2,... 클릭시 선택유무에 따른 컬러 변경 */
            $('.planI-daybox').click(function(e) {
                e.preventDefault();
                $('.planI-daybox').css("background-color","#4d4d4d");
                $(this).css("background-color","#262626");
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
                        alert("각 여행일에는 최소 1개의 일정을 추가해주세요.");
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
                            alert("시간은 필수 입력 항목입니다.");
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
	    function colsePlanner(){
	        var result = confirm("작성중이던 플래너를 취소하고 돌아가시겠습니까?");
	        if(result == false){
	            return false;
	        }else if(result == true){
	            window.location.href='${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}';
	        }
	    }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
</head>
<body>
<!--  header   -->
<header class="header" style="position: fixed; width: 100%; z-index: 10;">
	<%@include file="../header1.jsp" %>
</header>
<!-- // header  -->

    <!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->
    <input type="hidden" name="title" id="title" value="${planner_user.title}" />
    <input type="hidden" name="site" id="site" value="${planner_user.site}" />
    <input type="hidden" name="fDate" id="f_date" value="<fmt:formatDate value="${planner_user.getFDate()}" pattern="yyyy-MM-dd" />" />
    <input type="hidden" name="lDate" id="l_date" value="<fmt:formatDate value="${planner_user.getLDate()}" pattern="yyyy-MM-dd" />" />
        <input type="hidden" name="intro" id="intro" value="${planner_user.intro}" />
    <!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->

    <!-- header -->
    <div class="planI-header">
        <button class="planI-header__button--sumbit">저장</button>
        <button class="planI-header__button--close" onclick="colsePlanner()">닫기</button>  
    </div>
    <!-- // header -->

    <!-- 플래너 작성 container -->
    <div class="planI-container">
        <!-- DAYS 나타내는 div -->
        <div class="planI-daysbox">

            <div class="planI-daysboxtitle">일정</div>

            <c:forEach items="${days}" var="day" varStatus="status">
                <div class="planI-daybox" onclick="plansChange(${status.count})">
                    <span class="planI-day">DAY${status.count}</span>
                    <span class="planI-date"><fmt:formatDate value="${day}" pattern="MM.dd (E)" /></span>
                </div>
            </c:forEach>

        </div>
        <!-- // DAYS 나타내는 div -->

        <!-- 해당 날짜에 대한 일정들 나타나는 div -->
        <div class="planI-planscontainer">

            <c:forEach items="${days}" var="day" varStatus="status">
                <div class="planI-plansbox" data-date="${day}">
                    <div class="planI-plansboxtitle">DAY${status.count} | <fmt:formatDate value="${day}" pattern="MM.dd E요일" /></div>
                </div>
            </c:forEach>

        </div>
        <!-- // 해당 날짜에 대한 일정들 나타나는 div -->

        <!-- 키워드로 장소 검색하는 div -->
        <div id="planI-searchbox">

            <div class="planI-search">
                <form onsubmit="searchPlaces(); return false;">
                   <input type="text" value="${planner_user.site}" id="keyword" size="15">
                    <button type="submit">검색</button>
                </form>
            </div>

            <ul id="planI-searchbox__ul--gray"></ul>

            <div id="planI-pagination"></div>
        </div>
        <!-- // 키워드로 장소 검색하는 div -->

        <!-- 지도 div -->
        <div class="planI-mapbox">
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

                itemStr += '<div class="placelist-div"><button class="placelist-div__button" onclick="planInsert(\'' + places.place_name + '\',\'' + places.y + '\',\'' + places.x +  '\')">+</button></div>';

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

    <!-- // 플래너 작성 container -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plannerJs.js"></script>
</body>
</html>