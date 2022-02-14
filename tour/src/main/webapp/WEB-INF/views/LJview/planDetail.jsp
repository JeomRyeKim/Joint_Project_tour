<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%@include file="../bootStrap.jsp"%>
<title>플래너 상세 목록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plannerStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/plannerJs.js"></script>
    <script>
        $(document).ready(function () {

            $("#btn").click(function () { 
                $("#popup").fadeIn();
                // scroll 제어
                	// fadeIn 클래스 판단 유무
                	if($('.planD-popupcontainer').is('#popup')){
                		$('html, body').css({'overflow': 'hidden', 'height': '100%'});
                		$('#element').on('scroll touchmove mousewheel', function(event) {
                		  event.preventDefault();
                		  event.stopPropagation();
                		  return false;
                		});
                	}
            });

            $("#popdown").click(function () {
                $("#popup").fadeOut();
                $('#element').off('scroll touchmove mousewheel');
                $('html, body').css({'overflow': 'visible ', 'height': '100%'});
                return true;
            });
            
            
            var slide = document.querySelectorAll(".planD-map");
            var listslides = document.querySelectorAll(".planD-placelist");
            var current = 0;

            function show(n){
                for(var i=0;i<slide.length;i++){
                    slide[i].style.display = "none";
                }
                slide[n].style.display = "block";

                for(var j=0;j<listslides.length;j++){
                    listslides[j].style.display = "none";
                }
                listslides[n].style.display = "block";
            }
            show(current);
        });


        /* 플래너 삭제하기  */
        function deletePlanner(plannerNo){
            var result = confirm("플래너를 삭제하시겠습니까?");
            if(result == false){
                return false;
            }else if(result == true){
                window.location.href='${pageContext.request.contextPath}/plannerDelete?plannerNo='+plannerNo +'&id=${sessionScope.m_id}';
            }
        }
        
        
       /* 왼쪽 메뉴 스크롤 따라 움직이기 */
        $(document).ready(function(){
            var currentPosition = parseInt($(".planL-navbox").css("top"));
            $(window).scroll(function() {
                var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
                $(".planL-navbox").stop().animate({"top":position+currentPosition+"px"},700);
            });
        });
        
    </script>
	
</head>
<body>
<!--  header   -->
<header class="header" style="position: fixed; width: 100%; z-index: 10;">
	<%@include file="../header1.jsp" %>
