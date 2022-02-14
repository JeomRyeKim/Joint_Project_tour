<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="boot.jsp" %> 
<!DOCTYPE html>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
		alert("활동중인 회원만 게시글 작성이 가능합니다");
	}
}
</script>
</head>
<body>
<%@include file="../header1.jsp" %>
<%@include file="../header2.jsp" %>
<div class="container mt-5">
  <h2 id="board"><b>게시판</b></h2>
<pre>

</pre>
	<label><a class="btn btn-outline-secondary" value="a"  id="all"    onclick="location.href = '/HJBoard?&m_id=${member.m_id}'">전체</a></label>
	<label><a class="btn btn-outline-secondary" value="1"  id="free"   onclick="location.href = '/HJBoard?b_kind=1&m_id=${member.m_id}'">자유</a></label>
	<label><a class="btn btn-outline-secondary" value="2"  id="review" onclick="location.href = '/HJBoard?b_kind=2&m_id=${member.m_id}'">후기</a></label>
	<label><a class="btn btn-outline-secondary" value="3"  id="qna"    onclick="location.href = '/HJBoard?b_kind=3&m_id=${member.m_id}'">QnA</a></label>
	
	<a class="btn btn-outline-secondary btn-sm" style="float:right;" readonly>전체글 : ${total}</a>
	<c:set var="num" value="${pg.total-pg.start+1}"></c:set>
		
	<br>m_id : ${member.m_id}
	<br>sessionScope.m_id : ${sessionScope.m_id}
	<br>m_nickname : ${member.m_nickname}
	<br>m_kind : ${member.m_kind}
	<br>m_active_kind : ${member.m_active_kind}
	<br>pageContext.request.requestURL : ${pageContext.request.requestURL}
	<br>param.b_kind : ${param.b_kind}
	<br>param.searchType : ${param.searchType}
	<br>param.keyword : ${param.keyword}
<!-- 현재 로그인 중 id -->
<input type="hidden" id="session_id" value="${sessionScope.m_id}">
<input type="hidden" id="nickname" value="${member.m_nickname}">
<input type="hidden" id="kind" value="${member.m_kind}">
<input type="hidden" id="active_kind" value="${member.m_active_kind}">
<table class="table table-hover">
    <thead>
      <tr>
        <th>카테고리</th>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>좋아요</th>
        <th>조회수</th>
      </tr>
    </thead>
	<tbody>
    <c:forEach var="board" items="${listBoard}">
    	<!-- 글을 작성한 글쓴이 id -->
    	<input type="hidden" id="b_id" value="${board.m_id}">
    	<input type="hidden" id="b_lokc" value="${board.b_lock}">
    	<input type="hidden" id="b_notice" value="${board.b_notice}">
<%--     	<input type="hidden" id="b_kind" value="${board.b_kind}"> --%>
<%--     	<input type="hidden" id="m_id" value="${board.m_id}"> --%>
	      <tr id="bb">
	      	  <c:if test="${board.b_kind eq 1}">
	        	<td>[자유]</td>
	          </c:if>
	      	  <c:if test="${board.b_kind eq 2}">
	        	<td>[후기]</td>
	          </c:if>
	      	  <c:if test="${board.b_kind eq 3}">
	        	<td>[QnA]</td>
	          </c:if>
	      	  <c:if test="${board.b_kind eq 4}">
	        	<td><b style="color: red;">[공지사항]</b></td>
	          </c:if>
	        <td>${board.b_no}</td>
	        <td>
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
					🔒			   
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
					  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
				    </svg> 
				</c:if>
		        <c:choose>
		        	<c:when test='${board.b_lock == "y" && member.m_id == null}'>
		        		비밀글입니다. 작성자와 관리자만 확인 가능합니다. (${board.b_commentCnt})
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && board.m_id != member.m_id && member.m_kind != "2"}'>
		        		비밀글입니다. 작성자와 관리자만 확인 가능합니다. (${board.b_commentCnt})
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && board.m_id == member.m_id && member.m_kind != "2"}'>
		        		<a href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">${board.b_title} (${board.b_commentCnt})
		        	</c:when>
		        	<c:when test='${board.b_lock == "y" && board.m_id != member.m_id && member.m_kind == "2"}'>
			        	<a href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">${board.b_title} (${board.b_commentCnt})
		        	</c:when>
		        	<c:otherwise>
			        	<a href="HJBoardDetail?b_kind=${board.b_kind}&b_no=${board.b_no}&m_id=${member.m_id}&m_nickname=${member.m_nickname}&m_kind=${member.m_kind}">${board.b_title} (${board.b_commentCnt})
		        	</c:otherwise>
		        </c:choose>
	        </td>
	        <td>${board.m_nickname}</td>
	        <td>${board.b_date}</td>
	        <td>
	        	❤ ${board.b_like_cnt}
	        </td>
	        <td>${board.b_hit}</td>
	      </tr>
    </c:forEach>
    </tbody>
	<c:set var="num" value="${num - 1}"></c:set>
