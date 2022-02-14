<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
window.onload = function(){
	if(${result}==1){
		alert("수정 성공!");
		window.location.href="/";
		
	}else{
		alert("수정 실패..")
		window.open("about:blank", "_self").close();
	}
};
</script>