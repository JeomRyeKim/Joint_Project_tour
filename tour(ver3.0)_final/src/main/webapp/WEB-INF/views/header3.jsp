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
	padding-top: 60px;
}

@font-face {
	font-family: 'InfinitySans-RegularA1';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'InfinitySans-RegularA1';
}

.content a {
	text-decoration: none;
	font-weight: 800;
	color: black;
}

a {
	text-decoration: none;
	font-weight: 800;
	color: black;
}

#nav-link {
	color: black;
	font-weight: 800;
}
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
	<script src="https://kit.fontawesome.com/8eb5905426.js" crossorigin="anonymous"></script>

</head>
<body>
	<div id="menu1">
		<nav id="header1" class="navbar navbar-expand-sm navbar-light"
			style="width: 80%; margin: auto;">
			<div class="container-fluid">
				<a class="navbar-brand" href="/" id="nav-link">
					<img src="resources/image/logo.png" style="width:100px; height: 50px;padding-top: 5px;">
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>

				<form action="content_Search" method="get" style="padding-top: 3px;">
					<span> <input type="text" name="search"
						placeholder="&#xf002;" maxlength="20"
						style="float:left;  border-radius: 30px; text-align: left; padding-left: 10px; font-family: fontAwesome;">
					</span>
				</form>

				<div class="collapse navbar-collapse justify-content-end"
					id="collapsibleNavbar">
					<ul class="navbar-nav">
						<li class="nav-item"><c:if test="${m_id == 'admin'}">
								<a class="nav-link" href="/uploadContentForm" id="nav-link">컨텐츠
									등록하기</a>
							</c:if> <c:choose>
								<c:when test="${sessionScope.m_id==null}">
									<li class="nav-item"><a class="nav-link"
										href="memberLogin" id="nav-link">로그인</a></li>
									<li class="nav-item"><a class="nav-link" href="memberJoin"
										id="nav-link">회원가입</a></li>
								</c:when>
								<c:otherwise>
									<li class="nav-item"><span class="nav-link" id="nav-link">${sessionScope.m_id}님 환영합니다.</span></li>
									<li class="nav-item"><a class="nav-link"
										href="memberLogout" id="nav-link">로그아웃</a></li>
								</c:otherwise>
							</c:choose>
						<c:if test="${sessionScope.m_id!=null}">
							<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" id="nav-link">마이페이지</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="myInfo?m_id=${sessionScope.m_id}" id="nav-link">나의 정보</a></li>
								<li><a class="dropdown-item" href="myWishList" id="nav-link">나의 찜 목록</a></li>
							</ul>
							</li>
							<li class="nav-item"><a class="nav-link" id="nav-link" href="${pageContext.request.contextPath}/planL?id=${sessionScope.m_id}">플래너</a>
							</li>
						</c:if>
						<li class="nav-item"><a class="nav-link" id="nav-link" href="HJBoard?m_id=${sessionScope.m_id}">게시판</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>

