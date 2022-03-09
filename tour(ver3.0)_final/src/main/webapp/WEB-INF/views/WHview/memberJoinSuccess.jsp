<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>+82Trip</title>
</head>
<body>
	<h1>회원가입이 완료되었습니다 로그인해주세요</h1>
	<script type="text/javascript">
	window.onload = function(){
		Swal.fire({
                icon: 'success',
                title: '회원가입 성공.',
                text: '로그인 하겠습니까?.'
            }).then(function(result) { 
            	if (result.isConfirmed) { 
            		Swal.fire( '로그인 페이지로 돌아갑니다.'
            				  ) .then(function(){
			                		window.location.href = '/';
            				  });
            	}
           });
};
</script>
</body>
</html>