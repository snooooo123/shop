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
	<h1>empLsit</h1>
		<!-- emp menu include -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
		<hr>
		
		<div>
			<!-- 
				1) 리스트
				2) (비)활성화
				3) 추가
			 -->
			${empList.size()}
			<a href="${pageContext.request.contextPath}/emp/addEmp">사원추가</a>
			<table border="1">
				<tr>
					<td>empCode</td>
					<td>empId</td>
					<td>empName</td>
					<td>createdate</td>
					<td>활성화/비활성화</td>
				</tr>
				
				<c:foreach var="" items="${empList}">
					<tr>
						<td>${e.empCode}</td>
						<td>${e.empId}</td>
						<td>${e.empName}</td>
						<td>${e.createdate}</td>
						<td>${e.active == 0?"비활성화":"활성화"}</td>
					</tr>
				</c:foreach>	
			</table>
		</div>
</body>
</html>