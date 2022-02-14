<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="UTF-8">
<title>상세 화면</title>

<style>
.title {
	height: 500px;
	padding: 20px 30px;
	text-align: center;
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
	
	margin:20px 100px;
}
.map_icon{
	text-align: center;
}
table{
	margin: auto;
	width:70%;
	border:1px solid black;
	text-align: center;
}
th, td {
    border:1px solid black;
    padding: 10px;
  }
  
</style>
	
</head>
<body>
	
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>

	<div class="title">
		<h2>${detailCon.c_title}</h2>
		<c:if test="${m_id eq 'admin'}">
			<div style="float: right;">
				<a href="updateContentForm?c_no=${detailCon.c_no}">수정</a>
				<a href="deleteContent?c_no=${detailCon.c_no}">삭제</a>
			</div>
		</c:if>
		<div class="title_image_form">
			<img class="title_image"
				src="resources/image/${detailCon.c_local}/${detailCon.c_image1}">
		</div>
		<div class="title_image_form">
			<img class="title_image"
				src="resources/image/${detailCon.c_local}/${detailCon.c_image2}">
		</div>
		<div class="title_image_form">
			<img class="title_image"
				src="resources/image/${detailCon.c_local}/${detailCon.c_image3}">
		</div>
	</div>
	
	<div style="text-align: center;" id="like_Form">
		<c:if test="${m_id != null}">
			<span id="likeCheck"> <c:choose>
					<c:when test="${memberLikeCnt == 0}">
						<input type="button" value="좋아요!"
							onclick="updateLike('${detailCon.c_no}','${m_id}')">
					</c:when>
					<c:otherwise>
						<input type="button" value="좋아요 취소"
							onclick="deleteLike('${detailCon.c_no}','${m_id}')">
					</c:otherwise>
				</c:choose>
			</span>
		</c:if>

		<span id="likeCnt_Form">
			<span id="likeCnt">좋아요 갯수 : ${likeCnt}</span>
		</span>
		<c:if test="${m_id != null}">
			<div id="cart_form">
				<c:choose>
					<c:when test="${cartCnt == 0}">
						<input type="button" value="찜하기" onclick="getCart('${detailCon.c_no}','${m_id}')">
					</c:when>
					<c:otherwise>
						<input type="button" value="찜취소" onclick="cancelCart('${detailCon.c_no}','${m_id}')">
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
	</div>
	<script>
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
					$('#command_tr *').remove();
					
					$(data).each(
						function(){
							str+="<tr id='com"+this.com_no+"\'>";
							str+="<td>"+this.com_no+"</td>";
							str+="<td>"+this.m_id+"</td>";
							str+="<td id='com_contents"+this.com_no+"\'>";
							for(var i=0;i<this.com_Indent;i++){
								str+=" - ";
							}
							str+=this.com_contents;
							str+="</td>";
							str+="<td><input onclick=\"updateform(\'"+this.com_no+"','"+this.m_id+"','"+this.com_contents+"')\"  type='button' value='수정'></td> ";
							str+="<td><input onclick=\"deleteCom(\'"+this.com_no+"','"+this.m_id+"')\"  type='button' value='삭제'></td> ";
							str+="<td><input onclick=\"showReplyForm(\'"+this.com_no+"')\" type='button' value='댓글 달기'></td>";
							str+="</tr>";
							str+="<tr id='replyForm"+this.com_no+"\' style ='display:none;'>";
							str+="<td colspan='5'><textarea id='replyWriteArea"+this.com_no+"\' rows='2' cols='80'></textarea></td>";
							str+="<td><input type='button' value='댓글 쓰기' onclick='writeReply("+this.com_no+")'></td>";
							str+="</tr>"
						}		
					);
					$('#command_tr').append(str);
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
					alert("댓글 입력 성공");
					showCommandList();
					}else{
						alert('로그인하고 이용해주세요.');
					}
				}
			});
			$('#comWriteArea').val(null);
		}	// 댓글 작성 끝

		//댓글 수정 클릭시 댓글 수정 입력칸으로 변경 
		function updateform(com_no,m_id,com_contents){
			var str = "";
			str+="<tr id='com"+com_no+"\'>";
			str+="<td>"+com_no+"</td>";
			str+="<td>"+m_id+"</td>";
			str+="<td id='com_contents"+com_no+"\'><textarea id='updateComArea' rows='3'>"+com_contents+"</textarea></td>";
			str+="<td><input onclick=\"updateCom(\'"+com_no+"','"+m_id+"')\"  type='button' value='수정'> ";
			str+="<td><input onclick=\"deleteCom(\'"+com_no+"','"+m_id+"')\"  type='button' value='삭제'> ";
			str+="</tr>";
			
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
						alert("수정 성공!");
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
						alert("삭제 성공!");
						showCommandList();
					}	
				}
			});
		}// 댓글 삭제 끝
		
		//대댓글 쓸 양식 띄우기
		function showReplyForm(com_no){
			var x = document.getElementById('replyForm'+com_no);
			x.style.display = "table-row";
		}

		//대댓글 작성하기
		function writeReply(com_no){
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
							alert("댓글 달기 성공!");
							showCommandList();
							}else{
								alert("댓글 달기 실패");
							}
						}
					});
				}
				
			});
		}
	</script>
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
						str+="<input type='button' value='찜하기' onclick=\"getCart(\'"+c_no+"','"+m_id+"')\">";
					}else{
						str+="<input type='button' value='찜취소' onclick=\"cancelCart(\'"+c_no+"','"+m_id+"')\">";
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
						alert("찜 삭제 성공!");
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
						alert("찜 성공!");
						ajaxCart();
					}else{
						alert("찜 실패..");
					}
				}
			});

		}
	</script>
	
	<script type="text/javascript">
		
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
						str+="<input type='button' value='좋아요!' onclick=\"updateLike(\'"+c_no+"','"+m_id+"')\">";
					}else{
						str+="<input type='button' value='좋아요 취소!' onclick=\"deleteLike(\'"+c_no+"','"+m_id+"')\">";
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
							alert('좋아요 취소 성공');
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
				data:{
					c_no:c_no,
					m_id:m_id
				},
				dataType:"text",
				success:function(data){
					if(data==1){
						alert("좋아요 성공");
						refreshLike();
						ajaxLike();
					}else{
						alert('좋아요 실패');
					}
				}
			});
		}
		
		function refreshLike(){
			var c_no = ${detailCon.c_no};
			$.ajax({
				url:"<%=context%>/countLike",
				data:{c_no:c_no},
				dataType:"text",
				success:function(data){
					$('#likeCnt').remove();
					str="<span id='likeCnt'>좋아요 갯수 : "+data+"</span>";
					$('#likeCnt_Form').append(str);
				}
			});
		}
	</script>

	<div class="map_frame">
		<h4 style="text-align:center">위치</h4>
		<div id="map"></div>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=305c011011120570401d05c2d7aa7081"></script>
		<script type="text/javascript">
			var map_x = ${detailCon.c_map_x}; 
			var map_y = ${detailCon.c_map_y};
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(map_x,map_y), //지도의 중심좌표.
				draggable: false, // 스크롤로 확대/축소 막기
				level : 3
			//지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

			// 마커가 표시될 위치입니다 
			var markerPosition = new kakao.maps.LatLng(map_x,map_y);

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				position : markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);

			// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			// marker.setMap(null);    
			
			var iwContent = '<div style="padding:5px;" class="map_icon">${detailCon.c_title}<br><a href="https://map.kakao.com/link/map/${detailCon.c_title},${detailCon.c_map_x},${detailCon.c_map_y}" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/${detailCon.c_title},${detailCon.c_map_x},${detailCon.c_map_y}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    		iwPosition = new kakao.maps.LatLng(map_x,map_y); //인포윈도우 표시 위치입니다


			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				position : iwPosition,
				content : iwContent
			});

			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map);
		</script>
	</div>
	
	<input type="hidden" id="m_id" value="${m_id}" >
	<c:if test="${m_id != null}">
		<table style="height: 100px;">
			<tr>
				<th>
					<textarea id="comWriteArea" rows="2" cols="100"></textarea>
				</th>
				<th> 
					<input type="button" id="insertCom" value="댓글 작성하기" onclick="writeCom()"> 
				</th>
			</tr>
		</table>
	</c:if>
	<table id="command_table">
		<tr>
			<th>댓글 번호</th>
			<th>작성자</th>
			<th>댓글 내용</th>
			<th>수정</th>
			<th>삭제</th>
			<th>답글달기</th>
		</tr>
		<tbody id="command_tr">
			<c:forEach var="com" items="${comList}">
				<tr id="com${com.com_no}">
					<td> ${com.com_no}</td>
					<td> ${com.m_id}</td>
					<td id="com_contents${com.com_no}">
						 <c:forEach begin="1" end="${com.com_Indent}">-</c:forEach>
						 ${com.com_contents}
					</td>
					<c:choose>
						<c:when test="${com.m_id == m_id}">
							<td><input onclick="updateform('${com.com_no}','${com.m_id}','${com.com_contents}')" type="button" value="수정"></td>
							<td><input onclick="deleteCom('${com.com_no}','${com.m_id}')" type="button" value="삭제"></td>
						</c:when>
						<c:otherwise>
							<td></td>
							<td></td>
						</c:otherwise>
					</c:choose>
					<c:if test="${m_id != null}"><td><input onclick="showReplyForm('${com.com_no}')" type="button" value="댓글 달기"></td></c:if>				
				</tr>
				<tr id="replyForm${com.com_no}" style="display:none;">
					<td colspan="5"><textarea id="replyWriteArea${com.com_no}" rows="2" cols="80"></textarea></td>
					<td><input type="button" value="댓글 쓰기" onclick="writeReply('${com.com_no}')"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<%@include file="../footer.jsp"%>
</body>
</html>