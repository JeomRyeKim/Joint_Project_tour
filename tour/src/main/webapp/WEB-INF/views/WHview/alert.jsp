<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var message = "${msg1}";
		var url = "${url}";
		window.onload = function(){
			Swal.fire({
	                icon: 'success',
	                title: message,
	                text: '성공하였습니다',
	            }).then((result) => { 
	            	if (result.isConfirmed) { 
	            		Swal.fire( '페이지로 돌아갑니다'
	            				  ) } 
	            		window.location.href = url;
	           });
	};

	</script>
</body>
</html>