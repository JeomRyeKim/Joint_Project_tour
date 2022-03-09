<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>+82Trip</title>
<%@include file="boot.jsp" %>
<style>
.select_img img{margin: 20px 0;}
</style>
</head>
<body>
<div class="header" style="position: sticky; width: 100%; z-index: 10; top: 0px; background-color: white; margin-top: -50px;">
	<%@include file="../header1.jsp" %>
</div>
<div class="container mt-5">
<h4><b style="color: #75CFB8">게시판 글수정</b></h4>
<hr>
<pre>

</pre>
<%-- 	<br>m_id : ${m_id} --%>
<c:if test="${msg!=null}">${msg}</c:if>
<form action="HJBoardmodify" method="post" enctype="multipart/form-data">
    <input type="hidden" id="m_nickname" name="m_nickname" value="${boardDetail.m_nickname}">
    <input type="hidden" id="m_id" name="m_id" value="${boardDetail.m_id}">
    <input type="hidden" id="b_kind" name="b_kind" value="${boardDetail.b_kind}">
    <input type="hidden" id="b_no" name="b_no" value="${boardDetail.b_no}">
    <input type="hidden" id="b_lock" name="b_lock" value="${boardDetail.b_lock}">
    <input type="hidden" id="b_notice" name="b_notice" value="${boardDetail.b_notice}">
<table>
	<tr>
		<th class="row mt-1 mb-1" style="width:170px"><b align="center">카테고리</b></th>
		<td>
		<c:if test="${boardDetail.b_kind == '1'}">
		    <select id="b_kind" name="b_kind" class="btn btn-outline-light text-dark dropdown-toggle" data-bs-toggle="dropdown" required>
		      <option class="dropdown-item" value="1" selected>자유</option>
		      <option class="dropdown-item" value="2">후기</option>
		      <option class="dropdown-item" value="3">QnA</option>
		      <c:if test="${sessionScope.m_kind == 2}">
	      		<option class="dropdown-item" value="4">공지사항</option>
		      </c:if>
		    </select>
		</c:if>
		<c:if test="${boardDetail.b_kind == '2'}">
		    <select id="b_kind" name="b_kind" class="btn btn-outline-light text-dark dropdown-toggle" data-bs-toggle="dropdown" required>
		      <option class="dropdown-item" value="1">자유</option>
		      <option class="dropdown-item" value="2" selected>후기</option>
		      <option class="dropdown-item" value="3">QnA</option>
		      <c:if test="${sessionScope.m_kind == 2}">
	      		<option class="dropdown-item" value="4">공지사항</option>
		      </c:if>
		    </select>
		</c:if>
		<c:if test="${boardDetail.b_kind == '3'}">
		    <select id="b_kind" name="b_kind" class="btn btn-outline-light text-dark dropdown-toggle" data-bs-toggle="dropdown" required>
		      <option class="dropdown-item" value="1">자유</option>
		      <option class="dropdown-item" value="2">후기</option>
		      <option class="dropdown-item" value="3" selected>QnA</option>
		      <c:if test="${sessionScope.m_kind == 2}">
	      		<option class="dropdown-item" value="4">공지사항</option>
		      </c:if>
		    </select>
		</c:if>
		<c:if test="${boardDetail.b_kind == '4'}">
		    <select id="b_kind" name="b_kind" class="btn btn-outline-light text-dark dropdown-toggle" data-bs-toggle="dropdown" required>
		      <option class="dropdown-item" value="1">자유</option>
		      <option class="dropdown-item" value="2">후기</option>
		      <option class="dropdown-item" value="3">QnA</option>
		      <c:if test="${sessionScope.m_kind == 2}">
	      		<option class="dropdown-item" value="4" selected>공지사항</option>
		      </c:if>
		    </select>
		</c:if>
      		<input type="hidden" id="b_notice" name="b_notice" value="1">
      		<c:if test='${boardDetail.b_lock == "y"}'>
			    <label><input type="checkbox" id="checkLock" value="" checked> 비밀글</label>
      		</c:if>
      		<c:if test='${boardDetail.b_lock == "n"}'>
			    <label><input type="checkbox" id="checkLock" value=""> 비밀글</label>
      		</c:if>
	    </td>
	</tr>
    <tr>
    	<th class="row mt-1 mb-1" style="width:170px"><b align="center">제목</b></th>	 
		<td>
		<div class="form-floating-sm mb-2 mt-2">
	      <input type="text" class="form-control" name="b_title" name="b_title" value="${boardDetail.b_title}" required>
	    </div>
	    </td>
    </tr>
    <tr>
    	<th class="row mt-1 mb-1" style="width:170px"><b align="center">내용</b></th> 
		<td><textarea name="b_contents" style="width: 1100px; height: 400px;" required>${boardDetail.b_contents}</textarea></td>
	<tr>
	<tr>
    	<th class="row mt-1 mb-1" style="width:170px"><b align="center">첨부 파일</b></th>
    	<td>
    		<input type="file" id="filename" name="filename">
    		<input type="hidden" name="b_filename" value="${boardDetail.b_filename}">
    		<span id="imgdel"><a href="#" id="preview-de" style="background-color: #FFC478;" class="btn btn-outline-light text-white">삭제</a></span>
			<c:if test="${boardDetail.b_filename != null}">
				<div class="select_img"><img alt="게시판 이미지" src="resources/image/board/${boardDetail.b_filename}"
											 style="width: 500px; height: auto;" id="img" name="img">
				</div>
			</c:if>
			<c:if test="${boardDetail.b_filename == null}">
				<div class="select_img"><img style="width: 500px; height: auto;" id="img" name="img"></div>
			</c:if>
		</td>
	</tr>
