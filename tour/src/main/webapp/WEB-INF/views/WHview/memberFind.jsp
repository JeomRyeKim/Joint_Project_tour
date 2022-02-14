<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
	display: flex;
	padding-bottom: 20px;
}

.form_container {
	margin: auto;
	border:none;
}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="./bootStrap.jsp"%>
	<div class="container">
		<div class="form_container">
			<form action="">
				<table>
					<tr>
						<th colspan="2"><h1>여기에서 비밀번호찾기 힌트로찾기,메일로찾기</h1></th>
					</tr>
					<tr>
						<td>비밀번호 힌트</td>
						<td><input type="text" name="" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호 답</td>
						<td><input type="text" name="" required="required"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="비밀번호찾기"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<%@include file="../footer.jsp" %>
</body>
</html>