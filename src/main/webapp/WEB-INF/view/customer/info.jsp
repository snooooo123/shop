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
	<h1>info</h1>
	<div class="header-container">
		<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>		
		<div class="customer-info">
				${loginCustomer.customerName}님 반갑습니다.
				(point : ${loginCustomer.point})
				<a href="${pageContext.request.contextPath}/customer/customerlogout">로그아웃</a>
		</div>
	</div>
	<hr>
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>${customer.customerId}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td> </td>
		</tr>
		<tr>
			<th>성함</th>
			<td>${customer.customerName}</td>
		</tr>
		<tr>
			<th>핸드폰 번호</th>
			<td>${customer.customerPhone}</td>
		</tr>
	</table>
</body>
</html>