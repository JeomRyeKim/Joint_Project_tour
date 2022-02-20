<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>+82Trip</title>
<%@include file="boot.jsp" %>
<style>
input:focus {outline:none;}
</style>
<%
	String context = request.getContextPath();
    System.out.println("context->"+context);
%>
</head>
<body>
<%@include file="../header1.jsp" %> 
<%@include file="../header2.jsp" %> 
<div class="container mb-5 mt-5 text-secondary">
<c:if test="${msg!=null}">${msg}</c:if>
<h5>
  <c:if test="${boardDetail.b_lock == 'y'}">
  	<img src='image/lock.png' width="15" height="auto"> 
  </c:if>
  <c:if test="${boardDetail.b_kind eq 1}">
 	<td>[자유] </td>
  </c:if>
  <c:if test="${boardDetail.b_kind eq 2}">
 	<td>[후기] </td>
  </c:if>
  <c:if test="${boardDetail.b_kind eq 3}">
 	<td>[QnA] </td>
  </c:if>
  <c:if test="${boardDetail.b_kind eq 4}">
 	<td>[공지사항] </td>
  </c:if>
 ${boardDetail.b_title}

</h5>
<p><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
</svg> ${boardDetail.m_nickname} | 

<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
</svg> <fmt:formatDate pattern = "yyyy-MM-dd" value="${boardDetail.b_date}"/> | 

<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
</svg> ${boardDetail.b_hit}
<hr>
<div class="container mt-3 mb-3 ml-2 mr-2">
<c:if test="${boardDetail.b_filename != null}">
	<p><img class="mx-auto d-block" alt="게시판 이미지" src="resources/image/board/${boardDetail.b_filename}" width="500px" height="auto">
</c:if>
<p>${boardDetail.b_contents}
<pre>

</pre>
<!-- 좋아요 -->
<c:choose>
  <c:when test='${b_like_check == "y"}'> <!-- 좋아요O 사람에게 보이는 이미지 : 회원 -->
    <a href="javascript:like_func();" style="text-decoration:none;">
      <img src='image/like/heart_like.png' id="like_img" class="likeImage mx-auto d-block" width="50" height="auto">
      <input type="text" id="b_like_cnt" class="h4 mx-auto d-block" style="border:none; background-color:transparent; text-align: center;" value="${boardDetail.b_like_cnt}" readonly>
    </a> 
    </c:when>
    <c:otherwise> <!-- 좋아요X 사람에게 보이는 이미지 : 회원 or 비회원 -->
      <a href="javascript:like_func();" style="text-decoration:none;">
        <img src='image/like/heart_dislike.png' id="like_img" class="likeImage mx-auto d-block" width="50" height="auto">
        <input type="text" id="b_like_cnt" class="h4 mx-auto d-block" style="border:none; background-color:transparent; text-align: center;" value="${boardDetail.b_like_cnt}" readonly>
      </a> 
    </c:otherwise>
</c:choose> 
</div>
</div>


<input type="hidden" id="session_id" value="${sessionScope.m_id}"> 
<input type="hidden" id="b_like_check" value="${b_like_check}">
<div class="container mt-3 md-6">
	<div class="row"><hr></div>
</div>
<input type="hidden" id="b_id" value="${boardDetail.m_id}"> <!-- 게시글 작성자 -->
<input type="hidden" id="m_kind" value="${param.m_kind}"> <!-- session 회원 유형 -->
<!-- 댓글 -->
<div class="container md-6 mt-4 p-5 bg-light rounded">
    <div>
    <label for="content"><b class="h5 text-secondary">댓글 <input id="commentCnt" class="h5" style="border:none; width: 40px; color: #FFC478; background-color:transparent;" value="0" readonly="readonly"></b></label>
    <label><input type="checkbox" id="checkLock" value="" class="text-secondary"> 비밀글</label>
    </div>
    <form name="commentInsertForm" class="mt-3 md-6">
        <div class="input-group">
           <input type="hidden" id="bc_kind" name="b_kind" value="${boardDetail.b_kind}"/>
           <input type="hidden" id="b_no" name="b_no" value="${boardDetail.b_no}"/>
           <input type="hidden" id="bc_nickname" name="bc_nickname" value="${param.m_nickname}">
           <input type="hidden" id="m_id" name="m_id" value="${sessionScope.m_id}">
           <input type="hidden" id="bc_Group" name="bc_Group" value="${boardDetail.b_Group}">
		   <input type="hidden" id="bc_lock" name="bc_lock" value="n">
           <c:if test="${sessionScope.m_id != null}">
	           <input type="text" class="form-control" height="100" id="bc_contents" name="bc_contents" placeholder="내용을 입력하세요.">
	           <span class="input-group-btn">
	                <button style="background-color: #BBDFC8;" class="btn btn-outline-light text-white" type="button" name="commentInsertBtn">등록</button>
	           </span>
           </c:if>
           <c:if test="${sessionScope.m_id == null}">
           		<input type="text" class="form-control" height="100" id="bc_contents" name="bc_contents" placeholder="로그인 하세요">
           </c:if>
        </div>
    </form>
