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
	.member-login{
		display : flex;
		padding-bottom: 20px;
	}
	.container{
		margin:auto;
		border:none;
	}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="./bootStrap.jsp"%>
	<div class="member-login">
		<div class="container">
			<h2>로그인</h2>
			<h3>${msg1 }</h3>
			<h4>${msg2 }</h4>
			<form action="member/login" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="m_id" required="required">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="m_password" required="required"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="로그인"></td>
					</tr>
					<tr>
						<td><a href="memberFind">회원정보찾기</a></td>
						<td><a href="memberJoin">회원가입</a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<%@include file="../footer.jsp" %>
</body>
</html>