<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	width: 100%;
	margin: 0;
}
@font-face {
    font-family: 'InfinitySans-RegularA1';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
*{font-family: 'InfinitySans-RegularA1';}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
</head>
<body>
	<div id="menu1">
		<nav class="navbar navbar-expand-sm bg-light navbar-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="/">Logo</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>
				<span>
					<form action="content_Search" method="get">
						<input type="text" name="search" placeholder="검색어를 입력하세요"
							maxlength="20">
					</form>
				</span>
				<div class="collapse navbar-collapse justify-content-end"
					id="collapsibleNavbar">
					<ul class="navbar-nav">
						<%-- 	<c:choose> --%>
						<%--   	  <c:when test="${empty sessionId}"> --%>

						<li class="nav-item">
							<c:if test="${m_id == 'admin'}">
								<a class="nav-link" href="/uploadContentForm">컨텐츠 등록하기</a>
							</c:if>
						<li class="nav-item"><a class="nav-ling" >${sessionScope.m_id}</a>
						<li class="nav-item"><a class="nav-link" href="memberLogin">로그인</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="memberJoin">회원가입</a></li>
						<li class="nav-item">
						<li class="nav-item"><a class="nav-link" href="memberLogout">로그아웃</a></li>
						<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" role="button"
							data-bs-toggle="dropdown">마이페이지</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="myInfo?m_id=${sessionScope.m_id}">나의 정보</a></li>
								<li><a class="dropdown-item" href="myWishList">나의 찜 목록</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}&active=${sessionScope.m_active_kind}">플래너</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="HJBoard?m_id=${sessionScope.m_id}">게시판</a></li>
					</ul>
				</div>
			</div>
		</nav>
		</div>

<script type="text/javascript">

</script>
</body>
</html>