</header>
<!-- // header  -->


    <!-- container -->
    <div class="planD-container">

        <!-- 내 프로필 nav -->
        <div class="planL-navbox">
	        <ul class="planL-navbox__ul--blue">
	            <li class="planL-navbox__li--big"> PLanner </li>
	            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/myInfo?id=${sessionScope.m_id}" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="image/myPlanner/person.png">&nbsp;  나의 정보</a></li>
	            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="image/myPlanner/planner.png">&nbsp;&nbsp;내 플래너</a></li>
	        </ul>
        </div>
        <!-- // 내 프로필 nav-->

        <!-- 플래너쪽 container -->
        <div class="planD-planbox">

            <!-- 플래너 상단 (제목)-->
            <div class="planD-titlebox">
				<!-- 플래너 경로 지도 부분 -->
                <div class="planD-mapbox">
                    <div class="mapbox">

                        <c:forEach items="${dates}" var="date" varStatus="status">

                            <div class="planD-map" id="maplist${status.count}"></div>
                            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e47a393473d9bf60bc248b17b6d8a8aa&libraries=services"></script>
                            <script>
                                var container = document.getElementById('maplist${status.count}');
                                /*for문 생성 */
                                <c:forEach var="plan" items="${plans}">
                                	<c:if test="${planner.plannerNo eq plan.plannerNo}">
        	                        	var options = {
        	                                    center: new kakao.maps.LatLng(${plan.y}, ${plan.x}),
        	                                    level: 7
        	                                };
                                	</c:if>
                                </c:forEach>  
                                var map = new kakao.maps.Map(container, options);
                                
                             	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
                                var mapTypeControl = new kakao.maps.MapTypeControl();

                                // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
                                // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미
                                map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

                                // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
                                var zoomControl = new kakao.maps.ZoomControl();
                                map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                                

                                /* 폴리라인 생성하기  */
                                var polyline = new kakao.maps.Polyline({
                                    map: map,
                                    path: [],
                                    strokeWeight: 3,
                                    strokeColor: '#ff0066',
                                    strokeOpacity: 1,
                                    strokeStyle: 'solid'
                                });
                                // 마커 숫자를 위한 변수
                                var a = 0;
                                <c:forEach items="${plans}" var="plan" varStatus="plan_status">     
                                    <!-- 화면에서 보이면 주석처리 -->
                                    <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                                    <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" /> 

                                        <c:if test="${nowDate eq openDate}">    
                                            var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지 사용
                                                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                                                imgOptions =  {
                                                    spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                                                    spriteOrigin : new kakao.maps.Point(0, (a*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                                                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                                                },
                                                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                                                marker = new kakao.maps.Marker({
                                                    position: markerPosition, // 마커의 위치
                                                    image: markerImage
                                                });
                                            marker.setMap(map); 

                                            /* 경로 추가  */
                                            var point =  new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                            var path = polyline.getPath();
                                            path.push(point);
                                            polyline.setPath(path);
                                        	++a;
                                        </c:if>
                                </c:forEach>

                            </script>
                        </c:forEach>

                        <div class="planD-selectbox">
                            <select id="select_day" class="planD-selectbox__select--day" onchange="mapChange()">
                                <c:forEach items="${dates}" var="date" varStatus="status">
                                    <option value="${status.index}">DAY${status.count}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="planD-placelistbox">
                        <c:forEach items="${dates}" var="date" varStatus="status">

                            <div class="planD-placelist">

                                <% int z = 1;%>

                                    <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                                        <!-- 화면에서 보이면 주석처리 -->
                                        <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                                        <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" />

                                        <c:if test="${nowDate eq openDate}">
                                            <div class="planD-placedetail">
                                                <img src="${pageContext.request.contextPath}/image/myPlanner/num/number<%=z%>.png" class="planD-placedetail__img--navy">
                                                <span class="planD-placedetail__span--small" title="${plan.name}">${plan.name}</span>
                                            </div>
                                            <% ++z;%>
                                        </c:if>

                                    </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- // 플래너 경로 지도 부분-->
			</div>
			
           <div class="planD-btnbox-detail">
	         	<span class="planD-titledetail">${planner.title}</span>
	             <fmt:parseNumber value="${planner.getFDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="first"/>
	             <fmt:parseNumber value="${planner.getLDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="last"/>
	             <span class="planD-titledays">
	                 <fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />
	                 ~
	                 <fmt:formatDate value="${planner.getLDate()}" pattern="yyyy-MM-dd" />
	                 (${last - first + 1}일)
	             </span>
	             <span class="planD-titleIntro">${planner.intro}</span>
            </div>
            
            <div class="planD-btnbox">
                <button class="planD-btnbox__button--blue" id="btn">수정</button>
                <button class="planD-btnbox__button--gray" onclick="deletePlanner(${planner.plannerNo})">삭제</button>
            </div>
            <!-- // 플래너 상단 (제목) -->



            <!-- 플래너 일정 -->
            <div class="planD-listbox">

                <!-- 플래너 상세 일정 -->
                <%-- 날짜 수만큼 foreach--%>
                <c:forEach items="${dates}" var="date" varStatus="status">
                    <div class="planD-detailbox">

                        <div class="planD-datebox">
                            <div class="planD-days">DAY ${status.count}</div>
                            <div class="planD-date">
                                <fmt:formatDate value="${date}" pattern="yyyy.MM.dd" />&nbsp;
                                (<fmt:formatDate value="${date}" pattern="E" />)
                            </div>
                        </div>

                        <%--  해당 날짜의 플랜 갯수만큼--%>
                        <% int i = 1;%>
                        <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                            <!-- 화면에서 보이면 주석처리 -->
                            <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                            <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" />

                            <c:if test="${nowDate eq openDate}">

                                <div class="planD-detail">
                                    <div class="planD-detailnumber">
                                        <img class="planD-detailnumber__img--navy" src="${pageContext.request.contextPath}/image/myPlanner/num/number<%=i%>.png">
                                    </div>

                                    <div class="planD-detailplace">
                                        <span class="planD-detailtime__span--small"> <fmt:formatDate value="${plan.day}" pattern="a hh:mm"/></span>
                                        <span class="planD-detailplace__span--small" title="${plan.name}">${plan.name}</span>
                                        <span class="planD-detailinfo__span--small">${plan.intro}</span>
                                        <div class="planD-detailimg" id="map${status.count}-${plan_status.count}" onclick="location.href='https://map.kakao.com/link/to/${plan.name},${plan.y},${plan.x}'"></div>

                                        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e47a393473d9bf60bc248b17b6d8a8aa"></script>
                                        <script>
                                            /* 지도 생성 */
                                            var container = document.getElementById('map${status.count}-${plan_status.count}');
                                            var options = {
                                                center: new kakao.maps.LatLng(${plan.y}, ${plan.x}),
                                                level: 3
                                            };
                                            var map = new kakao.maps.Map(container, options);

                                            /* 마커 생성 */
                                            var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                            var marker = new kakao.maps.Marker({
                                                position: markerPosition
                                            });
                                            marker.setMap(map);
                                        </script>
                                    </div>
                                </div>
                                <% ++i;%>

                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>
                <!-- // 플래너 상세 일정-->
            </div>
            <!-- // 플래너 일정 -->

        </div>
        <!-- // container-->

    </div>
    <!-- // 플래너 디테일-->
    
    
    
    
    <!-- 플래너 수정 버튼 클릭시 팝업창 -->
    <div class="planD-popupcontainer" id="popup">

        <div class="planD-popbox">

            <!-- 플래너 팝업창 header 부분 -->
            <div class="planD-popheadbox">
                <span class="planD-popheadbox__span--big">플래너 수정하기</span>
                <button class="planD-popheadbox__button--big" id="popdown">닫기</button>
            </div>
            <!-- // 플래너 팝업창 header 부분 -->

            <!-- 플래너 팝업창 입력 부분 -->
            <div class="planD-popcontentbox">
                <form action="${pageContext.request.contextPath}/goPlanU?plannerNo=${planner.plannerNo}&wDate=${planner.getWDate()}" method="post" name="popupFrm" onsubmit="return popupCheck()">

                    <div class="planD-popdetailbox">
                        <span class="planD-popdetailbox__span--big">여행제목</span>
                        <input type="text" name="title" value="${planner.title}" placeholder="20자 내로 입력해주세요" maxlength="20" class="planD-popdetailbox__input--gray" required>
                    </div>

                    <div class="planD-popdetailbox">
                        <span class="planD-popdetailbox__span--big">여행기간</span>
                        <input type="date" name="fDate" class="planD-popdetailbox__input--date" value="<fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />">
                        <span class="planD-popdetailbox__span--small">~</span>
                        <input type="date" name="lDate" class="planD-popdetailbox__input--date" value="<fmt:formatDate value="${planner.getLDate()}" pattern="yyyy-MM-dd" />">
                    </div>

                    <div class="planD-popdetailbox">
                        <span class="planD-popdetailbox__span--big">설명</span>
                        <input type="text" name="intro" value="${planner.intro}"  placeholder="30자 내로 입력해주세요" maxlength="30" class="planD-popdetailbox__input--gray">
                    </div>

                    <div class="planD-popbtnbox">
                        <input type="submit" class="planD-popbtnbox__input--blue" value="플랜 수정하기">
                    </div>

                </form>
            </div>
            <!-- // 플래너 팝업창 입력 부분 -->

        </div>
    </div>
    <!-- // 플래너 수정 버튼 클릭시 팝업창 -->
    
<%@include file="../footer.jsp" %>
</body>
</html>