</div>
<pre>

</pre>
<input type="hidden" id="bc_no" name="bc_no" value=""/>
<div class="container">
    <div class="commentList"></div>
</div>
<pre>

</pre>
<form action="HJBoardmodifyForm?m_id=${sessionScope.m_id}&b_kind=${boardDetail.b_kind}&b_no=${boardDetail.b_no}" 
	  method="post" enctype="multipart/form-data">
<input type="hidden" id="b_kind" name="b_kind" value="${boardDetail.b_kind}">
<input type="hidden" id="b_title" name="b_title" value="${boardDetail.b_title}">
<input type="hidden" id="m_nickname" name="m_nickname" value="${boardDetail.m_nickname}">
<input type="hidden" id="b_hit" name="b_hit" value="${boardDetail.b_hit}">
<input type="hidden" id="b_filename" name="b_filename" value="${boardDetail.b_filename}">
<input type="hidden" id="b_contents" name="b_contents" value="${boardDetail.b_contents}">
<input type="hidden" id="b_lock" name="b_lock" value="${boardDetail.b_lock}">
<input type="hidden" id="b_notice" name="b_notice" value="${boardDetail.b_notice}">
<input type="hidden" id="b_Group" name="b_Group" value="${boardDetail.b_Group}">
<input type="hidden" id="b_Step" name="b_Step" value="${boardDetail.b_Step}">
<input type="hidden" id="b_Indent" name="b_Indent" value="${boardDetail.b_Indent}">
<div class="container mt-3 md-6">
  <c:choose>
    <c:when test="${sessionScope.m_id == boardDetail.m_id}"> <!-- 본인이 쓴 글일 때 -->
      <button type="button" style="background-color: #FFC478;" class="btn btn-outline-light text-white" onclick="boardDel();">삭제</button>
	  <input type="submit" value="수정" style="background-color: #F0E5D8;" class="btn btn-outline-light text-white">
  	  <a href="HJboardReply_view?b_kind=${boardDetail.b_kind}&b_no=${boardDetail.b_no}&m_id=${sessionScope.m_id}&b_Group=${boardDetail.b_Group}&b_Step=${boardDetail.b_Step}&b_Indent=${boardDetail.b_Indent}"
  	   	  style="background-color: #BBDFC8;" class="btn btn-outline-light text-white">답변</a>
    </c:when>
    <c:when test="${sessionScope.m_kind == 2}"> <!-- 관리자일 때 -->
      <button type="button" style="background-color: #FFC478;" class="btn btn-outline-light text-white" onclick="boardDel();">삭제</button>
	  <input type="submit" value="수정" style="background-color: #F0E5D8;" class="btn btn-outline-light text-white">
	  <a href="HJboardReply_view?b_kind=${boardDetail.b_kind}&b_no=${boardDetail.b_no}&m_id=${sessionScope.m_id}&b_Group=${boardDetail.b_Group}&b_Step=${boardDetail.b_Step}&b_Indent=${boardDetail.b_Indent}"
	 	 style="background-color: #BBDFC8;" class="btn btn-outline-light text-white">답변</a>
    </c:when>
    <c:when test="${sessionScope.m_id == null}"></c:when>
    <c:when test="${sessionScope.m_id != boardDetail.m_id}"> <!-- 다른 사람 글을 볼 때 -->
	  <a href="HJboardReply_view?b_kind=${boardDetail.b_kind}&b_no=${boardDetail.b_no}&m_id=${sessionScope.m_id}&b_Group=${boardDetail.b_Group}&b_Step=${boardDetail.b_Step}&b_Indent=${boardDetail.b_Indent}"
	  	 style="background-color: #BBDFC8;" class="btn btn-outline-light text-white">답변</a>
    </c:when>
    <c:otherwise></c:otherwise>
  </c:choose>
  	  <a href="/HJBoard?m_id=${sessionScope.m_id}" style="background-color: #75CFB8;" class="btn btn-outline-light text-white">목록</a>
