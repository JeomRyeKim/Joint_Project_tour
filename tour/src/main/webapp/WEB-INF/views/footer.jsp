<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand navbar-light bg-light">
 <div class="container">
  <div class="container-fluid">
    <div class="nav navbar-nav">
      <ul class="navbar-nav me-auto" id="mynavbar">
        <li class="nav-item">
          <a class="nav-link" href="Footer_company?m_id=${sessionScope.m_id}">회사 소개</a>
        </li>
		<pre>       </pre>
        <li class="nav-item">
          <a class="nav-link" href="Footer_agreement?m_id=${sessionScope.m_id}">이용 약관</a>
        </li>
		<pre>       </pre>
        <li class="nav-item">
          <a class="nav-link" href="Footer_privacy?m_id=${sessionScope.m_id}">개인정보처리방침</a>
        </li>
      </ul>
    </div>
  </div>
 </div>
</nav>
<div class="container mt-3" id="footer">
 <div class="row">
  <div class="col-sm-7">
   <p><b>+82 Trip</b> 서울 강남구 테헤란로 7길 7(역삼동 에스코빌딩 6층)</p>
   <p>대표자 : 정현경 | 사업자등록번호 : 220-90-07535 | 통신판매번호 : 제 강남-8062호</p>
   <p>TEL : 02-561-1911 | FAX : 02-538-2613 | 메일 : einfo1@choongang.co.kr</p>
   <p>개인정보관리책임자:유창현, Copyright &copy; 1969 by CHOONGANG INSTITUTE, All Rights Reserved. </p>
  </div>
 </div>
</div>
</body>
</html>