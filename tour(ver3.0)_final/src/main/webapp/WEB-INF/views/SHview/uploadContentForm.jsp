<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>+82Trip</title>
<style>
.container1 {
	display: flex;
	padding-bottom: 20px;
}

.form_container {
	margin: auto;
	border: none;
}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>
	<h1 style="text-align: center; padding: 50px 0;">컨텐츠 등록</h1>
	<div class="container1">
		<div class="form_container">
			<form action="/uploadContent" method="post" enctype="multipart/form-data" target="_self">
				<table>
					<tr>
						<td>컨텐츠 이름:</td>
						<td><input type="text" name="c_title" required="required"></td>
					</tr>
					<tr>
						<td>주소:</td>
						<td><input type="text" name="c_address" required="required"></td>
					</tr>
					<tr>
						<td>지역:</td>
						<td>
							<select name="c_local" id="local_sel">
								<option value="서울" selected>서울</option>
								<option value="경기도">경기도</option>
								<option value="강원도">강원도</option>
								<option value="전라도">전라도</option>
								<option value="경상도">경상도</option>
								<option value="제주도">제주도</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>카테고리:</td>
						<td>
							<select name="c_category" id="local_sel">
								<option value="관광지" selected>관광지</option>
								<option value="음식점">음식점</option>
								<option value="숙소">숙소</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>지역설명:</td>
						<td><textarea name="c_description" cols="50" rows="5"></textarea></td>
					</tr>
					<tr>
						<td>우편번호:</td>
						<td><input type="text" name="c_zipcode" required="required"></td>
					</tr>
					<tr>
						<td>위도:</td>
						<td><input type="text" name="c_map_x" required="required"></td>
					</tr>
					<tr>
						<td>경도:</td>
						<td><input type="text" name="c_map_y" required="required"></td>
					</tr>
					<tr>
						<td>시군구코드:</td>
						<td><input type="text" name="c_sigungu_code"
							required="required"></td>
					</tr>
					<tr>
						<td>이미지1:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td>이미지2:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td>이미지3:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="컨텐츠 등록"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">

	</script>


	<%@include file="../footer.jsp"%>
</body>
</html>