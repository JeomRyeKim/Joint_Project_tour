<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.content-item-detail {
	padding: 0 10px;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	gap: 20px 10px;
	grid-template-rows: repeat(${total},200px);
}
.detail-items {
	position: relative;
}

.image_box {
	position: absolute;
	top: 15%;
	left: 10%;
	width: 80%;
	height: 80%;
	object-fit: cover;
}

.content_title {
	display: block;
	text-align: center;
}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
//체크박스 선택 후 삭제 버튼 클릭시 이벤트 
 
 
function checkDelete(){
	var checkBoxArr = new Array(); 
	  $("input:checkbox[name='check_mid']:checked").each(function() {
	  checkBoxArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	  });
	  $.ajax({
			//처리할 컨트롤러 물리적 삭제
			url:"<%=context%>/wishListDelete",      
			data:{checkBoxArr:checkBoxArr}, //파라미터 키, 벨류 형태로 보냄  
			dataType:'text',
			success:function(data){
				alert("성공");
				$('#WishList').remove();
			}
		});
	}

function wishDelete1(Vindex){
	console.log(Vindex);
	alert("wishList->"+Vindex);
	var c_no = $('#c_no'+Vindex).val();
	alert("c_no="+c_no);
	$('#WishList'+Vindex).remove();
	$('#btn_Check'+Vindex).remove();
}

</script>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>

	<h2 style="text-align: center; margin: 20px 0px;">나의 찜 목록</h2>
	<input type="button" onclick="checkDelete()" value="삭제">
	<div class="content-item-detail">
		<c:forEach var="contents" items="${contents}" varStatus="status">
			<div class="detail-items" id="WishList${status.index}">
					<a class="content_title" href="detail?c_no=${contents.c_no}">${contents.c_title}
					<img class="image_box"
					src="resources/image/${contents.c_local}/${contents.c_image1}">
					<input type="hidden" value="${contents.c_no}" id="c_no${status.index}">
					</a>
				</div>
			<input type="checkbox" name="check_mid" value="${contents.c_no}">
		</c:forEach>
	</div>
	<div>
		<form action="/myWishList/search">
			<input type="text" id="keyword" name="keyword">
			<input type="hidden" id="m_id" name="m_id" value="${sessionScope.m_id}">
			<button type="submit"  onclick="search()">검색</button>
		</form>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>