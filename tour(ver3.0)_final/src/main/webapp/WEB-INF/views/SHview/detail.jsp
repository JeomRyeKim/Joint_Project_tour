<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script src="https://kit.fontawesome.com/5d809d04be.js"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>>+82Trip</title>

<style>
.title {
	height: 700px;
	width: 80%;
	margin: auto;
	padding: 20px 0;
}

.title_image_form {
	position: relative;
	height: 70%;
	width: 30%;
	float: left;
	margin: 0 10px;
}

.title_image {
	position: absolute;
	width: 100%;
	height: 100%;
	top: 10%;
	left: 10%;
	object-fit: cover;
}

#map {
	height: 500px;
	width: 80%;
	margin: auto;
}

.map_icon {
	text-align: center;
}

table {
	margin: auto;
	width: 80%;
	text-align: center;
}

th, td {
	border: 1px solid black;
	padding: 10px;
}

.swiper-container {
	float: right;
	width: 60%;
	height: 500px;
}

.swiper-slide {
	text-align: center;
}

.swiper-slide img {
	box-shadow: 0 0 5px #555;
	max-width: 100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	/* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
	height: 90%;
	width: 100%;
	border-radius: 5px;
}

.detail_description {
	float: left;
	width: 35%;
	height: auto;
	position: absolute;
	top: 25%;
	transform: translateY(-50%);
	line-height: 30px;
	text-align: center;
}

.detail_address {
	float: left;
	width: 35%;
	height: auto;
	position: absolute;
	top: 55%;
	transform: translateY(-50%);
	line-height: 30px;
	text-align: center;
}

.detail_likeCheck_form {
	width: 30px;
	height: 30px;
	float: left;
	margin-right: 20px;
}

.cart_form a {
	color: black;
	float: left;
}

.detail_command_container {
	width: 60%;
	margin: auto;
}

.detail_commnad_writer {
	padding: 10px;
	border-top: 1px solid silver;
}

.detail_command_contents {
	padding: 10px 70px;
}

.detail_command_button {
	float: right;
}

.detail_command_button input {
	border: none;
	background-color: white;
}

.detail_command_reply_container {
	float: right;
	padding: 10px;
}

.detail_command_reply_container input {
	border: none;
	background-color: white;
}

#insertCom {
	border: none;
	background-color: white;
	padding-bottom: 5px;
}

.detail_reply_hidden {
	display: none;
	padding: 10px 70px;
}

#cart_form {
	float: right;
	padding-right: 20px;
	padding-top: 2px;
}

#likeCheck {
	float: right;
}

</style>

</head>
<body>

	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>

	<div class="title">
		<div style="padding-bottom: 10px;">
			<h2
				style="text-align: left; font-weight: 1000; padding-top: 20px; display: inline;">${detailCon.c_title}</h2>
			<c:if test="${m_id != null}">
				<div id="likeCheck">
					<c:choose>
						<c:when test="${memberLikeCnt == 0}">
							<div class="detail_likeCheck_form">
								<a href="javascript:updateLike('${detailCon.c_no}','${m_id}');">
									<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
							<path style="fill:red;"
											d="M244 84L255.1 96L267.1 84.02C300.6 51.37 347 36.51 392.6 44.1C461.5 55.58 512 115.2 512 185.1V190.9C512 232.4 494.8 272.1 464.4 300.4L283.7 469.1C276.2 476.1 266.3 480 256 480C245.7 480 235.8 476.1 228.3 469.1L47.59 300.4C17.23 272.1 0 232.4 0 190.9V185.1C0 115.2 50.52 55.58 119.4 44.1C164.1 36.51 211.4 51.37 244 84C243.1 84 244 84.01 244 84L244 84zM255.1 163.9L210.1 117.1C188.4 96.28 157.6 86.4 127.3 91.44C81.55 99.07 48 138.7 48 185.1V190.9C48 219.1 59.71 246.1 80.34 265.3L256 429.3L431.7 265.3C452.3 246.1 464 219.1 464 190.9V185.1C464 138.7 430.4 99.07 384.7 91.44C354.4 86.4 323.6 96.28 301.9 117.1L255.1 163.9z" /></svg>
								</a>
							</div>
						</c:when>

						<c:otherwise>
							<div class="detail_likeCheck_form">
								<a href="javascript:deleteLike('${detailCon.c_no}','${m_id}');">
									<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
							<path style="fill:red;"
											d="M0 190.9V185.1C0 115.2 50.52 55.58 119.4 44.1C164.1 36.51 211.4 51.37 244 84.02L256 96L267.1 84.02C300.6 51.37 347 36.51 392.6 44.1C461.5 55.58 512 115.2 512 185.1V190.9C512 232.4 494.8 272.1 464.4 300.4L283.7 469.1C276.2 476.1 266.3 480 256 480C245.7 480 235.8 476.1 228.3 469.1L47.59 300.4C17.23 272.1 .0003 232.4 .0003 190.9L0 190.9z" /></svg>
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="cart_form">
					<c:choose>
						<c:when test="${cartCnt == 0}">
							<a style="text-decoration: none; color: black; float: left;"
								href="javascript:getCart('${detailCon.c_no}','${m_id}')">
								찜 하기 </a>
						</c:when>
						<c:otherwise>
							<a style="text-decoration: none; color: black; float: left;"
								href="javascript:cancelCart('${detailCon.c_no}','${m_id}')">
								찜 취소 </a>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
		<c:if test="${m_id eq 'admin'}">
			<div style="text-align: left;">
				<a href="updateContentForm?c_no=${detailCon.c_no}" style="text-decoration: none;color:black;">수정</a> 
				<a href="deleteContent?c_no=${detailCon.c_no}" style="text-decoration: none;color:black;">삭제</a>
			</div>
		</c:if>
		<div style="text-align: center; height: 40px;" id="like_Form">
			<div style="width: 150px; height: 30px;">
				<span style="float: left; height: 30px;" id="likeCnt_Form"> <span
					id="likeCnt">Like : ${likeCnt}</span>
				</span>
			</div>
		</div>

		<div style="width: 100%; height: 100%; position: relative;">
			<div class="detail_description">
				<h4 style="padding-bottom: 50px; font-weight: 1000;">소개</h4>
				${detailCon.c_description}
			</div>
			<div class="detail_address">
				<h4 style="padding-bottom: 20px; font-weight: 1000;">주소</h4>
				${detailCon.c_address}
			</div>

			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img
							src="resources/image/${detailCon.c_local}/${detailCon.c_image1}">
					</div>
					<div class="swiper-slide">
						<img
							src="resources/image/${detailCon.c_local}/${detailCon.c_image2}">
					</div>
					<div class="swiper-slide">
						<img
							src="resources/image/${detailCon.c_local}/${detailCon.c_image3}">
					</div>
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
	</div>


	<!-- 댓글  -->
	<script>
		function refreshCommandCnt(){
			var c_no = ${detailCon.c_no};
			$.ajax({
				url:"<%=context%>/countCommandCnt",
				data:{c_no:c_no},
				dataType:"text",
				success:function(data){
					$('#detail_commandCnt *').remove();
					str="<span>"+data+"개</span>"
					$('#detail_commandCnt').append(str);
				}
			});
			
		}
	
		//댓글 수정 작성 이후 댓글리스트 다시 뽑기
		function showCommandList(){
			var commandContent = $('#comWriteArea').val();
			var c_no = ${detailCon.c_no};
			var m_id = $('#m_id').val();
			var str="";
			$.ajax({
				url:"<%=context%>/ajaxCommandList",
				data:{c_no:c_no},
				dataType:"json",
				success:function(data){
					$('#detail_command_col *').remove();
					
					$(data).each(
						function(){
							str+="<div class='detail_command_container' id='com"+this.com_no+"\'>";
							str+="<div class='detail_commnad_writer'>작성자 : ";
							str+=this.m_nickname+"</div>";
							str+="<div class='detail_command_contents' id='com_contents"+this.com_no+"\'>";
							for(var i=0;i<this.com_Indent;i++){
								str+=" - ";
							}
							str+=this.com_contents;
							str+="<div class='detail_command_button'>";
							if(this.m_id=='${m_id}' || m_id=='admin'){
							str+="<input onclick=\"updateform(\'"+this.com_no+"','"+this.m_id+"','"+this.com_contents+"','"+this.m_nickname+"')\" type='button' value='수정'>";
							str+="<input onclick=\"deleteCom(\'"+this.com_no+"','"+this.m_id+"')\"  type='button' value='삭제'>";
							}
							str+="<input onclick=\"showReplyForm(\'"+this.com_no+"')\" type='button' value='댓글 달기'></div>";
							str+="</div>";
							str+="<div id='replyForm"+this.com_no+"\' class='detail_reply_hidden'>";
							str+="<textarea id='replyWriteArea"+this.com_no+"\' rows='2' cols='80'></textarea>";
							str+="<div class='detail_command_reply_container'>"
							str+="<input type='button' value='댓글 쓰기' onclick='writeReply("+this.com_no+")'>";
							str+="<input type='button' value='취소' onclick='cancelReply("+this.com_no+")'>";
							str+="</div></div></div></div>";
						}	
					);
					$('#detail_command_col').append(str);
				}
			});
		}
		//댓글 작성
		function writeCom(){
			var commandContent = $('#comWriteArea').val();
			if(commandContent == null || commandContent == ""){
				alert("댓글을 입력해주세요!!");
				return false;
			}
			var c_no = ${detailCon.c_no};
			var m_id = $('#m_id').val();
			$.ajax({ 
				url:"<%=context%>/detailWriteCom",  
				data:{c_no:c_no , m_id:m_id , com_contents:commandContent},
				dataType :'text',
				async : false,
				success:function(data){
					if(data=='1'){
					alert("댓글이 작성되었습니다.");
					showCommandList();
					refreshCommandCnt();
					}else{
						alert('로그인하고 이용해주세요.');
						location.href="memberLogin";
					}
				}
			});
			$('#comWriteArea').val(null);
		}	// 댓글 작성 끝

		//댓글 수정 클릭시 댓글 수정 입력칸으로 변경 
		function updateform(com_no,m_id,com_contents,m_nickname){
			var str = "";
			str+="<div class='detail_command_container' id='com"+com_no+"\'>";
			str+="<div class='detail_commnad_writer'>작성자 :";
			str+= m_nickname+"</div>";
			str+="<div class='detail_command_contents' id='com_contents"+com_no+"\'>";
			str+="<div id='com_contents"+com_no+"\'><textarea id='updateComArea' rows='2'>"+com_contents+"</textarea></div>";
			str+="<div><input onclick=\"updateCom(\'"+com_no+"','"+m_id+"')\" type='button' value='수정' style='border: none; background-color: white;'> ";
			str+="<input onclick=\"deleteCom(\'"+com_no+"','"+m_id+"')\" type='button' value='삭제' style='border: none; background-color: white;'> </div>";
			str+="</div></div>";
			
			$('#com' + com_no).replaceWith(str);
			$('#com' + com_no + ' #updateComArea').focus();

		} // 댓글 수정 입력칸 끝
		
		//댓글 수정
		function updateCom(com_no,m_id){
			var updateComArea = $('#updateComArea').val(); // 수정한 댓글 내용 저장
			$.ajax({
				url:"<%=context%>/updateCom",
				data:{com_no:com_no , m_id:m_id , com_contents:updateComArea},
				dataType:'text',
				success:function(data){
					alert("data:"+data);
					if(data=='1'){
						alert("댓글이 수정되었습니다.");
						showCommandList();
					}else{
						alert("수정 실패 !!");
					}
				}
			});
		} //댓글 수정 끝
		
		//댓글 삭제
		function deleteCom(com_no,m_id){
			
			$.ajax({
				url:"<%=context%>/deleteCom",
				data:{com_no:com_no , m_id:m_id},
				dataType:"text",
				success:function(data){
			
					if(data==0){
						alert('삭제 실패..');
					}else{
						alert("댓글이 삭제되었습니다.");
						showCommandList();
						refreshCommandCnt();
					}	
				}
			});
		}// 댓글 삭제 끝

		
		

		//대댓글 작성하기
		function writeReply(com_no){
			var commandContent = $('#replyWriteArea'+com_no).val();
			if(commandContent == null || commandContent == ""){
				alert("댓글을 입력해주세요!!");
				return false;
			}
			//댓글 속성들 불리오기 (group,step,indent)
			$.ajax({
				url:"<%=context%>/showReplyProperty",
				data:{com_no:com_no},
				dataType:"json",
				success:function(data){
					var m_id = $('#m_id').val();
					var c_no = data.c_no;
					var com_no = data.com_no;
					var com_contents = $('#replyWriteArea'+data.com_no).val();
					var com_Group = data.com_Group;
					var com_Step = data.com_Step;
					var com_Indent = data.com_Indent;
										
					$.ajax({ //댓글작성
						url:"<%=context%>/writeReply",
						data:{
							c_no:c_no,
							m_id:m_id,
							com_no:com_no,
							com_contents:com_contents,
							com_Group:com_Group,
							com_Step:com_Step,
							com_Indent:com_Indent
						},
						dataType:"text",
						success:function(data){
							if(data=='1'){
							alert("대댓글이 작성되었습니다.");
							showCommandList();
							refreshCommandCnt();
							}else{
								alert("댓글 달기 실패");
							}
						}
					});
				}
				
			});
		}
	</script>
	<!-- 찜  -->
	<script type="text/javascript">
	
		function ajaxCart(){
			var c_no = ${detailCon.c_no};
			var m_id = $('#m_id').val();
			$.ajax({
				url:"<%=context%>/ajaxCart",
				data:{
					c_no:c_no,
					m_id:m_id
				},
				dataType:"text",
				success:function(data){
					$('#cart_form *').remove();
					var str="";
					if(data==0){
						str+="<a style='text-decoration:none;color:black;float: left;' href =\"javascript:getCart(\'"+c_no+"','"+m_id+"')\">";
						str+="찜 하기";
						str+="</a>";
					}else{
						str+="<a style='text-decoration:none;color:black;float: left;' href =\"javascript:cancelCart(\'"+c_no+"','"+m_id+"')\">";
						str+="찜 취소";
						str+="</a>";
					}
					$('#cart_form').append(str);
				}
			});
		}
	
		function cancelCart(c_no,m_id){
			$.ajax({
				url:"<%=context%>/cancelCart",
				data:{
					c_no:c_no,
					m_id:m_id
				},
				dataType:"text",
				success:function(data){
					if(data==1){
						alert("찜이 취소되었습니다.");
						ajaxCart();
					}else{
						alert("찜 삭제 실패..");
					}
				}
			});
		}
	
		function getCart(c_no,m_id){
			$.ajax({
				url:"<%=context%>/getCart",
				data:{
					c_no:c_no,
					m_id:m_id
				},
				dataType:"text",
				success:function(data){
					if(data==1){
						alert("찜이 되었습니다.");
						ajaxCart();
					}else{
						alert("찜 실패..");
					}
				}
			});

		}
	</script>
	<!-- 좋아요  -->
	<script type="text/javascript">
		
		function refreshLike(){
			var c_no = ${detailCon.c_no};
			$.ajax({
				url:"<%=context%>/countLike",
				data:{c_no:c_no},
				dataType:"text",
				success:function(data){
					$('#likeCnt').remove();
					str="<span id='likeCnt'>Like : "+data+"</span>";
					$('#likeCnt_Form').append(str);
				}
			});
		}
		
		function ajaxLike(){
			var c_no = ${detailCon.c_no};
			var m_id = $('#m_id').val();
			$.ajax({
				url:"<%=context%>/ajaxLike",
				data:{
					c_no:c_no,
					m_id:m_id
				},
				dataType:"text",
				success:function(data){
					$('#likeCheck *').remove();
					str="";
					if(data==0){
						str+="<div class='detail_likeCheck_form'>";
						str+="<a href =\"javascript:updateLike(\'"+c_no+"','"+m_id+"')\">";
						str+="<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'>";
						str+="<path style='fill:red;' d='M244 84L255.1 96L267.1 84.02C300.6 51.37 347 36.51 392.6 44.1C461.5 55.58 512 115.2 512 185.1V190.9C512 232.4 494.8 272.1 464.4 300.4L283.7 469.1C276.2 476.1 266.3 480 256 480C245.7 480 235.8 476.1 228.3 469.1L47.59 300.4C17.23 272.1 0 232.4 0 190.9V185.1C0 115.2 50.52 55.58 119.4 44.1C164.1 36.51 211.4 51.37 244 84C243.1 84 244 84.01 244 84L244 84zM255.1 163.9L210.1 117.1C188.4 96.28 157.6 86.4 127.3 91.44C81.55 99.07 48 138.7 48 185.1V190.9C48 219.1 59.71 246.1 80.34 265.3L256 429.3L431.7 265.3C452.3 246.1 464 219.1 464 190.9V185.1C464 138.7 430.4 99.07 384.7 91.44C354.4 86.4 323.6 96.28 301.9 117.1L255.1 163.9z' /></svg>";
						str+="</a>";
						str+="</div>";
						
					}else{
						str+="<div class='detail_likeCheck_form'>";
						str+="<a href =\"javascript:deleteLike(\'"+c_no+"','"+m_id+"')\">";
						str+="<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'>";
						str+="<path style='fill:red;' d='M0 190.9V185.1C0 115.2 50.52 55.58 119.4 44.1C164.1 36.51 211.4 51.37 244 84.02L256 96L267.1 84.02C300.6 51.37 347 36.51 392.6 44.1C461.5 55.58 512 115.2 512 185.1V190.9C512 232.4 494.8 272.1 464.4 300.4L283.7 469.1C276.2 476.1 266.3 480 256 480C245.7 480 235.8 476.1 228.3 469.1L47.59 300.4C17.23 272.1 .0003 232.4 .0003 190.9L0 190.9z' /></svg>";
						str+="</a>";
						str+="</div>";
					}
					$('#likeCheck').append(str);
					
				}
			});
		}
	
		function deleteLike(c_no,m_id){
				$.ajax({
					url:"<%=context%>/cancel_Like",
					data:{
						c_no:c_no,
						m_id:m_id
					},
					dataType:"text",
					success:function(data){
						if(data==1){
							alert('좋아요가 취소되었습니다.');
							refreshLike();
							ajaxLike();
						}else{
							alert('좋아요 취소 실패!');
						}
					}
				});
			}
	
		function updateLike(c_no,m_id){
			$.ajax({
				url:"<%=context%>/detail_Like",
				data : {
					c_no : c_no,
					m_id : m_id
				},
				dataType : "text",
				success : function(data) {
					if (data == 1) {
						alert("좋아요를 누르셨습니다.");
						refreshLike();
						ajaxLike();
					} else {
						alert('좋아요 실패');
					}
				}
			});
		}
	</script>

	<!-- 지도 -->
	<div class="map_frame" style="width: 100%; padding-bottom: 30px;">
		<h4 style="text-align: center">위치</h4>
		<div id="map">
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=305c011011120570401d05c2d7aa7081"></script>
			<script type="text/javascript">
				var map_x = ${detailCon.c_map_x};
				var map_y = ${detailCon.c_map_y};
				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center : new kakao.maps.LatLng(map_x, map_y), //지도의 중심좌표.
					draggable : false, // 스크롤로 확대/축소 막기
					level : 3
				//지도의 레벨(확대, 축소 정도)
				};

				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

				// 마커가 표시될 위치입니다 
				var markerPosition = new kakao.maps.LatLng(map_x, map_y);

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					position : markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);

				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);    

				var iwContent = '<div style="padding:5px;" class="map_icon">${detailCon.c_title}<br><a href="https://map.kakao.com/link/map/${detailCon.c_title},${detailCon.c_map_x},${detailCon.c_map_y}" style="color:blue;text-decoration: none;" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/${detailCon.c_title},${detailCon.c_map_x},${detailCon.c_map_y}" style="color:blue;text-decoration: none;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				iwPosition = new kakao.maps.LatLng(map_x, map_y); //인포윈도우 표시 위치입니다

				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
					position : iwPosition,
					content : iwContent
				});

				// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
				infowindow.open(map);
			</script>
		</div>
	</div>

	<input type="hidden" id="m_id" value="${m_id}">

	<h3 style="padding: 30px 10px; width: 60%; margin: auto;">댓글</h3>
	<div
		style="border-bottom: 1px solid silver; width: 60%; margin: auto; padding:5px 10px;"
		id="detail_commandCnt">
		<span>${commandCnt}개</span>
	</div>

	<table style="height: 100px; width: 60%; margin: auto;">
		<tr>
			<th><textarea id="comWriteArea" rows="2" cols="100"></textarea>
			</th>
			<th><input type="button" id="insertCom" value="댓글 작성하기"
				onclick="writeCom()"></th>
		</tr>
	</table>

	<div id="detail_command_col">
		<c:forEach var="com" items="${comList}">
			<div class="detail_command_container" id="com${com.com_no}">
				<div class="detail_commnad_writer">작성자 : ${com.m_nickname}</div>
				<div class="detail_command_contents" id="com_contents${com.com_no}">
					<c:forEach begin="1" end="${com.com_Indent}">-</c:forEach>
					${com.com_contents}
					<div class="detail_command_button">
						<c:if test="${com.m_id == m_id or m_id=='admin'}">
							<input
								onclick="updateform('${com.com_no}','${com.m_id}','${com.com_contents}','${com.m_nickname}')"
								type="button" value="수정">
							<input onclick="deleteCom('${com.com_no}','${com.m_id}')"
								type="button" value="삭제">
						</c:if>
						<c:if test="${m_id != null}">
							<td><input onclick="showReplyForm('${com.com_no}')"
								type="button" value="댓글 달기"></td>
						</c:if>
					</div>
				</div>
				<div id="replyForm${com.com_no}" class="detail_reply_hidden">
					<textarea id="replyWriteArea${com.com_no}" rows="2" cols="80"></textarea>
					<div class="detail_command_reply_container">
						<input type="button" value="댓글 쓰기"
							onclick="writeReply('${com.com_no}')"> <input
							type="button" value="취소" onclick="cancelReply('${com.com_no}')">
					</div>
				</div>
			</div>
		</c:forEach>
	</div>


	<%@include file="../footer.jsp"%>
</body>
	<!-- 슬라이드 -->
	<script>
			new Swiper('.swiper-container', {

			slidesPerView : 1, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 20, // 슬라이드간 간격
			slidesPerGroup : 1, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

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

<script type="text/javascript">
	//대댓글 쓸 양식 띄우기
	function showReplyForm(com_no) {
		var x = document.getElementById('replyForm' + com_no);
		x.style.display = "block";
	}
	//대댓글 양식 삭제
	function cancelReply(com_no) {
		var x = document.getElementById('replyForm' + com_no);
		x.style.display = "none";
	}
</script>
</html>