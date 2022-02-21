<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>나의정보</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#fff), to(#fff));
      background: -webkit-linear-gradient(bottom left, #fff 0%, #fff 70%);
      background: -moz-linear-gradient(bottom left, #fff 0%, #fff 70%);
      background: -o-linear-gradient(bottom left, #fff 0%, #fff 70%);
      background: linear-gradient(to top right, #fff 0%, #fff 70%);
    }
	

    .input-form {
      max-width: 680px;

      margin-top: -50px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  .container {
    flex-shrink: 0;
    width: 100%;
    max-width: 100%;
    padding-right: calc(var(--bs-gutter-x) * .5);
    padding-left: calc(var(--bs-gutter-x) * .5);
    margin-top: 50px;
}  
  .input-form col-md-12 {
  margin-right: 20%;
  margin-left: 20%;
  }
 
 
  </style>
  
</head>

<body>
 <%@include file="../header1.jsp"%>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-6" style="margin-left: 25%; background: linear-gradient(to right, #fffaf7, #fff5f3);">
        <h4 class="mb-3">나의정보</h4>
        <form class="validation-form"  method="post">
          <div class="row">
            <div class="mb-3">
              <label for="name">아이디</label>
              <input type="text" class="form-control" id="m_id" name="m_id" placeholder="Id를 입력해주세요" readonly="readonly" value="${member.m_id }" required>
              <input type="hidden" id="m_idCheck2">
            </div>
            <div class="mb-3">
              <label for="password">비밀번호</label><button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px;  background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="chkPW()">비밀번호변경</button>
              <input type="password" class="form-control" id="m_password" name="m_password" value="${member.m_password }" required>
              <input type="hidden" id="m_pass">
            </div>
          </div>
           <div class="mb-3">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control" id="m_nickname" name="m_nickname" value="${member.m_nickname }"  required>
           </div>
           <div class="mb-3">
            <label for="birth">생일</label>
            <input type="date" name = "m_birth" id="m_birth" class="form-control" value="${member.m_birth }" required>
           </div>
		  <div class="mb-3">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="m_email" name="m_email" value="${member.m_email }" required>
           <input type="hidden" id="m_emailval1">
           </div>
          <div class="mb-3">
            <label for="address">전화번호</label>
            <select id="m_phone1" name="m_phone1" required="required">
					<option value="${member.m_phone1 }">010</option>
					<option value="010">011</option>
					<option value="010">017</option>
					<option value="010">019</option>
			</select>-
			<input type="text" id="m_phone2" name="m_phone2" value="${member.m_phone2 }" required="required">-
			<input type="text" id="m_phone3" name="m_phone3" value="${member.m_phone3 }" required="required">
          </div>

          <div class="mb-3">
            <label for="address2">성별<span class="text-muted"></span></label>
            <input type="radio"  checked="checked" id="m_gender" name="m_gender" value="남성" required="required">남성
            <input type="radio"  name="m_gender" id="m_gender" value="여성" required="required">여성
          </div>
          <hr class="mb-4">
 
          <div class="mb-4"></div>
          <button class="btn text-white btn-lg btn-block" style=" background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="check()">회원정보수정</button>
        </form>
        <button class="btn btn-danger btn-lg btn-block" onclick="location.href='/member/leave?m_id=${member.m_id}'">회원탈퇴하기</button>
      </div>
     </div>
  </div>
  <div style="margin-top: 1000px;">
  <%@include file="../footer.jsp" %>
  </div>
  <script type="text/javascript">

//이메일 형식 유효성검사 자바스크립트에서도하고 서버에서도 검사함

function mailFormCheck(){
	  var m_email = $('#m_email').val();
	  var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	  if(form.test(m_email)==false){
		  Swal.fire({
              icon: 'warning',
              title: '이메일 형식이 올바르지않습니다.',
              text: '유효한 이메일을 입력해주세요.',
          });
	  	  return false;
	  }else{
		  emailCheck();
		  return true;
	  }
}
//이메일 인증번호 발송메소드
function pwChange(){
	var m_id=$('#m_id').val();
	var m_password=$('#m_password').val();
	$.ajax({
		url:"<%=context%>/member/pwChange",
		data:{m_id : m_id,m_password:m_password}, //집어넣을 값지정
		dataType:'text', //받는 방법 설정 String이면 text 객체면 json으로
		success:function(data){
			
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
      Swal.fire({
          icon: 'warning',
          title: '패스워드를 확인해주세요.',
          text: '패스워드는 특수문자,영어,숫자로 공백없이 8~20글자로 작성해주세요.'
      });
	  return false;
	 }else if(pw.search(/\s/) != -1){
      $('#m_password').attr("autofocus",true);
      Swal.fire({
          icon: 'warning',
          title: '패스워드를 확인해주세요.',
          text: '패스워드는 특수문자,영어,숫자로 공백없이 8~20글자로 작성해주세요.'
      });
	  return false;
	 }else if(num < 0 || eng < 0 || spe < 0 ){
	  $('#m_password').attr("autofocus",true);
	  Swal.fire({
          icon: 'warning',
          title: '패스워드를 확인해주세요.',
          text: '패스워드는 특수문자,영어,숫자로 공백없이 8~20글자로 작성해주세요.'
      });
	  return false;
	 }else {
		 Swal.fire({
	          icon: 'success',
	          title: '패스워드 변경완료.',
	          text: '패스워드 확인'
	      });
		$('#m_pass').val("1");
		pwChange();
	    return true;
	 }
}


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
			 Swal.fire({
		          icon: 'success',
		          title: '회원정보 수정완료.',
		          text: '회원정보 수정이 성공적으로 완료되었습니다'
		      });
		}
	});
}
 
 

</script>
</body>

</html>