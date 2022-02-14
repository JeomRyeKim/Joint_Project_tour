<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	window.onload =function(){
		if(${result}==1){
			alert("삭제 성공");
			window.location.href = '/';
		}else{
			alert('삭제 실패');
			window.history.back();
		}
	}
</script>