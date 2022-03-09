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
	<script type="text/javascript">
		var message1 = "${msg1}";
		var message2 = "${msg2}";
		var message3 = "${msg3}";
		var message4 = "${msg4}";
		var url = "${url}";
		window.onload = function(){
			if(message4=="success"){
			Swal.fire({
	                icon: 'success',
	                title: message1,
	                text:  message2
	            }).then(function(result) { 
	            	if (result.isConfirmed) { 
	            		Swal.fire( message3
	            				  ) .then(function(){
				                		window.location.href = url;
	            				  });
	            	}
	           });
			}else if(message4=="false"){
				Swal.fire({
	                icon: 'warning',
	                title: message1,
	                text:  message2
	            }).then(function(result) { 
	            	if (result.isConfirmed) { 
	            		Swal.fire( message3
	            				  ) .then(function(){
				                		window.location.href = url;
	            				  });
	            	}
	           });
				
				
			}
	};

	</script>
</body>
</html>