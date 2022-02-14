<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<script>
		window.onload = function(){
		if(${result}==1){
			alert("등록 성공!");
			window.location.href="/";
			
		}else{
			alert("등록 실패..")
			window.open("about:blank", "_self").close();
		}
	};
</script>
