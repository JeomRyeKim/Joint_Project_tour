<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../bootStrap.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너 목록</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plannerStyle.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plannerJs.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<%--  접근 제한   --%>
<script>
	/*  유효한 계정인지 검증  */
	$(document).ready(function(){  
	            if(${m_active_kind >= 2}){   // 1 활동중, 2 임시, 3 탈퇴
	                alert("탈퇴 또는 비활성화 계정입니다 ㅠㅠ \n유효한 계정만 마이플래너를 사용하실수 있습니다");
	                location.href = "/"
	            }   
	});     

	/*  로그인 여부 검증  */
 	$(document).ready(function(){
 		if(${sessionScope.m_id == null}){    
	 		var result = confirm("로그인후 사용가능합니다 \n지금 로그인 페이지로 이동하시겠습니까?");
	 		if(result == false){
	 			window.location.href='/';
	 		}else if(result == true){
	 			window.location.href='memberLogin';
	 		}
 		} 
 	});    
</script> 


<script>
		/* 플래너 작성 버튼 누르면 팝업 띄우기, 내리기  */
        $(document).ready(function () {
        	$("#btn").click(function () {
                $("#popup").fadeIn();
                // scroll 제어
                	// fadeIn 클래스 판단 유무
                	if($('.planL-popupcontainer').is('#popup')){
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

        });

        /* 플래너 삭제시 존재여부 검증, 있으면 plannerDelete로 plannerNo와 session id 전달실행 */
        function deletePlanner(plannerNo){
            var result = confirm(map${status.current} + " 플래너를 삭제하시겠습니까?");
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

<!-- 마이페이지 container -->
<div class="planL-container">
 
    <!-- 마이페이지 navbar -->
    <div class="planL-navbox">
        <ul class="planL-navbox__ul--blue">
            <li class="planL-navbox__li--big"> PLanner </li>
            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/myInfo?id=${sessionScope.m_id}" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="image/myPlanner/person.png">&nbsp;  마이페이지</a></li>
            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="image/myPlanner/planner.png">&nbsp;&nbsp;내 플래너</a></li>
        </ul>
    </div>
    <!-- // 마이페이지 네비바-->

    <!-- 플래너 목록 container -->
    <div class="planL-planbox">

        <!-- 플래너 목록 제목 -->
        <div class="planL-titlebox">
            <span class="planL-titlebox--span__big">My Planner</span>
            <button class="planL-titlebox--button__blue" id="btn">
            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen" viewBox="0 0 16 16">
  					<path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z"/>
				</svg>
            	플래너 작성</button>
        </div>
        <!-- // 플래너 목록 제목-->
        
        <!-- 플래너 목록 시작 -->
        <div class="planL-listbox">

            <!-- varitems로 변경 후 데이터 가져와서 뿌릴 예정, 플래너 각 고유 id 필요하기에 플래너 번호 필수 ! -->
            <c:forEach items="${planners}" var="planner" varStatus="status">
                <div class="planL-detailbox">

                    <div class="planL-detailmap" >
                        <div class="planL-map" id="map${status.count}" onclick="location.href='${pageContext.request.contextPath}/planD?plannerNo=${planner.plannerNo}'" ></div> <!-- 플래너 상세 페이지로 이동하는 경로 -->
                    </div>

					<!--  지도 API  -->
                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e47a393473d9bf60bc248b17b6d8a8aa"></script>
                    <script>
                        /* 지도 생성 */
                        var container = document.getElementById('map${status.count}');

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

                        /* 폴리라인 생성 */
                        var polyline = new kakao.maps.Polyline({
                            map: map,
                            path: [],
                            strokeWeight: 3,
                            strokeColor: '#ff0066',
                            strokeOpacity: 1,
                            strokeStyle: 'solid'
                        });

                        /*for문 생성 */
                        <c:forEach var="plan" items="${plans}" varStatus="plan_status">
                        	<c:if test="${planner.plannerNo eq plan.plannerNo}">     
                                /* 지도에 마커 생성 */
                                /* 마커 */
                                var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                var marker = new kakao.maps.Marker({
                                    position: markerPosition
                                });
                                marker.setMap(map);

                                /* 경로 추가  */
                                var point =  new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                var path = polyline.getPath();
                                path.push(point);
                                polyline.setPath(path);
                            </c:if>
                        </c:forEach>
                    </script>
                    
                    <div class="planL-detailinfo">
                        <span class="planL-detailinfo__span--date">
                                <fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />
                                </span>
                        <span class="planL-detailinfo__span--dday" title="${planner.title}">${planner.title}</span>
                        <fmt:parseNumber value="${planner.getFDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="first"/>
                        <fmt:parseNumber value="${planner.getLDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="last"/>
                        <span class="planL-detailinfo__span--days">${last - first + 1}DAYS</span>
                        <button onclick="deletePlanner(${planner.plannerNo})" class="planL-detailinfo__button--blue">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eraser-fill" viewBox="0 0 16 16">
  								<path d="M8.086 2.207a2 2 0 0 1 2.828 0l3.879 3.879a2 2 0 0 1 0 2.828l-5.5 5.5A2 2 0 0 1 7.879 15H5.12a2 2 0 0 1-1.414-.586l-2.5-2.5a2 2 0 0 1 0-2.828l6.879-6.879zm.66 11.34L3.453 8.254 1.914 9.793a1 1 0 0 0 0 1.414l2.5 2.5a1 1 0 0 0 .707.293H7.88a1 1 0 0 0 .707-.293l.16-.16z"/>
							</svg>
                        	삭제</button>
                    </div>
                </div>
            </c:forEach> 
        </div>
        <!-- // 플래너 목록 시작-->
    </div>
    <!-- // 플래너 목록 container-->
</div>
<!-- // 마이페이지 container-->




<!-- 플래너 작성 버튼 클릭시 팝업창 -->
<div class="planL-popupcontainer" id="popup">

    <div class="planL-popbox">

        <!-- 플래너 팝업창 header 부분 -->
        <div class="planL-popheadbox">
            <span class="planL-popheadbox__span--big">플래너 만들기</span>
            <button class="planL-popheadbox__button--big" id="popdown">닫기</button>
        </div>
        <!-- // 플래너 팝업창 header 부분 -->

        <!-- 플래너 팝업창 입력 부분 -->
        <div class="planL-popcontentbox">
            <form action="${pageContext.request.contextPath}/goPlanI?id=${sessionScope.m_id}" method="post" name="popupFrm" onsubmit="return popupCheck()">

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">여행제목</span>
                    <input type="text" name="title" placeholder="20자 내로 입력해주세요" maxlength="20" class="planL-popdetailbox__input--gray" required>
                </div>
                
                <div class="planL-popdetailbox">
                	<span class="planL-popdetailbox__span--big">지역선택</span>
					  <select name="site" class="planL-popdetailbox__input--gray">
					    <option value="서울">서울</option>
					    <option value="경기도">경기도</option>
					    <option value="강원도">강원도</option>
					    <option value="충청도">충청도</option>
					    <option value="경상도">경상도</option>
					    <option value="전라도">전라도</option>
					    <option value="제주도">제주도</option>
					  </select>
                </div>

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">여행기간</span>
                    <input type="date" name="fDate" class="planL-popdetailbox__input--date" required>
                    <span class="planL-popdetailbox__span--small">~</span>
                    <input type="date" name="lDate" class="planL-popdetailbox__input--date" required>
                </div>

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">설명</span>
                    <input type="text" name="intro" placeholder="30자 내로 입력해주세요" maxlength="30" class="planL-popdetailbox__input--gray" value="">
                </div>

                <div class="planL-popbtnbox">
                    <input type="submit" class="planL-popbtnbox__input--blue" value="플래너 만들기">
                </div>

            </form>
        </div>
        <!-- // 플래너 팝업창 입력 부분 -->

    </div>
</div>
<!-- // 플래너 작성 버튼 클릭시 팝업창 -->
	<%@include file="../footer.jsp" %>
</body>
</html>