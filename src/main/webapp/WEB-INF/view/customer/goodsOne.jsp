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
	<h1>goodsOne</h1>
	<!-- customer menu -->
	<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
	<table>
		<tr>
			<td colspan="2">
				<img src="${pageContext.request.contextPath}/upload/${goods.filename}" style="width:100px">
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${goods.goodsName}</td>
		</tr>
		<tr>
			<th>가격</th>
			<td>${goods.goodsPrice}</td>
		</tr>
		<tr>
			<th>적립률</th>
			<td>${goods.pointRate}</td>
		</tr>
	</table>
</body>
</html>