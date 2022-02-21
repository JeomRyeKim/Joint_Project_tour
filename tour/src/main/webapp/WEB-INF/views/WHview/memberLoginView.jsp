<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>
<script type="text/javascript">
	window.onload = function(){
			Swal.fire({
                    icon: 'success',
                    title: '로그인 성공.',
                    text: '로그인 하였습니다.'
                }).then((result) => { 
                	if (result.isConfirmed) { 
                		Swal.fire( '홈페이지로 돌아갑니다.'
                				  ) } 
                		window.location.href = '/';
               });
	};
	
</script>
</head>
<body>
</body>
</html>