</div>
</form>
<pre>

</pre>
<%@include file="../footer.jsp" %>
<script>
function like_func(){
	if(${sessionScope.m_id == null}){
		Swal.fire({ 
			icon: 'warning', // Alert 타입 
			title: '좋아요', // Alert 제목 
			text: '로그인 해주세요' // Alert 내용 
		});
	}else { 
		var selB_like_check = $('#b_like_check').val();
// 		alert("selB_like_check->" + selB_like_check);
		var selB_kind = ${boardDetail.b_kind};
		var selB_no = ${boardDetail.b_no};
		var session_id = document.getElementById('session_id').value;
// 		alert("selB_kind->" + selB_kind + ", selB_no->" + selB_no);
// 		alert('session_id->' + session_id);
		
// 		alert("좋아요를 누르시겠습니까?");
		$.ajax(
				{
					url:"<%=context%>/HJBoardLike",
					data:{b_kind : selB_kind , b_no : selB_no, m_id : session_id, b_like_check : selB_like_check}, 
					dataType:'json', 
					success:function(data){
// 						alert("ajax 좋아요 y여부 data.BLikeChk->" + data.BLikeChk);
// 						alert("ajax 좋아요 n여부 data.BLikeChk_n->" + data.BLikeChk_n);
// 						alert("ajax 좋아요 insert 여부 data.insert_bl->" + data.insert_bl);
// 						alert("ajax 좋아요 b_like_cnt +1여부 data.like_b->" + data.like_b);
// 						alert("ajax 좋아요 update 여부 data.update_bl->" + data.update_bl);
// 						alert("ajax 좋아요 b_like_check 'y' -> 'n'으로 변경 여부 data.dislike_bl->" + data.dislike_bl);
// 						alert("ajax 좋아요b_like_cnt -1여부 data.dislike_b->" + data.dislike_b);
// 						alert("ajax 좋아요 y or n여부 data.b_like_check->" + data.b_like_check);
// 						alert("ajax 좋아요 총 개수 data.b_like_cnt->" + data.b_like_cnt);
						
						$("#b_like_check").val(data.b_like_check);
						$("#b_like_cnt").val(data.b_like_cnt);
						if(data.b_like_check == 'y'){
							document.getElementById("like_img").src = "./image/like/heart_like.png";
						}else{
							document.getElementById("like_img").src = "./image/like/heart_dislike.png";
						}
					},
					error:function(){
						alert("좋아요 error났습니다!");
					}
				}
		);
	}
}
</script>
<script>
function boardDel(){
	var b_kind = "${boardDetail.b_kind}";
	var b_no = "${boardDetail.b_no}";
	var m_id = "${sessionScope.m_id}";
// 	alert("b_kind->" + b_kind + ", b_no->" + b_no + ", m_id->" + m_id);
	Swal.fire({
        title: '게시글 삭제',
        text: b_no + "번 글을 삭제하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#FFC478',
        cancelButtonColor: '#F0E5D8',
        confirmButtonText: '네',
        cancelButtonText: '아니오'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire(
                '게시글 삭제',
                '삭제 처리 되었습니다',
                'success'
            )
        	location.href="HJBoardDelete?b_kind="+b_kind+"&b_no="+b_no+"&m_id="+m_id;
        }
    });
}

var b_no = "${boardDetail.b_no}";
//	alert("b_no->" + b_no);
var bc_kind = $("#bc_kind").val();
//	alert("bc_kind->" + bc_kind);
var b_id = $("#b_id").val(); // 게시글 작성자
var session_m_kind = $("#m_kind").val(); // 회원 유형
// console.log("session_m_kind->" + session_m_kind);

//페이지 로딩시 댓글 목록 출력 
$(document).ready(function(){
	$("#checkLock").change(function(){
// 		alert("비밀글 여부를 변경합니다");
        if($("#checkLock").is(":checked")){
           $("#bc_lock").val("y");
        }else{
           $("#bc_lock").val("n");
        }
        var bc_lock = $("#bc_lock").val();
//         alert("bc_lock->" + bc_lock);
    });
    
	$(document).on('click', 'input[name=commentLock]', function(){
// 	    console.log(this);
// 		alert("비밀글 여부를 변경합니다");
        if($("#commentLock").is(":checked")){
           $("#c_lock").val("y");
        }else{
           $("#c_lock").val("n");
        }
        var c_lock = $("#c_lock").val();
//         alert("c_lock->" + c_lock);
	});
    commentList(); 
});

