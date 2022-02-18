<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>+82Trip</title>
<%@include file="boot.jsp" %>
</head>
<body>
<%@include file="../header1.jsp" %>
<%@include file="../header2.jsp" %>
<div class="container mt-3 mb-3 table-bordered">
   <h2 id="board" class="mt-5 mb-3" style="color: #75CFB8"><b>게시판</b></h2>
	<label><a class="btn btn-outline-secondary" value="a"  id="all"    onclick="location.href = '/HJBoard?&m_id=${member.m_id}'">전체</a></label>
	<label><a class="btn btn-outline-secondary" value="1"  id="free"   onclick="location.href = '/HJBoard?b_kind=1&m_id=${member.m_id}'">자유</a></label>
	<label><a class="btn btn-outline-secondary" value="2"  id="review" onclick="location.href = '/HJBoard?b_kind=2&m_id=${member.m_id}'">후기</a></label>
	<label><a class="btn btn-outline-secondary" value="3"  id="qna"    onclick="location.href = '/HJBoard?b_kind=3&m_id=${member.m_id}'">QnA</a></label>
	
	<a class="mt-4 text-secondary" style="float:right; text-decoration:none;" readonly>총 <b style="color: #FFC478">${total}</b>건의 글이 등록되었습니다.</a>
	<c:set var="num" value="${pg.total-pg.start+1}"></c:set>
		
<!-- 현재 로그인 중 id -->
<input type="hidden" id="session_id" value="${sessionScope.m_id}">
<input type="hidden" id="nickname" value="${member.m_nickname}">
<input type="hidden" id="kind" value="${member.m_kind}">
<input type="hidden" id="active_kind" value="${member.m_active_kind}">
<table class="table table-hover mt-3">
    <thead style="background: linear-gradient(to right, #75CFB8, #BBDFC8, #F0E5D8, #FFC478);">
      <tr style="text-align: center;">
        <th class="col-sm-1">번호</th>
        <th class="col-sm-7">제목</th>
        <th class="col-sm-1">작성자</th>
        <th class="col-sm-1">작성일</th>
        <th class="col-sm-1">좋아요</th>
        <th class="col-sm-1">조회수</th>
      </tr>
    </thead>
	<tbody>
    <c:forEach var="board" items="${listBoard}">
    	<!-- 글을 작성한 글쓴이 id -->
    	<input type="hidden" id="b_id" value="${board.m_id}">
    	<input type="hidden" id="b_lokc" value="${board.b_lock}">
    	<input type="hidden" id="b_notice" value="${board.b_notice}">
	      <tr id="bb" class="text-secondary">
	        <td class="col-sm-1" style="text-align: center;">${board.b_no}</td>
	        <td class="col-sm-7" style="text-align: left;">
	          <c:if test="${board.b_kind eq 1}">
	        	[자유]
	          </c:if>
	      	  <c:if test="${board.b_kind eq 2}">
	        	[후기]
	          </c:if>
	      	  <c:if test="${board.b_kind eq 3}">
	        	[QnA]
	          </c:if>
	      	  <c:if test="${board.b_kind eq 4}">
	        	<b><span style="background-color: #FFC478" class="badge bg-orange-200">공지</span></b>
	          </c:if>
		        <!-- when 비밀글O, 로그인X -->
				<!-- when 비밀글O, 본인글X, 관리자X -->
				<!-- when 비밀글O, 본인글O, 관리자X -->
				<!-- when 비밀글O, 본인글X, 관리자O -->
				<c:forEach begin="1" end="${board.b_Indent}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
					</svg>
				</c:forEach>
				<c:if test="${board.b_lock == 'y'}">
					<img src="image/lock.png" width="15" height="auto">
				</c:if>
		        <c:choose>
		        	<c:when test='${board.b_lock == "y" && member.m_id == null}'>
		        		<a class="text-secondary" style="text-decoration: none;"> 비밀글입니다. 작성자와 관리자만 확인 가능합니다. <span class="badge rounded-pill bg-light text-dark">${board.b_commentCnt}</span></a>
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && member.m_id != null && board.m_id != member.m_id && member.m_kind != "2"}'>
		        		<a class="text-secondary" style="text-decoration: none;"> 비밀글입니다. 작성자와 관리자만 확인 가능합니다. <span class="badge rounded-pill bg-light text-dark">${board.b_commentCnt}</span></a>
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && board.m_id == member.m_id && member.m_kind != "2"}'>
		        		<a class="text-secondary" style="text-decoration: none;" href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">
		        		${board.b_title} 
		        		<span class="badge rounded-pill bg-light text-dark">${board.b_commentCnt}</span></a>
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && board.m_id != member.m_id && member.m_kind == "2"}'>
			        	<a class="text-secondary" style="text-decoration: none;" href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">
			        	${board.b_title} 
			        	<span class="badge rounded-pill bg-light text-dark">${board.b_commentCnt}</span></a>
		        	</c:when>
		        	<c:otherwise>
			        	<a class="text-secondary" style="text-decoration: none;" href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">
			        	${board.b_title} 
			        	<span class="badge rounded-pill bg-light text-dark">${board.b_commentCnt}</span></a>
		        	</c:otherwise>
		        </c:choose>
	        </td>
	        <td class="col-sm-1" style="text-align: center;">${board.m_nickname}</td>
	        <td class="col-sm-1" style="text-align: center;"><fmt:formatDate pattern = "yyyy-MM-dd" value="${board.b_date}"/></td>
	        <td class="col-sm-1" style="text-align: center;">
	        	<c:if test="${board.b_like_cnt > 0}">
	        		<img src='image/like/heart_like.png' id="like_img" class="likeImage" width="25" height="auto"> ${board.b_like_cnt}
	        	</c:if>
	        	<c:if test="${board.b_like_cnt == 0}">
	        		<img src='image/like/heart_dislike.png' id="like_img" class="likeImage" width="25" height="auto"> ${board.b_like_cnt}
	        	</c:if>
	        </td>
	        <td class="col-sm-1" style="text-align: center;">${board.b_hit}</td>
	      </tr>
    </c:forEach>
    </tbody>
	<c:set var="num" value="${num - 1}"></c:set>