</table>
	<input type="submit" value="수정"  style="background-color: #BBDFC8;" class="btn btn-outline-light text-white">
	<a href="/HJBoard?m_id=${sessionScope.m_id}" style="background-color: #75CFB8;" class="btn btn-outline-light text-white">목록</a> 
</form>
</div>
<pre>

</pre>
<%@include file="../footer.jsp" %>
<script>
 $(document).ready(function(){
 	$("#checkLock").change(function(){
//  		alert("비밀글 여부를 변경합니다");
         if($("#checkLock").is(":checked")){
            $("#b_lock").val("y");
         }else{
            $("#b_lock").val("n");
         }
         var b_lock = $("#b_lock").val();
//          alert("b_lock->" + b_lock);
     });
 	
 	$("select[name=b_kind]").change(function(){
 		var b_kind = $(this).val(); //value값 가져오기
//  		alert("b_kind->" + b_kind); 
 		if(b_kind == '1'){
 			$("#b_kind").val("1");
//  			alert("b_kind -> 1로 변경");
 		}else if(b_kind == '2'){
 			$("#b_kind").val("2");
//  			alert("b_kind -> 2로 변경");
 		}else if(b_kind == '3'){
 			$("#b_kind").val("3");
//  			alert("b_kind -> 3로 변경");
 		}else if(b_kind == '4'){
 			$("#b_kind").val("4");
//  			alert("b_kind -> 4로 변경");
 			
// 			alert("b_notice -> 2로 변경");
			$("#b_notice").val("2");			
 		}else{
 			$("#b_notice").val("1");
 		}
 	});
 });
</script>
 <script>
  $("#filename").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    if(document.getElementById("img")){
//     	alert("img있음!");
    }else{
//     	alert("img없음!");
	    var str = '<img style="width: 500px; height: auto;" id="img" name="img">'
// 	    alert("str->" + str);
    	$(".select_img").append(str);
    }
    
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(500);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
  
  $('#imgdel').on('click', '#preview-de', function () {
// 	  alert("사진 삭제합니다");	  
	  $(".select_img").empty()
	  $("#filename").val("");
	  $('[name=b_filename]').val("");
// 	  alert("$('[name=b_filename]').val('') 처리 후");
  });
 </script>
</body>
</html>