<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../bootStrap.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너 목록</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plannerStyle.css">
<link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plannerJs.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
 
<%--  접근 제한   --%>
<script>
	/*  유효한 계정인지 검증  */ 
	$(document).ready(function(){   
	            if(${m_active_kind >= 2}){   // 1 활동중, 2 임시, 3 탈퇴
	                    Swal.fire({
	                        icon: 'error',
	                        title: '유효한 계정만 이용이 가능합니다',
	                        text: '계정이 비활성화 되었거나 탈퇴한 상태 입니다.'
	                    }).then(function(){
	                    	location.href = '/'
	                    });
	            }
	});     

	
 	/*  로그인 여부 검증  */
/*	$(document).ready(function(){
 		if(${sessionScope.m_id == null}){   
 			Swal.fire({
 				  title: '회원만 이용 가능한 페이지',
 				  text: "로그인후 사용가능합니다. 지금 로그인 페이지로 이동하시겠습니까?",
 				  icon: 'warning',
 				  showCancelButton: true,
 				  confirmButtonColor: '#3085d6',
 				  cancelButtonColor: '#d33',
 				  confirmButtonText: 'Login'
 				}).then(function(result) => {
 				  if (result.isConfirmed) {
 					 window.location.href='/';
 				  }
 				  else {
 					 window.location.href='memberLogin';
 				  }
 				})
 		}
 	});  
*/
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
		        		  return true;
		        		});
		        	}
		    });
		
		    $("#popdown").click(function () {
		        $("#popup").fadeOut();
		        $('#element').off('scroll touchmove mousewheel');
		        $('html, body').css({'overflow': 'visible ', 'height': '100%'});
		        return false;
		    });
		
		});

		
        /* 플래너 삭제시 존재여부 검증, 있으면 plannerDelete로 plannerNo와 session id 전달실행 */
        function deletePlanner(plannerNo){
        	Swal.fire({ 
    			icon: 'warning', 
        		title: '플래너를 삭제 하시겠습니까?', 
    			text: "삭제된 플래너는 다시 되돌릴 수 없습니다.", 
    			showCancelButton: true, 
    			confirmButtonColor: '#3085d6', 
    			cancelButtonColor: '#d33', 
    			confirmButtonText: '삭제', 
    			cancelButtonText: '취소' 
    		}).then(function(result){ 
	    			if (result.isConfirmed) { 
	    			  Swal.fire( 
	    						'플래너 삭제 완료', 
	    						'정상적으로 삭제가 완료 되었습니다!', 
	    						'success' 
	    						).then(function(){
			    				window.location.href='${pageContext.request.contextPath}/plannerDelete?plannerNo='
			    									  +plannerNo +'&id=${sessionScope.m_id}';
	    						});
	    			}  
    			});
        };
        
        /* 왼쪽 메뉴 스크롤 따라 움직이기 */
        $(document).ready(function(){
            var currentPosition = parseInt($(".planL-navbox").css("top"));
            $(window).scroll(function() {
                var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
                $(".planL-navbox").stop().animate({"top":position+currentPosition+"px"},680);
            });
        });
        
    </script>
   
</head>
<body>

<!--  header   -->
<div class="header" style="position: sticky; width: 100%; z-index: 10; top: 0px; background-color: white; margin-top: -50px;">
	<%@include file="../header1.jsp" %>
</div>
<!-- // header  -->

<!-- 마이페이지 container -->
<div class="planL-container">


<div class="jumbotron" style="width: 100%; height: 320px; position: static; top: -50px; background-image: url('image/myPlanner/sunset.png'); background-size: 100%">
  <div class="container" style="width: 100%; top: 0px; position: relative; z-index: 0;">
    <h1 class="display-4" style="position:relative; float: right; bottom: -10px; font-family: 'Fredoka One', cursive; font-weight: bold; font-size: 88px;
    							 color: white; 
    							-webkit-animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
	        							animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;">My Planner</h1>
  </div>
</div>
 
    <!-- 마이페이지 navbar -->
    <div class="planL-navbox__long">
	    <div class="planL-navbox">
	        <ul class="planL-navbox__ul--blue">
	            <li class="planL-navbox__li--big"> Planner </li>
	            <li class="planL-navbox__li--id">[ <a style="color: #1565C0;">${sessionScope.m_id}</a> ] 님의 플래너</li>
	            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/myInfo?id=${sessionScope.m_id}" class="planL-navbox__a--blue">
	            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
	  					<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
					</svg>&nbsp;  마이페이지</a></li>
	            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}" class="planL-navbox__a--blue">
	            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-table" viewBox="0 0 16 16" style="width: 22px; height: 22px; margin-left: 3px;">
	  					<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
					</svg>&nbsp;&nbsp;  내 플래너</a></li>
	        </ul>
	    </div>
    </div>
    <!-- // 마이페이지 네비바-->

    <!-- 플래너 목록 container -->
    <div class="planL-planbox">

        <!-- 플래너 목록 제목 -->
            <button class="planL-titlebox--button__blue" id="btn">
            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen" viewBox="0 0 16 16">
  					<path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z"/>
				</svg>
                       플래너 작성</button>
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
                            strokeOpacity: 0.5,
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
            <span class="planL-popheadbox__span--big">
            	<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  					<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  					<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
				</svg> 플래너 만들기 </span>
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
                    <span class="planL-popdetailbox__span--small">
                    	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-caret-right" viewBox="0 0 16 16">
  							<path d="M6 12.796V3.204L11.481 8 6 12.796zm.659.753 5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
						</svg>
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
  							<path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
						</svg>
                    </span>
                    <input type="date" name="lDate" class="planL-popdetailbox__input--date" required>
                </div>
				
                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">여행설명</span>
                    <input type="text" name="intro" placeholder="30자 내로 입력해주세요" maxlength="30" class="planL-popdetailbox__input--gray" value="">
                </div>
				
                <div class="planL-popbtnbox">
                    <input type="submit" class="planL-popbtnbox__input--blue" value="작성하기">
                    <button class="planL-popbtnbox__button--gray" id="popdown">닫기</button>
                </div>

            </form>
        </div>
        <!-- // 플래너 팝업창 입력 부분 -->

    </div>
</div>
<!-- // 플래너 작성 버튼 클릭시 팝업창 -->

<div class="footer">
	<%@include file="../footer.jsp" %>
</div>
</body>
</html>