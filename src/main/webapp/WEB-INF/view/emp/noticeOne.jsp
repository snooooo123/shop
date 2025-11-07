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
		<h1>noticeOne</h1>
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
		<hr>
		<table border="1">
			<tr>
				<th>noticeCode</th>
				<td>${notice.noticeCode}</td>
			</tr>
			<tr>
				<th>empId</th>
				<td>${notice.empId}</td>
			</tr>
			<tr>
				<th>noticeTitle</th>
				<td>${notice.noticeTitle}</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td>${notice.noticeContent}</td>
			</tr>								
		</table>
		<a href="${pageContext.request.contextPath}/emp/modifyNotice?noticeCode=${notice.noticeCode}">수정</a>
		<a href="${pageContext.request.contextPath}/emp/removeNotice?noticeCode=${notice.noticeCode}">삭제</a>
	</div>
</body>
</html>