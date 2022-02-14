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

//비밀번호 변경
function pwChange(){
	var m_id=$('#m_id').val();
	var m_password=$('#m_password').val();
	$.ajax({
		url:"<%=context%>/member/pwChange",
		data:{m_id : m_id,m_password:m_password}, //집어넣을 값지정
		dataType:'text', //받는 방법 설정 String이면 text 객체면 json으로
		success:function(data){
			alert("비밀번호 변경이 완료되었습니다");
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
		console.log("비밀번호 검사완료"); 
		pwChange();
		return true;
	 }

}

//이메일 형식 유효성검사 자바스크립트에서도하고 서버에서도 검사함

function mailFormCheck(){
	  var m_email = $('#m_email').val();
	  var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	  if(form.test(m_email)==false){
		  alert("이메일 형식이 올바르지 $않습니다. 유요한 이메일 주소로 입력해주세요")
	  	  return false;
	  }else{
		  $('#submit').attr("disabled",false);
		  return true;
	  }
}
</script>
<script>
function check() {
	 var m_id=$('#m_id').val();
	 var m_email = $('#m_email').val();
	 var m_nickname=$('#m_nickname').val();
	 var m_birth = $('#m_birth').val();
	 var m_phone = $('#m_phone1').val()+$('#m_phone2').val()+$('#m_phone3').val();
	 var m_gender = $('#m_gender').val();
	$.ajax({
		url:"<%=context%>/member/InfoChange",
		data:{m_id:m_id,m_email : m_email,m_nickname:m_nickname,m_birth:m_birth,m_phone:m_phone,m_gender:m_gender}, //집어넣을 값지정
		dataType:'text', //받는 방법 설정 String이면 text 객체면 json으로
		success:function(data){
			alert("회원정보수정이 완료되었습니다");
		}
	});
}
</script>
</head>
<body>
	${member.m_id}
	<%@include file="../header1.jsp"%>
	<%@include file="./bootStrap.jsp"%>
	<h1>여기에 회원가입시 필요한 정보 및 input넣기</h1>
	<div class="container">
		<div class="form_container">
			<form method="post">
				<table>
					<tr>
						<td>아이디:</td>
						<td><input type="text" name ="m_id" id="m_id" required="required" value="${member.m_id}" readonly="readonly">
							</td>
					</tr>
					<tr>
						<td>비밀번호:</td>
						<td><input type="password" id = "m_password" required="required" value="${member.m_password }">
							<input type="button" value="비밀번호 변경" onclick="chkPW()">
							<c:if test="${sessionScope.member.m_active_kind}==2">
							<input type="text" value="임시비밀번호를 변경해주세요">
							</c:if>
						</td>
						
					</tr>
					<tr>
						<td>닉네임:</td>
						<td><input type="text" id = "m_nickname" name="m_nickname" value="${member.m_nickname }"></td>
					</tr>
					<tr>
						<td>생일:</td>
						<td><input type="date" id="m_birth" name="m_birth" value="${member.m_birth }"></td>
					</tr>
					<tr>
						<td>이메일:</td>
						<td><input type="text" id="m_email" name="m_email" required="required" value=${member.m_email }>
						<input type="button" id="m_emailCk" value="변경할이메일"  onclick="mailFormCheck()"></td>
					</tr>
					<tr>
						<td>전화번호:</td>
						<td>
						<select id="m_phone1" name="m_phone1" required="required" >
							<option value="${member.m_phone1 }">010</option>
							<option value="010">011</option>
							<option value="010">017</option>
							<option value="010">019</option>
						</select>-
						<input type="text" id="m_phone2" name="m_phone2" required="required" value="${member.m_phone2}">-
						<input type="text" id="m_phone3" name="m_phone3" required="required" value="${member.m_phone3}">
						</td>
						
					</tr>
					<tr>
						<td>성별</td>
						<td><input type="text" id="m_gender" name="m_gender" value="${member.m_gender }" required="required">
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" id="submit" disabled="disabled" value="회원 정보수정" onclick="check()" ></td>
						<td colspan="2"><a href="/member/leave?m_id=${member.m_id}">회원탈퇴</a>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<%@include file="../footer.jsp" %>
</body>
</html>