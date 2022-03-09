<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
    <head>
        <title>+82Trip</title>
    	<style>
    	* {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
}
.wrap {
    height: 100%;
    width: 100%;
    margin-top : 58px;
    background-image: url("../resources/member/로그인사진.jpg");
    background-position: center;
    background-size: cover;
    position: relative;
}
.form-wrap {
    width: 380px;
    height: 480px;
    position: relative;
    margin: 6% auto;
    background: #fff;
    padding: 5px;
    overflow: hidden;
}
.button-wrap {
    width: 250px;
    margin: 35px auto;
    position: relative;
    box-shadow: 0 0 600px 9px #fcae8f;
    border-radius: 30px;
}
.togglebtn {
    padding: 10px 30px;
    cursor: pointer;
    background: transparent;
    border: 0;
    outline: none;
    position: relative;
    
}
#btn {
    top: 0;
    left: 0;
    position: absolute;
    width: 140px;
    height: 100%;
    background: linear-gradient(to right, #75CFB8, #BBDFC8);
    border-radius: 30px;
    transition: .5s;
}
.input-group1 {
    top: 10px;
    position: relative;
    width: 280px;
    transition: .5s;
}
.input-group2 {
    top: -150px;
    position: relative;
    width: 280px;
    transition: .5s;
    margin-top:-20px;
}
.input-field {
    width: 100%;
    padding: 10px 0;
    margin: 5px 0;
    border: none;
    border-bottom: 1px solid #999;
    outline: none;
    background: transparent;
}
.submit {
    width: 100%;
    padding: 10px 30px;
    cursor: pointer;
    display: block;
    margin: auto;
    background: linear-gradient(to right, #75CFB8, #BBDFC8);
    border: 0;
    outline: none;
    border-radius: 30px;
}
.checkbox {
    margin: 30px 10px 30px 0;
}
span {
    color: #777;
    font-size: 12px;
    bottom: 3px;
    position: relative;

}
#login {
    left: 50px;
}
#register {
    left: 450px;
} 

    	</style>
    </head>
     <body>
     <div class="header" style="position: sticky; width: 100%; z-index: 10; top: 0px; background-color: white; margin-top: -50px;">
	<%@include file="../header1.jsp" %>
	  </div>	
     	<div class="wrap">
      		<div class="form-wrap">
                <div class="button-wrap">
                    <div id="btn"></div>
                    <button type="button" class="togglebtn" onclick="login()">LOG IN</button>
                    <button type="button" class="togglebtn" onclick="register()" style="float: right;">FORGOT?</button>
                </div>
                <form id="login" action="/memberLogin1" class="input-group1" method="post">
                	<input type="text" class="input-field" placeholder="User Id" name="m_id" required>
                    <input type="password" class="input-field" placeholder="Enter Password" name="m_password" required>
                    <input type="hidden" id="check" value="${msg}">
                    <p style="display:none; color:red; margin-bottom: 0;" id="check2" >아이디 또는 비밀번호를 확인해주세요</p><br>
                    <a href="javascript:void(0);" onclick="register()" style="margin-bottom: 1rem;">비밀번호를 잊어버리셨나요?</a><br>
      
                    <button class="submit">로그인</button>
                </form>
                <form id="register" action="/memberFind" class="input-group2" method="post">
                    <input type="hidden" id="check1" value="${msg1}" disabled="disabled">
                    <input type="text" class="input-field"  placeholder="User Id" name="m_id" required>
                    <input type="email" class="input-field"  placeholder="Your Email" name="m_email" required>
                    <input type="hidden" id="check4" value="${msg2}">
                    <input type="hidden" id="check5" value="${msg3}">
                    <input type="hidden" id="check7" value="${msg4}">
                   	<p style="display:none; color:red; margin-bottom: 0;" id="check3" >탈퇴된 회원입니다 임시비밀번호를 발급받아 임시계정으로 전환해주세요</p><br>
                    <p style="display:none; color:red; margin-bottom: 0;" id="check6" >회원가입시 입력한 이메일을 입력해주세요</p><br>
                    <a href="/memberJoin" style="margin-bottom: 1rem;">회원가입하러가기</a>
                    <button class="submit">임시비밀번호발급</button>
                </form>
            </div>
        </div>
       
     <div style="margin-top: 100px;">
    <%@include file="../footer.jsp" %>  
     </div>  
        <script>
            var x = document.getElementById("login");
            var y = document.getElementById("register");
            var z = document.getElementById("btn");
            
            
            function login(){
                x.style.left = "50px";
                y.style.left = "450px";
                z.style.left = "0";
            }

            function register(){
                x.style.left = "-400px";
                y.style.left = "50px";
                z.style.left = "110px";
            }
        </script>
        <script>
        window.onload = function(){
        	if($('#check').val()=="1"){
        		$('#check2').show();
        	}else if($('#check4').val()=="1"){
        		 register();
        		$('#check3').show();
        	}else if($('#check5').val()=="1"){
        		register();
        		$('#check6').show();
        	}else if($('#check7').val()=="1"){
        		register();
        		$('#check6').show();
        	}
        }
        
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
        </script>
    </body>
</html> 