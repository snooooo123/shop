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
				3) 사원추가
			 -->
			<a href="${pageContext.request.contextPath}/emp/addEmp">사원추가</a>
			<table border="1">
				<tr>
					<td>empCode</td>
					<td>empId</td>
					<td>empName</td>
					<td>createdate</td>
					<td>활성화/비활성화</td>
				</tr>
				
				<c:forEach var="e" items="${empList}">
					<tr>
						<td>${e.empCode}</td>
						<td>${e.empId}</td>
						<td>${e.empName}</td>
						<td>${e.createdate}</td>
						<td>
							<a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&currentActive=${e.active}">
								${e.active == 0?'비활성화':'활성화'}
							</a>
						</td>
					</tr>
				</c:forEach>	
			</table>
			
			<div>
				<c:if test="${currentPage>1}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage-1}">[이전]</a>
				</c:if>
					${currentPage}
				<c:if test="${currentPage<lastPage}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage+1}">[다음]</a>
				</c:if>
			</div>			
		</div>
</body>
</html>