</table>
<!-- 페이징 처리 -->
<div class="container mt-3 text-dark" align="center">
<c:set var="kind" value="${param.b_kind}"/>
<c:set var="search" value="${param.searchType}"/>
<c:set var="word" value="${param.keyword}"/>
<ul class="pagination justify-content-center">
  <!-- 전체, 검색X -->
  <c:if test = "${kind == null and search == null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}"/>">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-left" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M9.224 1.553a.5.5 0 0 1 .223.67L6.56 8l2.888 5.776a.5.5 0 1 1-.894.448l-3-6a.5.5 0 0 1 0-.448l3-6a.5.5 0 0 1 .67-.223z"/>
			</svg>
		</a></li>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${i}&m_id=${member.m_id}"/>">${i}</a></li>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}"/>">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-right" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M6.776 1.553a.5.5 0 0 1 .671.223l3 6a.5.5 0 0 1 0 .448l-3 6a.5.5 0 1 1-.894-.448L9.44 8 6.553 2.224a.5.5 0 0 1 .223-.671z"/>
			</svg>
		</a></li>
	</c:if>
   </c:if>
  <!-- 전체, 검색O -->
  <c:if test="${kind == null and search != null}">
    <c:if test="${pg.startPage > pg.pageBlock}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-left" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M9.224 1.553a.5.5 0 0 1 .223.67L6.56 8l2.888 5.776a.5.5 0 1 1-.894.448l-3-6a.5.5 0 0 1 0-.448l3-6a.5.5 0 0 1 .67-.223z"/>
			</svg>
		</a></li>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${i}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">${i}</a></li>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<li class="page-item"><a class="page-link text-dark" href="<c:url value="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-right" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M6.776 1.553a.5.5 0 0 1 .671.223l3 6a.5.5 0 0 1 0 .448l-3 6a.5.5 0 1 1-.894-.448L9.44 8 6.553 2.224a.5.5 0 0 1 .223-.671z"/>
			</svg>
		</a></li>
	</c:if>
  </c:if>
  
  <!-- 유형별, 검색X -->
  <c:if test = "${kind != null and search == null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-left" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M9.224 1.553a.5.5 0 0 1 .223.67L6.56 8l2.888 5.776a.5.5 0 1 1-.894.448l-3-6a.5.5 0 0 1 0-.448l3-6a.5.5 0 0 1 .67-.223z"/>
			</svg>
		</a></li>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${i}&m_id=${member.m_id}&b_kind=${board.b_kind}">${i}</a></li>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-right" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M6.776 1.553a.5.5 0 0 1 .671.223l3 6a.5.5 0 0 1 0 .448l-3 6a.5.5 0 1 1-.894-.448L9.44 8 6.553 2.224a.5.5 0 0 1 .223-.671z"/>
			</svg>
		</a></li>
	</c:if>
  </c:if>
  <!-- 유형별, 검색O -->
  <c:if test = "${kind != null and search != null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-left" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M9.224 1.553a.5.5 0 0 1 .223.67L6.56 8l2.888 5.776a.5.5 0 1 1-.894.448l-3-6a.5.5 0 0 1 0-.448l3-6a.5.5 0 0 1 .67-.223z"/>
			</svg>		
		</a></li>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${i}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">${i}</a></li>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<li class="page-item"><a class="page-link text-dark" href="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-right" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M6.776 1.553a.5.5 0 0 1 .671.223l3 6a.5.5 0 0 1 0 .448l-3 6a.5.5 0 1 1-.894-.448L9.44 8 6.553 2.224a.5.5 0 0 1 .223-.671z"/>
			</svg>
		</a></li>
	</c:if>
  </c:if>