//댓글 등록 버튼 클릭시 
$('[name=commentInsertBtn]').click(function(){ 
	if(document.getElementById('bc_contents').value == ""){
		Swal.fire({ 
			icon: 'warning', // Alert 타입 
			title: '댓글 작성', // Alert 제목 
			text: '내용을 입력해 주세요' // Alert 내용 
		});
	}else if(document.getElementById('bc_contents').value != ""){
	    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
// 	    alert("insertData->" + insertData); // insertData->b_no=230&b_kind=5&c_nickname=zinoxxl&c_lock=n&c_contents=hi
	    commentInsert(insertData); //Insert 함수호출(아래)
	}
});
document.querySelector('#bc_contents').addEventListener('keypress', function (e) {
	if (e.key === 'Enter') {
// 	alert("#bc_contents enter");
		if(document.getElementById('bc_contents').value == "" && document.getElementById('session_id').value == ""){
			alert("로그인 후 이용해주세요");
// 			Swal.fire({ 
// 				icon: 'warning', // Alert 타입 
// 				title: '댓글 작성', // Alert 제목 
// 				text: '로그인 해주세요' // Alert 내용 
// 			});
		}else if(document.getElementById('bc_contents').value == "" && document.getElementById('session_id').value != ""){
			alert("댓글 내용을 입력해 주세요");
// 			Swal.fire({ 
// 				icon: 'warning', // Alert 타입 
// 				title: '댓글 작성', // Alert 제목 
// 				text: '내용을 입력해 주세요' // Alert 내용 
// 			});
		}else if(document.getElementById('bc_contents').value != ""  && document.getElementById('session_id').value != ""){
		   var insertData = $('[name=commentInsertForm]').serialize();
		// 	      alert("insertData->" + insertData);
		   commentInsert(insertData);
		}
	}
});

//댓글 등록
function commentInsert(insertData){
    $.ajax({
        url : '<%=context%>/HJCommentInsert',
        type : 'post',
        data : insertData,
        dataType:'json',
        success : function(data){
//             alert("댓글 insert 성공!");
//             alert("data->" + data);
            commentList(); //댓글 작성 후 댓글 목록 reload
            $('[name=bc_contents]').val('');
        },
        error:function(){
        	alert("댓글 insert 에러!");
        }
    });
}

