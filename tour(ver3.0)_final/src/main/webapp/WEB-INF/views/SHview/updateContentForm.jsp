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
.update_image{
	width:400px;
	height:200px;
}
</style>
</head>
<body>
	<%@include file="../header1.jsp"%>
	<%@include file="../header2.jsp"%>
	<h1 style="text-align: center; padding: 50px 0;">컨텐츠 수정</h1>
	<div class="container1">
		<div class="form_container">
			<form action="/updateContent" method="post" enctype="multipart/form-data" target="_self">
				<input type="hidden" name="c_image1" value="${con.c_image1}">
				<input type="hidden" name="c_image2" value="${con.c_image2}">
				<input type="hidden" name="c_image3" value="${con.c_image3}">
				<input type="hidden" name="c_no" value="${con.c_no}">				
				<table>
					<tr>
						<td>컨텐츠 이름:</td>
						<td><input type="text" name="c_title" value="${con.c_title}"></td>
					</tr>
					<tr>
						<td>주소:</td>
						<td><input type="text" name="c_address" value="${con.c_address}"></td>
					</tr>
					<tr>
						<td>지역:</td>
						<td>
							<select name="c_local" id="local_sel">
								<c:forEach var="local" items="${local}">
									<option value="${local.c_local}" 
									<c:if test ="${con.c_local eq local.c_local}">selected="selected"</c:if>>
									${local.c_local}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>카테고리:</td>
						<td>
							<select name="c_category" id="local_sel">
								<c:forEach var="category" items="${category}">
									<option value="${category.c_category}" 
									<c:if test ="${con.c_category eq category.c_category}">selected="selected"</c:if>>
									${category.c_category}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>지역설명:</td>
						<td><textarea name="c_description" cols="50" rows="5">${con.c_description}</textarea></td>
					</tr>
					<tr>
						<td>우편번호:</td>
						<td><input type="text" name="c_zipcode" value="${con.c_zipcode}"></td>
					</tr>
					<tr>
						<td>위도:</td>
						<td><input type="text" name="c_map_x" value="${con.c_map_x}"></td>
					</tr>
					<tr>
						<td>경도:</td>
						<td><input type="text" name="c_map_y" value="${con.c_map_y}"></td>
					</tr>
					<tr>
						<td>시군구코드:</td>
						<td><input type="text" name="c_sigungu_code" value="${con.c_sigungu_code}"></td>
					</tr>
					<tr>
						<td>이미지1:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td>현재 이미지:</td>
						<td><img class="update_image" src="resources/image/${con.c_local}/${con.c_image1}"></td>
					</tr>
					<tr>
						<td>이미지2:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td>현재 이미지:</td>
						<td><img class="update_image" src="resources/image/${con.c_local}/${con.c_image2}"></td>
					</tr>
					<tr>
						<td>이미지3:</td>
						<td><input type="file" name="c_image"></td>
					</tr>
					<tr>
						<td>현재 이미지:</td>
						<td><img class="update_image" src="resources/image/${con.c_local}/${con.c_image3}"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="수정하기" ></td>
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