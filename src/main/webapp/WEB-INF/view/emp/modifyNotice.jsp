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
		<h1>modifyNotice</h1>
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
		<hr>
		<table>
			<tr>
				<th>noticeCode</th>
				<td>${notice.noticeCode}</td>
			</tr>
			<tr>
				<th>noticeTitle</th>
				<td>${notice.noticeTitle}</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td>${notice.noticeContent}</td>
			</tr>
			<tr>
				<th>empId</th>
				<td>${notice.empId}</td>
			</tr>
		</table>
		<button type="button">수정</button>
	</div>
</body>
</html>