//댓글 목록 
function commentList(){
	// 댓글 개수 가져오기	
	$.ajax({
		url : '<%=context%>/HJCommentCnt',
		data : {b_no : b_no, b_kind : bc_kind},
		dataType:'text',
		success : function(data){
//         	alert("댓글 개수 가져오기 성공!");
//         	console.log("commentCnt->" + data);
          	$("#commentCnt").val(data);
		},
        error:function(){
        	alert("댓글 개수 가져오기 에러!");
        }
	});
	
	// 댓글 목록 가져오기
    $.ajax({
        url : '<%=context%>/HJCommentList',
        type : 'get',
        data : {b_no : b_no, b_kind : bc_kind},
        success : function(data){
//           	alert("댓글 리스트 가져오기 성공!");
    		var session_id = document.getElementById('session_id').value;
//     		console.log('session_id->' + session_id);
            var a ='';
            
            // 댓글 O
            if(data.length > 0){
            	for(const i in data){
                     let b_kind = data[i].b_kind;
                     let b_no = data[i].b_no;
                     let m_id = data[i].m_id;
                     let bc_no = data[i].bc_no;
                     let bc_contents = data[i].bc_contents;
                     let bc_date = data[i].bc_date;
                     let bc_Group = data[i].bc_Group;
                     let bc_Step = data[i].bc_Step;
                     let bc_Indent = data[i].bc_Indent;
                     let bc_lock = data[i].bc_lock;
                     let m_nickname = data[i].m_nickname;
                     let m_kind = data[i].m_kind;
                     
                     var date = data[i].bc_date.substring(0,10);
                     console.log("date->" + date);

//                      console.log("b_kind->" + b_kind);
//                      console.log("b_no->" + b_no);
//                      console.log("m_id->" + m_id);
//                      console.log("bc_no->" + bc_no);
//                      console.log("bc_contents->" + bc_contents);
                     console.log("bc_date->" + bc_date);
//                      console.log("bc_Group->" + bc_Group);
//                      console.log("bc_Step->" + bc_Step);
//                      console.log("bc_Indent->" + bc_Indent);
//                      console.log("bc_lock->" + bc_lock);
//                      console.log("m_nickname->" + m_nickname);
//                      console.log("m_kind->" + m_kind);
					 // 비밀글O, 댓글 작성자 or 관리자                  	 
                   	 if(bc_lock == 'y' && (session_id == m_id || session_m_kind == '2')){
	                     a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
		                 a += '<div id="bc_info" class="commentInfo' + bc_no+'" value="'+ m_id +'">';
                   		 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                   		 }
		                 a += '&nbsp;<b>' + m_nickname + '</b><a class="text-secondary" style="float: right; text-decoration: none;"> '+ date +'</a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentUpdate(' + bc_no + ',\''+ bc_contents +'\', \''+ bc_lock +'\');"> 수정 </a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentDelete(' + bc_no + ', '+ bc_Group + ', ' + bc_Step +');"> 삭제 </a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentReply(' + bc_no + ', '+ bc_Group +', '+ bc_Step +', '+ bc_Indent +');"> 답변  </a> </div>';
		                 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary">';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
		                 a += '&nbsp;&nbsp;<img src="image/lock.png" width="15" height="auto">&nbsp; '+ bc_contents + '</p></div>';
		                 a += '<div class="replyForm'+bc_no+'"></div></div>';
                   	 }// 비밀글O, 게시글 작성자
                   	 else if(bc_lock == 'y' && session_id == b_id){
                    	 a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
 		                 a += '<div class="commentInfo' + bc_no + '" value="'+ m_id +'">';
                   		 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
 		                 a += '&nbsp;<b>' + m_nickname + '</b><a class="text-secondary" style="float: right; text-decoration: none;"> '+ date +' </a>';
 		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentReply(' + bc_no + ', '+ bc_Group +', '+ bc_Step +', '+ bc_Indent +');"> 답변  </a> </div>';
 		                 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary">';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
 		                 a += '&nbsp;&nbsp;<img src="image/lock.png" width="15" height="auto">&nbsp; ' + bc_contents +'</p></div>';
 		                 a += '<div class="replyForm'+bc_no+'"></div></div>';
                   	 }//  비밀글O, 로그인X 
                   	 else if(bc_lock == 'y' && ${sessionScope.m_id == null}){
                      	 a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
                      	 a += '<div class="commentInfo' + bc_no + '">';
                   		 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
                      	 a += '<b>'+ date +'</b></div>';
                      	 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary">';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
                      	 a += '&nbsp;&nbsp;<img src="image/lock.png" width="15" height="auto">&nbsp; 해당 댓글은 작성자와 운영자만 볼 수 있습니다.</p>';
                         a += '</div></div>'; 
                     }// 비밀글O, 로그인O, 본인 댓글X or 관리자X or 게시글 작성자X
                   	 else if(bc_lock == 'y' && ${sessionScope.m_id != null} && (session_id != m_id || session_m_kind != '2' || session_id != b_id)){
                      	 a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
                      	 a += '<div class="commentInfo' + bc_no + '" value="'+ m_id +'">';
                   		 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
                      	 a += '<b>'+ date +'</b></div>';
                      	 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary">';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
                      	 a += '&nbsp;&nbsp;<img src="image/lock.png" width="15" height="auto">&nbsp; 해당 댓글은 작성자와 운영자만 볼 수 있습니다.</p>';
                         a += '</div></div>'; 
            		 }// 비밀글 X, 로그인O, 본인 댓글 or 관리자
                     else if(bc_lock == 'n' && ${sessionScope.m_id != null} && (session_id == m_id || session_m_kind == '2')){
                    	 a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
		                 a += '<div id="bc_info" class="commentInfo' + bc_no+'" value="'+ m_id +'">';
                    	 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
		                 a += '&nbsp;<b>' + m_nickname + '</b><a class="text-secondary" style="float: right; text-decoration: none;"> '+ date +' </a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentUpdate(' + bc_no + ',\''+ bc_contents +'\', \''+ bc_lock +'\');"> 수정 </a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentDelete(' + bc_no + ', '+ bc_Group + ', ' + bc_Step +');"> 삭제 </a>';
		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentReply(' + bc_no + ', '+ bc_Group +', '+ bc_Step +', '+ bc_Indent +');"> 답변  </a> </div>';
		                 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary"> ';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
		                 a += '&nbsp;&nbsp;'+ bc_contents + '</p></div>';
		                 a += '<div class="replyForm'+bc_no+'"></div></div>';
                     } // 비밀글 X, 로그인X
                     else if(bc_lock == 'n' && ${sessionScope.m_id == null}){
                    	 a += '<div class="commentArea row mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
 		                 a += '<div class="commentInfo' + bc_no + '">';
                    	 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
 		                 a += '&nbsp;<b>' + m_nickname + '</b><a class="text-secondary" style="float: right; text-decoration: none;"> '+ date +' </a></div>';
 		                 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary">';
                    	 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                   			}
                    	 }
 		                 a += '&nbsp;&nbsp;' + bc_contents +'</p>';
 		                 a += '</div></div>'; 
                     } // 비밀글 X, 로그인O, 본인 댓글X or 관리자X
                     else if(bc_lock == 'n' && ${sessionScope.m_id != null} && (session_id != m_id || session_m_kind != '2')){
                    	 a += '<div class="commentArea mt-3 md-3" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
 		                 a += '<div class="commentInfo' + bc_no + '" value="'+ m_id +'">';
                    	 if(bc_Indent > 0){
                   			for (let i = 0; i < bc_Indent; i++){ 
	   		         			 a += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">';
						   		 a += '	  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>';
						   	 	 a += '	</svg>';
                   			}
                    	 }
 		                 a += '&nbsp;<b>' + m_nickname + '</b><a class="text-secondary" style="float: right; text-decoration: none;"> '+ date +' </a>';
 		                 a += '<a class="text-secondary" style="text-decoration: none;" onclick="commentReply(' + bc_no + ', '+ bc_Group +', '+ bc_Step +', '+ bc_Indent +');"> 답변  </a> </div>';
 		                 a += '<div class="commentContent' + bc_no + '"> <p class="text-secondary"> ';
                    	 if(bc_Indent > 0){
                    			for (let i = 0; i < bc_Indent; i++){ 
 	   		         			 a += '&nbsp;&nbsp;&nbsp;&nbsp;';
                    			}
                     	 }
 		                 a += '&nbsp;&nbsp;'+ bc_contents +'</p></div>';
 		                 a += '<div class="replyForm'+bc_no+'"></div></div>';
                     }
                } // for(const i in data) 끝
            } // 댓글 O끝
            else{ // 댓글 X
	       		 a += "<div class=' mt-3 md-3'>";
	             a += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
	             a += "</table></div>";
	             a += "</div>";
       		}
            $(".commentList").html(a);
        }
    });
}

