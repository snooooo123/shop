<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<h1>addNotice</h1>
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
		<hr>
		<form method="post" action="${pageContext.request.contextPath}/emp/addNotice">
			<input type="hidden" name="empCode" value="${loginEmp.empCode}">
			<table border="1">
				<tr>
					<th>제목</th>
					<td><input type="text" name="noticeTitle"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="15" cols="80" name="noticeContent"></textarea></td>
				</tr>
			</table>
		
		</form>		
	</div>
</body>
</html>