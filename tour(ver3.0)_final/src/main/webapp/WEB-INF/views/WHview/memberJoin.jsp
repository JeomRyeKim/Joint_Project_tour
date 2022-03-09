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
  <title>+82Trip</title>
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
 .form-control1234{
    width: 36%;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
 
  </style>
  
</head>

<body>
 <div class="header" style="position: sticky; width: 100%; z-index: 10; top: 0px; background-color: white; margin-top: -50px;">
	<%@include file="../header1.jsp" %>
</div>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-6" style="margin-left: 25%; background: linear-gradient(to right, #fffaf7, #fff5f3);">
        <h4 class="mb-3">회원가입</h4>
        <form class="validation-form" action="/member/join" method="post" onsubmit="return check()">
          <div class="row">
            <div class="mb-3">
              <label for="name">아이디</label><button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px; background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="idCheck()"> Id 중복검사 </button>
              <input type="text" class="form-control" id="m_id" name="m_id" placeholder="Id를 입력해주세요" required>
              <input type="hidden" id="m_idCheck2">
            </div>
            <div class="mb-3">
              <label for="password">비밀번호</label><button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px;  background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="chkPW()">비밀번호검사</button>
              <input type="password" class="form-control" id="m_password" name="m_password" placeholder="비밀번호는 숫자,영어,특수문자를 조합해 8자이상으로 작성해주세요" required>
              <input type="hidden" id="m_pass">
            </div>
          </div>
           <div class="mb-3">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control"  name="m_nickname" placeholder="닉네임을 입력해주세요" required>
           </div>
           <div class="mb-3">
            <label for="email">생일</label>
            <input type="date" name = "m_birth" class="form-control" required>
           </div>
		  <div class="mb-3">
            <label for="email">이메일</label><button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px; background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="mailFormCheck()"> 이메일 인증 </button>
            <input type="email" class="form-control" id="m_email" name="m_email" placeholder="you@example.com" required>
           <input type="hidden" id="m_emailval1">
           </div>
		  <div class="mb-3">
            <label for="emailcheck">인증번호확인</label><button type="button" id="m_idCheck" class="btn text-white" style="float: right; width:130px; background: linear-gradient(to right, #75CFB8, #BBDFC8);" onclick="emailCheck2()">인증번호확인</button>
            <input type="text" class="form-control" id="m_email2" placeholder="메일로받은 인증번호를 입력해주세요" required>
         	<input type="hidden" id="m_email3" >
		    <input type="hidden" id="m_emailval2">
           </div>
		
          <div class="mb-3" style="display: inline-block;">
            <label for="address">전화번호</label>
            <select id="m_phone1" name="m_phone1" required="required">
					<option value="010">010</option>
					<option value="010">011</option>
					<option value="010">017</option>
					<option value="010">019</option>
			</select>-
			<input type="text"  class="form-control1234" name="m_phone2" required="required">-
			<input type="text"  class="form-control1234" name="m_phone3" required="required">
          	</div>
          
          <div class="mb-3">
            <label for="address2">성별<span class="text-muted"></span></label>
            <input type="radio"  name="m_gender" value="남성" required="required">남성
            <input type="radio"  name="m_gender" value="여성" required="required">여성
          </div>
          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          <div class="mb-4"></div>
          <button class="btn text-white btn-lg btn-block" style=" background: linear-gradient(to right, #75CFB8, #BBDFC8);" type="submit">가입 완료</button>
        </form>
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
				Swal.fire({
			          icon: 'warning',
			          title: '이메일주소가 올바르지않습니다.',
			          text: '유효한 이메일 주소를 입력해주세요.'
			      });
				$('#m_email').attr("autofocus",true);
				return false;
			}else{
				 Swal.fire({
		              icon: 'success',
		              title: '인증번호 발송완료.',
		              text: '입력한 이메일에서 인증번호를 확인해주세요.'
		          });
				$('#m_email3').val(data1);
				$('#m_emailval1').val("1");
			}
		}
	});
	
}
//이메일로 보낸 인증번호랑 입력한 인증번호가 같은지 확인하는메소드
function emailCheck2(){
	var m_email2 = $('#m_email2').val();
	var m_email3 = $('#m_email3').val();
	if(m_email2==m_email3&&m_email2!=""&&m_email3!=""){
		Swal.fire({
            icon: 'success',
            title: '인증번호 확인.',
            text: '확인 완료되었습니다.'
        });
		$('#m_email2').attr("disabled",true);
		$('#m_emailval2').val("1");
		return true;
	}else{
		Swal.fire({
            icon: 'warning',
            title: '인증번호 확인실패.',
            text: '이메일에서 인증번호를 확인해주세요.'
        });
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
				Swal.fire({
		              icon: 'warning',
		              title: '중복된 아이디가 있습니다.',
		              text: '다른아이디를 입력해주세요.'
		          });
				$('#m_id').attr("autofocus",true);	
				return false;
			}else{
				Swal.fire({
		              icon: 'success',
		              title: '아이디 중복체크 완료.',
		              text: '아이디를 사용가능합니다.'
		          });
				$('#m_idCheck2').val("1");
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
	          title: '패스워드 검사완료.',
	          text: '패스워드 확인'
	      });
		$('#m_pass').val("1");
	    return true;
	 }
}


function check() {
	 if(!$('#m_idCheck2').val()) {
		 Swal.fire({
	          icon: 'warning',
	          title: '아이디 중복검사를 확인해주세요',
	          text: '아이디 중복검사를 먼저 실행해주세요'
	      });
		 return false;
	}else if(!$('#m_pass').val()){
		Swal.fire({
	          icon: 'warning',
	          title: '패스워드 검사를 확인해주세요.',
	          text: '패스워드 검사를 먼저 실행해주세요.'
	      });
		return false;
	}else if(!$('#m_emailval1').val()){
		Swal.fire({
	          icon: 'warning',
	          title: '이메일 인증 검사를 확인해주세요',
	          text: '이메일 인증 검사를 먼저 실행해주세요.'
	      });
		return false;
	}else if(!$('#m_emailval2').val()){
		Swal.fire({
	          icon: 'warning',
	          title: '이메일 인증번호 확인 검사를 해주세요.',
	          text: '이메일 인증번호 확인을 먼저 실행해주세요.'
	      });
		return false;
	}
	 else return true;
}
 
 

</script>
</body>

</html>