//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(bc_no, bc_contents, bc_lock){
    var a ='';
    
    if($("#bc_Replycontents").length > 0){
//     	alert("$('#bc_Replycontents').length > 0 - 대댓글 O");
    	commentList();
    }else{
//     	alert("$('#bc_Replycontents').length < 0 - 대댓글 X");
	    if(bc_lock == 'y'){
		    a += '<div class="input-group mt-3 md-3">';
		    a += '<input type="text" class="form-control" id="c_modify" onkeypress="c_modify(event, '+ bc_no +')" name="content_'+bc_no+'" value="'+bc_contents+'"/>';
		    a += '<span class="input-group-btn">';
		    a += '<label><input type="checkbox" id="commentLock" name="commentLock" value="" checked> 비밀글 </label>';
		    a += '<input type="hidden" id="c_lock" name="bc_lock_'+bc_no+'" value="' + bc_lock + '">';
		    a += '<button  style="background-color: #BBDFC8;" class="btn btn-outline-light text-white" type="button" onclick="commentUpdateProc('+bc_no+');"> 수정</button></span>';
		    a += '</div>';
	    }else{
		    a += '<div class="input-group mt-3 md-3">';
		    a += '<input type="text" class="form-control" id="c_modify" onkeypress="c_modify(event, '+ bc_no +')" name="content_'+bc_no+'" value="'+bc_contents+'"/>';
		    a += '<span class="input-group-btn">';
		    a += '<label><input type="checkbox" id="commentLock" name="commentLock" value=""> 비밀글 </label>';
		    a += '<input type="hidden" id="c_lock" name="bc_lock_'+bc_no+'" value="' + bc_lock + '">';
		    a += '<button  style="background-color: #BBDFC8;" class="btn btn-outline-light text-white" type="button" onclick="commentUpdateProc('+bc_no+');"> 수정</button></span>';
		    a += '</div>';
	    }
	    $('.commentContent'+bc_no).html(a);
    }
}
function c_modify(event, bc_no){
    if(event.keyCode == 13){
		if(document.getElementById('c_modify').value == "" || document.getElementById('c_modify').value == null){
			Swal.fire({ 
				icon: 'warning', // Alert 타입 
				title: '댓글 수정', // Alert 제목 
				text: '댓글 수정 내용을 입력해 주세요' // Alert 내용 
			});
		}else if(document.getElementById('c_modify').value != "" || document.getElementById('c_modify').value != null){
		    var updateContent = $('[name=content_'+bc_no+']').val();
		    var updateBc_lock = $('[name=bc_lock_'+bc_no+']').val();
		    $.ajax({
		        url : '<%=context%>/HJCommentUpdate',
		        type : 'post',
		        data : {'bc_contents' : updateContent, bc_no : bc_no, b_no : b_no, b_kind : bc_kind, 'bc_lock' : updateBc_lock},
		        success : function(data){
// 		        	alert("댓글 수정 완료!");
		            if(data > 0)  commentList(); //댓글 수정후 목록 출력 
		        },
		        error:function(){
		        	alert("댓글 수정 에러!");
		        }
		    });
		}
    }
}
var lock = $("#lock").val();
//댓글 수정
function commentUpdateProc(bc_no){
    var updateContent = $('[name=content_'+bc_no+']').val();
    var updateBc_lock = $('[name=bc_lock_'+bc_no+']').val();
//     console.log("updateContent->" + updateContent);
//     console.log("updateBc_lock->" + updateBc_lock);

    if(document.getElementById('c_modify').value == "" || document.getElementById('c_modify').value == null){
		Swal.fire({ 
			icon: 'warning', // Alert 타입 
			title: '댓글 수정', // Alert 제목 
			text: '댓글 수정 내용을 입력해 주세요' // Alert 내용 
		});
	}else{
	    $.ajax({
	        url : '<%=context%>/HJCommentUpdate',
	        type : 'post',
	        data : {'bc_contents' : updateContent, bc_no : bc_no, b_no : b_no, b_kind : bc_kind, 'bc_lock' : updateBc_lock},
	        success : function(data){
// 	        	alert("댓글 수정 완료!");
	            if(data > 0)  commentList(); //댓글 수정후 목록 출력 
	        },
	        error:function(){
	        	alert("댓글 수정 에러!");
	        }
	    });
	}
}