</table>
<!-- 페이징 처리 -->
<div align="center">
<c:set var="kind" value="${param.b_kind}"/>
<c:set var="search" value="${param.searchType}"/>
<c:set var="word" value="${param.keyword}"/>
  <!-- 전체, 검색X -->
  <c:if test = "${kind == null and search == null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<a href="<c:url value="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}"/>">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<a href="<c:url value="HJBoard?currentPage=${i}&m_id=${member.m_id}"/>">[${i}]</a>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<a href="<c:url value="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}"/>">[다음]</a>
	</c:if>
   </c:if>
  <!-- 전체, 검색O -->
  <c:if test="${kind == null and search != null}">
    <c:if test="${pg.startPage > pg.pageBlock}">
		<a href="<c:url value="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<a href="<c:url value="HJBoard?currentPage=${i}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">[${i}]</a>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<a href="<c:url value="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&searchType=${board.searchType}&keyword=${board.keyword}"/>">[다음]</a>
	</c:if>
  </c:if>
  
  <!-- 유형별, 검색X -->
  <c:if test = "${kind != null and search == null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<a href="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<a href="HJBoard?currentPage=${i}&m_id=${member.m_id}&b_kind=${board.b_kind}">[${i}]</a>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<a href="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}">[다음]</a>
	</c:if>
  </c:if>
  <!-- 유형별, 검색O -->
  <c:if test = "${kind != null and search != null}">
	<c:if test="${pg.startPage > pg.pageBlock}">
		<a href="HJBoard?currentPage=${pg.startPage-pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
		<a href="HJBoard?currentPage=${i}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">[${i}]</a>
	</c:forEach>
	<c:if test="${pg.endPage < pg.totalPage}">
		<a href="HJBoard?currentPage=${pg.startPage+pg.pageBlock}&m_id=${member.m_id}&b_kind=${board.b_kind}&searchType=${board.searchType}&keyword=${board.keyword}">[다음]</a>
	</c:if>
  </c:if>
</div> <!-- 페이징 처리 끝 -->

  <table>
    <tr>
      <td width="100%" align="left">
        <select name="searchType" id="searchType" class="txt" style="float: left;">
          <option value="b_title" <c:if test="${searchType=='b_title'}">selected</c:if>>제목에서</option>
          <option value="b_contents" <c:if test="${searchType=='b_contents'}">selected</c:if>>본문에서</option>
          <option value="m_nickname" <c:if test="${searchType=='m_nickname'}">selected</c:if>>글쓴이에서</option>
        </select>
          <input type="search" id="keyword" name="keyword" value="${keyword}">
          <input type="button" id="btnSearch" class="btn btn-outline-secondary btn-sm" value="검색" onclick="SearchText(${keyword})">
      </td>
         <input type="button" id="goWrite" onclick="writeCheck()" value="글쓰기&raquo;" class="btn btn-outline-primary" style="float: right;" >
    </tr>
  </table>
</div>

<pre>


</pre>
<%@include file="../footer.jsp" %>
</body>
</html>