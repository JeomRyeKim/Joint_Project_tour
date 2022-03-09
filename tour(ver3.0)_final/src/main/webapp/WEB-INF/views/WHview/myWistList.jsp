<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>+82Trip</title>
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

.planD-navbox__a--blue:hover {
    color: #000000;
}


.planD-navbox {
    width: 220px;
    height: 530px;
    position: absolute;
    display: inline-block;
    margin: 40px auto;
    background-color: #737373;
}

.planD-navbox__ul--blue {
    list-style-type: none;
    margin: 25px 0 0 22px;
    padding: 0;
    color: white;
    width: 170px;
    font-weight: 700;
}

.planD-navbox__li--big {
    height: 56px;
    font-size: 20px;
    color: white;
    border-bottom: 3px solid #abb2c7;
    line-height: 60px;
    font-family: 'Nanum Gothic', sans-serif;
    font-weight: bold;
}

.planD-navbox__li--small {
    margin: 30px 0 30px 6px;
}

.planD-navbox__a--blue {
    font-size: 17px;
    text-decoration: none;
    color: white;
    font-family: 'Nanum Gothic', sans-serif;
    font-weight: bold;
}

.planD-navbox__img--small {
    width: 18px;
    height: 18px;
    vertical-align: sub;
}

</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
	<div class="header" style="position: sticky; width: 100%; z-index: 10; top: 0px; background-color: white; margin-top: -50px;">
	<%@include file="../header1.jsp" %>
     </div>
<%-- <div class="planL-navbox__long">
	    <div class="planL-navbox">
	        <ul class="planL-navbox__ul--blue">
	            <li class="planL-navbox__li--big"> myPage </li>
	            <li class="planL-navbox__li--id">[ <a style="color: #1565C0;">${sessionScope.m_id}</a> ] 님의 마이페이지</li>
	            <li class="planL-navbox__li--small"><a href=url:"<%=context%>/myInfo2" class="planL-navbox__a--blue">
	            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
	  					<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
					</svg>&nbsp;  나의 정보</a></li>
	            <li class="planL-navbox__li--small"><a href="<%=context%>/myWishList" class="planL-navbox__a--blue">
	            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-table" viewBox="0 0 16 16" style="width: 22px; height: 22px; margin-left: 3px;">
	  					<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
					</svg>&nbsp;&nbsp;  나의 찜목록</a></li>
	        </ul>
	    </div>
    </div> --%>
	
	<div class="container" id="main" style="background: linear-gradient(to right, #fffaf7, #fff5f3);">
	<h2 style="text-align: center; margin: 20px 0px;">나의 찜 목록</h2>
	<div class="cotainer-sm" style="margin-top:50px;">
	<button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px; background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="checkDelete()"> 찜목록 삭제 </button>
	</div>
	<div id="asd">
	<div class="content-item-detail" id="wishList1" style="margin-top: 100px;">
		<c:forEach var="contents" items="${contents}" varStatus="status">
			<div class="detail-items" id="WishList" >
					<a class="content_title" href="detail?c_no=${contents.c_no}">${contents.c_title}
					<img class="image_box"
					src="resources/image/${contents.c_local}/${contents.c_image1}">
					<input type="hidden" value="${contents.c_no}" id="c_no">
					</a>
					<input type="checkbox" id="checkbox1" style="float: right;" name="check_mid" value="${contents.c_no}">
			</div>
		</c:forEach>
	</div>
	</div>
	<form  action="/wishListSearch" method="get"  style="position:absolute; margin-left: 30px;">
			<input type="text" id="keyword" name="keyword" class="mb-3">
			<input type="hidden" id="m_id" name="m_id" value="${sessionScope.m_id}">
			<button type="submit" class="btn text-white" style="width:100px; background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="search()">검색</button>
	</form>
	</div>
	<div id="box" style="margin-top: 100px;">
	<%@include file="../footer.jsp"%>
	</div>
</body>
<script type="text/javascript">
//체크박스 선택 후 삭제 버튼 클릭시 이벤트 
function checkDelete(){
	var checkBoxArr = new Array(); 
	var cnt=$("input:checkbox[name='check_mid']:checked").length;
	  $("input:checkbox[name='check_mid']:checked").each(function() {
	  checkBoxArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	  });
	  if(cnt==0){
		  Swal.fire({
              icon: 'warning',
              title: '체크한 체크박스가 없습니다',
          });
	  }
	  $.ajax({
			//처리할 컨트롤러 물리적 삭제
			url:"<%=context%>/wishListDelete",      
			data:{checkBoxArr:checkBoxArr}, //파라미터 키, 벨류 형태로 보냄  
			dataType:'json',
			success:function(data){
				var str="";
				Swal.fire({
		              icon: 'success',
		              title: '찜목록 삭제완료',
		              text: '삭제되었습니다',
		          });
				 $('#wishList1').remove();
				 str+="<div class='content-item-detail' id='wishList1' style='margin-top: 100px; padding: 0 10px; display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 20px 10px; grid-template-rows: repeat("+data[0].total+",200px);'>";
				 $(data).each(
					function(){
					 
					 str+="<div class='detail-items' id='WishList' >";
					 str+="<a class='content_title' href='detail?c_no="+this.c_no+"'>'"+this.c_title+"'";
					 str+="<img class='image_box' src='resources/image/"+this.c_local+"/"+this.c_image1+"'>";		 
					 str+="<input type='hidden' value='"+this.c_no+"' id='c_no'>";
					 str+="</a>";
					 str+="<input type='checkbox' id='checkbox1' style='float: right;' name='check_mid' value='"+this.c_no+"'>";
					 str+="</div>";
					});
				 str+="</div>";
				 $('#asd').append(str);
					 
				 }
			});
	}

function search(){
	var keyword=$('#keyword').val();
	var m_id = $('#m_id').val();
	
	$.ajax({
		url:"<%=context%>/wishListSearch",      
		data:{keyword:keyword,m_id:m_id}, //파라미터 키, 벨류 형태로 보냄  
		dataType:'json',
		success:function(data){
			var str="";
			 $('#wishList1').remove();
			 str+="<div class='content-item-detail' id='wishList1' style='margin-top: 100px; padding: 0 10px; display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 20px 10px; grid-template-rows: repeat("+data[0].total+",200px);'>";
			 $(data).each(
				function(){
				 
				 str+="<div class='detail-items' id='WishList' >";
				 str+="<a class='content_title' href='detail?c_no="+this.c_no+"'>'"+this.c_title+"'";
				 str+="<img class='image_box' src='resources/image/"+this.c_local+"/"+this.c_image1+"'>";		 
				 str+="<input type='hidden' value='"+this.c_no+"' id='c_no'>";
				 str+="</a>";
				 str+="<input type='checkbox' id='checkbox1' style='float: right;' name='check_mid' value='"+this.c_no+"'>";
				 str+="</div>";
				});
			 str+="</div>";
			 $('#asd').append(str);
				 
			 }
	
	
	});
	
	
}
</script>
</html>