// 댓글 삭제 
function commentDelete(bc_no, bc_Group, bc_Step){
// 	alert("bc_Group->" + bc_Group);
// 	alert("bc_Step->" + bc_Step);
	Swal.fire({
        title: '댓글 삭제',
        text: bc_no + "번 댓글을 삭제하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#FFC478',
        cancelButtonColor: '#F0E5D8',
        confirmButtonText: '네',
        cancelButtonText: '아니오'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url : '<%=context%>/HJCommentDelete',
                type : 'post',
                data : {bc_no : bc_no, b_no : b_no, b_kind : bc_kind, bc_Group : bc_Group, bc_Step : bc_Step},
                dataType:'text',
                success : function(data){
//                 	alert("댓글 삭제 완료!");
					Swal.fire({ 
						icon: 'success', // Alert 타입 
						title: '댓글 삭제', // Alert 제목 
						text: '댓글이 삭제되었습니다' // Alert 내용 
					});
                    if(data > 0) commentList(); //댓글 삭제후 목록 출력 
                },
                error:function(){
                	alert("댓글 삭제 에러!");
                }
            });
        }
    });
}

// 대댓글 달기 - 대댓글 다는 input폼으로 변경
function commentReply(bc_no, bc_Group, bc_Step, bc_Indent){
	var a ='';
	
    if($("#c_modify").length > 0){
//     	alert("$('#c_modify').length > 0 - 수정 O");
    	commentList();
    }else{
//     	alert("$('#c_modify').length == 0 - 수정 X");
		a += '<form name="commentReplyForm">';
	    a += '<div class="input-group mt-3 md-3">';
	    a += '<input type="hidden" id="bc_kind" name="b_kind'+bc_no+'" value="${boardDetail.b_kind}"/>';
	    a += '<input type="hidden" id="b_no" name="b_no'+bc_no+'" value="${boardDetail.b_no}"/>';
	    a += '<input type="hidden" id="m_id" name="m_id'+bc_no+'" value="${sessionScope.m_id}">';
	    a += '<input type="hidden" id="bc_no" name="bc_no'+bc_no+'" value="'+ bc_no +'"/>';
	    a += '<input type="hidden" id="bc_Group" name="bc_Group'+bc_no+'" value="'+ bc_Group +'">';
	    a += '<input type="hidden" id="bc_Step" name="bc_Step'+bc_no+'" value="'+ bc_Step +'">';
	    a += '<input type="hidden" id="bc_Indent" name="bc_Indent'+bc_no+'" value="'+ bc_Indent +'">';
	    a += '<input type="text" class="form-control" id="bc_Replycontents" name="bc_contents'+bc_no+'" placeholder="내용을 입력하세요." required/>';
	    a += '<span class="input-group-btn">';
	    a += '<label><input type="checkbox" id="commentLock" name="commentLock" value=""> 비밀글 </label>';
	    a += '<input type="hidden" id="c_lock" name="bc_lock'+bc_no+'" value="">';
	    a += '<button style="background-color: #BBDFC8;" class="btn btn-outline-light text-white" type="button" onclick="commentReplyProc('+bc_no+');"> 등록</button></span>';
	    a += '</div></form>';
		
	    $('.replyForm'+bc_no).html(a);
    }
}

