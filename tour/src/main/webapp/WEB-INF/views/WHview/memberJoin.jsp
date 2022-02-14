<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.container{
		display:flex;
		padding-bottom: 20px;
	}
	.form_container{
		margin:auto;
		border:none;
	}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<script type="text/javascript">

//이메일 형식 유효성검사 자바스크립트에서도하고 서버에서도 검사함

function mailFormCheck(){
	  var m_email = $('#m_email').val();
	  var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	  if(form.test(m_email)==false){
		  alert("이메일 형식이 올바르지 $않습니다. 유요한 이메일 주소로 입력해주세요")
	  	  return false;
	  }else{
		  emailCheck();
		  return true;
	  }
}
//이메일 인증번호 발송메소드
function emailCheck(){
	var m_email = $('#m_email').val();
	$('#m_email').attr("readonly",true);
	$.ajax({
		url:"<%=context%>/member/mailCheck",
		data:{m_email : m_email}, //집어넣을 값지정
		dataType:'text', //받는 방법 설정 String이면 text 객체면 json으로
		success:function(data){
			const data1=$.trim(data);
			if(data1 == 'error'){
				alert("이메일 주소가 올바르지 않습니다. 유요한 이메일 주소로 입력해주세요")
				$('#m_email').attr("autofocus",true);
				$('#m_emailCk').css("color","red");
				return false;
			}else{
				alert("인증번호 발송이 완료되었습니다. 입력한 이메일에서 인증번호를 확인해주세요")
				$('#m_email3').val(data1);
				$('m_emailCk').css("color","green");
			}
		}
	});
	
}
//이메일로 보낸 인증번호랑 입력한 인증번호가 같은지 확인하는메소드
function emailCheck2(){
	var m_email2 = $('#m_email2').val();
	var m_email3 = $('#m_email3').val();
	if(m_email2==m_email3&&m_email2!=""&&m_email3!=""){
		alert("인증번호 확인이 완료되었습니다");
		$('m_emailCk2').css("color","green");
		$('#submit').attr("disabled",false);
		$('#m_email2').attr("disabled",true);
		return true;
	}else{
		alert("인증번호 확인이 틀렸습니다");
		$('m_emailCk2').css("color","red");
		return false;
	}
}

//아이디 중복검사
function idCheck(){
	var m_id = $('#m_id').val();
	$.ajax({
		url:"<%=context%>/member/idCheck",
		data:{m_id : m_id}, //집어넣을 값지정
		dataType:'text', //받는 방법 설정 String이면 text 객체면 json으로
		success:function(data){
			const data1=$.trim(data);
			if(data1 == "1"){
				alert("이미 아이디가있습니다 다른아이디를 사용해주세요")
				$('#m_id').attr("autofocus",true);
				$('#m_idCheck').css("color","red");
				return false;
			}else{
				alert("사용하실수있는 아이디입니다")
				$('#m_idCheck').css("color","green");
				$('#m_emailCk').attr("disabled",false);
				$('#m_emailCk2').attr("disabled",false);
				return true;
			}
		}
	});
	
}
function chkPW(){

	 var pw = $("#m_password").val();
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	 if(pw.length < 8 || pw.length > 20){
      $('#m_password').attr("autofocus",true);
	  alert("8자리 ~ 20자리 이내로 입력해주세요.");
	  return false;
	 }else if(pw.search(/\s/) != -1){
      $('#m_password').attr("autofocus",true);
	  alert("비밀번호는 공백 없이 입력해주세요.");
	  return false;
	 }else if(num < 0 || eng < 0 || spe < 0 ){
	  $('#m_password').attr("autofocus",true);
	  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
	  return false;
	 }else {
		console.log("비밀번호 검사완료"); va
	    return true;
	 }

}

function check() {
	 if(chkPW() == false) {
		 alert("비밀번호 형식에맞게 입력해주세요");
		 $('#m_password').attr("autofocus",true);
	 return false;
	}
	 else return true;
}
 
 



</script>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="./bootStrap.jsp"%>
	<h1>여기에 회원가입시 필요한 정보 및 input넣기</h1>
	<div class="container">
		<div class="form_container">
			<form method="post" action="/member/join" onsubmit="return check()">
				<table>
					<tr>
						<td>아이디:</td>
						<td><input type="text" id="m_id" name="m_id" required="required" >
							<input type="button" id="m_idCheck" value="아이디중복검사"  onclick="idCheck()">
							</td>
					</tr>
					<tr>
						<td>비밀번호:</td>
						<td><input type="text" id = "m_password" name="m_password" required="required" placeholder="특수문자,영어,숫자로 8글자이상으로 표기해주세요">
	
						</td>
					</tr>
					<tr>
						<td>닉네임:</td>
						<td><input type="text" name="m_nickname" required="required"></td>
					</tr>
					<tr>
						<td>생일:</td>
						<td><input type="date" name="m_birth" required="required"></td>
					</tr>
					<tr>
						<td>이메일:</td>
						<td><input type="text" id="m_email" name="m_email" required="required" placeholder="ex)abcd1234@gmail.com">
						<input type="button" id="m_emailCk" value="이메일인증"  onclick="mailFormCheck()" disabled="disabled"></td>
					</tr>
					<tr>
						<td>인증번호확인:</td>
						<td><input type="text" id="m_email2" required="required">
						<input type="button" id="m_emailCk2" value="이메일인증확인"  onclick="emailCheck2()" disabled="disabled">
						<input type="hidden" id="m_email3" class="emailDoubleCk" >
						</td>
						
					</tr>
					<tr>
						<td>전화번호:</td>
						<td>
						<select id="m_phone1" name="m_phone1" required="required">
							<option value="010">010</option>
							<option value="010">011</option>
							<option value="010">017</option>
							<option value="010">019</option>
						</select>-
						<input type="text" name="m_phone2" required="required">-
						<input type="text" name="m_phone3" required="required">
						</td>
					</tr>
					<tr>
						<td>성별</td>
						<td><input type="radio" name="m_gender" value="mail" required="required">남성
							<input type="radio" name="m_gender" value="email" required="required">여성
						</td>
					</tr>
					<tr>
						<td colspan="2"><input id="submit" type="submit" value="회원 가입" disabled="disabled"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<%@include file="../footer.jsp" %>
</body>
</html>