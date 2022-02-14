<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="./bootStrap.jsp"%>
	<div class="member-login">
		<div class="container">
			<h2>임시비밀번호발급</h2>
			<h3>${msg2}</h3>
			<form action="/member/find" method="post">
				<table>
					<tr>
						<td>회원가입한 아이디</td>
						<td><input type="text" name="m_id" required="required">
						</td>
					</tr>
					<tr>
						<td>회원가입시 입력한 이메일</td>
						<td><input type="text" name="m_email" required="required"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="임시비밀번호발급"></td>
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