// function c_reply(event, bc_no){
//     if(event.keyCode == 13){
//     	alert("document.getElementById('bc_Replycontents').value->" + document.getElementById('bc_Replycontents').value);
// 		if(document.getElementById('bc_Replycontents').value == "" && document.getElementById('bc_contents').value == ""){
// 			alert("댓글 답변 내용을 입력해 주세요!");
// 		}else if(document.getElementById('bc_Replycontents').value != "" && document.getElementById('bc_contents').value == ""){
// 			commentReplyProc(bc_no);
// 		}
//     }
// }

//대댓글 달기
function commentReplyProc(bc_no){
	var ReplyB_kind = $('[name=b_kind'+bc_no+']').val();
	var ReplyB_no = $('[name=b_no'+bc_no+']').val();
	var ReplyM_id = $('[name=m_id'+bc_no+']').val();
	var ReplyBc_no = $('[name=bc_no'+bc_no+']').val();
	var ReplyBc_Group = $('[name=bc_Group'+bc_no+']').val();
	var ReplyBc_Step = $('[name=bc_Step'+bc_no+']').val();
	var ReplyBc_Indent = $('[name=bc_Indent'+bc_no+']').val();
	var ReplyBc_contents = $('[name=bc_contents'+bc_no+']').val();
	var ReplyBc_lock = $('[name=bc_lock'+bc_no+']').val();
	
// 	console.log("ReplyB_kind->" + ReplyB_kind);
// 	console.log("ReplyB_no->" + ReplyB_no);
// 	console.log("ReplyM_id->" + ReplyM_id);
// 	console.log("ReplyBc_no->" + ReplyBc_no);
// 	console.log("ReplyBc_Group->" + ReplyBc_Group);
// 	console.log("ReplyBc_Step->" + ReplyBc_Step);
// 	console.log("ReplyBc_Indent->" + ReplyBc_Indent);
// 	console.log("ReplyBc_contents->" + ReplyBc_contents);
// 	console.log("ReplyBc_lock->" + ReplyBc_lock);
	
	if(document.getElementById('bc_Replycontents').value == "" || document.getElementById('bc_Replycontents').value == null){
		Swal.fire({ 
			icon: 'warning', // Alert 타입 
			title: '댓글 답변', // Alert 제목 
			text: '댓글 답변 내용을 입력해 주세요' // Alert 내용 
		});
	}else if(document.getElementById('bc_Replycontents').value != "" || document.getElementById('bc_Replycontents').value != null){
	    $.ajax({
	        url : '<%=context%>/HJCommentReply',
	        type : 'post',
	        data : {b_kind : ReplyB_kind, b_no : ReplyB_no, m_id : ReplyM_id, bc_no : ReplyBc_no, bc_Group : ReplyBc_Group,
	        		bc_Step : ReplyBc_Step, bc_Indent : ReplyBc_Indent, bc_contents : ReplyBc_contents, bc_lock : ReplyBc_lock},
	        dataType:'text',
	        success : function(data){
// 	            alert("댓글 답변 입력 성공!");
// 	            alert("data->" + data);
	            commentList();
	        },
	        error:function(){
	        	alert("댓글 답변 입력 에러!");
	        }
	    });
	}
}
</script>
</body>
</html>