</ul>
</div> <!-- 페이징 처리 끝 -->

<table style="border-color: lightgray;">
<tr>
<th>
  <select name="searchType" id="searchType" type="button" class="btn btn-outline-white dropdown-toggle text-secondary" data-bs-toggle="dropdown">
    <option value="b_title" <c:if test="${searchType=='b_title'}">selected</c:if>>제목에서</option>
    <option value="b_contents" <c:if test="${searchType=='b_contents'}">selected</c:if>>본문에서</option>
    <option value="m_nickname" <c:if test="${searchType=='m_nickname'}">selected</c:if>>글쓴이에서</option>
  </select>
</th>
<td>
	  <input style="color: #75CFB8;" id="keyword" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요" class="btn btn-outline-white" required="required">
	  <button class="btn btn-outline-white text-secondary" type="button" id="btnSearch" onclick="SearchText(${keyword})">
	  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
		  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		</svg> 검색
	  </button>
</td>
  <button type="button" id="goWrite" onclick="writeCheck()" style="float:right; background-color: #FFC478;"  class="btn btn-outline-light text-white">
  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16">
	  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
	  <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
	</svg> 글쓰기	
  </button>
</tr>
</table>
</div>
<pre>

</pre>
<%@include file="../footer.jsp" %>
<script type="text/javascript">
function SearchText(keyword){
	var searchType = $("#searchType option:selected").val();
	//alert("searchType->" + searchType);
	var keyword = $('#keyword').val();
	//alert("keyword->" + keyword);
	//var b_kind = $('#b_kind').val();
	var url = window.location.search.split("=");
	var b_kind = url[1];
	//alert("b_kind->" + b_kind);

	if(!window.location.search.includes('b_kind')){ // 전체 검색시
		//alert("!window.location.search.includes('b_kind')->전체 검색시");
		location.href = "/HJBoard?searchType=" + searchType + "&keyword=" + keyword;
	}else if(window.location.search.includes('b_kind')) { // 유형별 검색시
		//alert("window.location.search.includes('b_kind')->유형별 검색시");
		location.href = "/HJBoard?b_kind=" + b_kind + "&searchType=" + searchType + "&keyword=" + keyword;
		//$('#b_kind').val("");
	}
	
}

function writeCheck(){
	var session_id = document.getElementById('session_id').value;
	var m_nickname = document.getElementById('nickname').value;
	var m_active_kind = document.getElementById('active_kind').value;
// 	alert("session_id->" + session_id);
// 	alert("m_nickname->" + m_nickname);
// 	alert("m_active_kind->" + m_active_kind);
	
	if(document.getElementById('session_id').value != "" && document.getElementById('active_kind').value == 1) {
		location.href="./HJWriteForm?m_id=" + session_id + "&m_nickname=" + m_nickname;
	} else if(document.getElementById('session_id').value == "" || document.getElementById('active_kind').value != 1) {
		Swal.fire({ 
			icon: 'warning', // Alert 타입 
			title: '게시글 작성', // Alert 제목 
			text: '활동중인 회원만 가능합니다', // Alert 내용 
		});
	}
}
</script>
<script type="text/javascript">
document.querySelector('#keyword').addEventListener('keypress', function (e) {
	if (e.key === 'Enter') {
		if(document.getElementById('keyword').value == "" || document.getElementById('keyword').value == null){
			Swal.fire({ 
				icon: 'warning', // Alert 타입 
				title: '게시글 검색', // Alert 제목 
				text: '검색어를 입력해주세요', // Alert 내용 
			});
		}else{
			SearchText($("#keyword").val());
		}
	}
});
</script>
</body>
</html>